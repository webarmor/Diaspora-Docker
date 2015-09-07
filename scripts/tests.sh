#!/bin/bash

ERR='\033[0;31m'
OK='\033[0;32m'
END='\033[m' # No Color

base_path=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
outputs_dir="$base_path/output"
build_command="$base_path/build.sh"
# Number of lines just for the menu, to skip it when we want to print errors
lines=$(( $(echo 0 | $build | wc -l) + 1 ))


print_help () {
  echo -e "./tests.sh [-c --clean] [-b --build] [-r --run]"
  echo -e "\tc, --clean: Clean all containers and clean images of chocobozzz/diaspora-docker"
  echo -e "\tb, --build: Make build tests" 
  echo -e "\tr, --run: Make run tests (images have to be already built)" 
}

# Clean all containers and clean images of chocobozzz/diaspora-docker
clean () {
  echo "########### Cleaning ###########"
  
  runnings=$(sudo docker ps -a | awk ' $1 != "CONTAINER" { print $1 } ')
  images=$(sudo docker images | egrep "(chocobozzz\/diaspora-docker)|(none)" | awk '{ print $3 }')

  for i in $runnings; do
    echo "Stopping and removing $i container."
    sudo docker stop $i && sudo docker rm $i
  done

  echo

  for i in $images; do
    echo "Removing $i image."
    sudo docker rmi $i
  done

  echo -e "\n\n"
}

# Make a build test according to the name of the build and its number (see build.sh)
# Print OK or FAILED
# Return the status code of the docker build
make_build_test () {
  echo "########### Building $1 ###########"
  
  sleep 2

  echo $2 | $build_command > "$outputs_dir/build/$(echo $1 | sed 's/\s/_/g')"

  if [ ${PIPESTATUS[1]} -ne 0 ] ; then
    printf "${ERR}FAILED${END}\n"
  else
    printf "${OK}OK${END}\n"
    echo -e $text
  fi
  
  echo -e "\n"

  return $?
}

# Abort the script if there is one error status as argument
check_build_error () {
  for err in $*; do
    if [ $err -ne 0 ]; then
      echo "Aborting..."
      exit -1
    fi
  done
}

# Make a run test according to an image name:tag
# Print OK or FAILED
# Write logs in output_dir/run
make_run_test() {
  echo "########### Testing image $1 ###########"
  
  echo -e "\nAcquiring sudo..."
  sudo echo -e "Sudo acquired, thanks !\n"
  sudo docker run --name test -a STDOUT -a STDERR -p 48880:80 -p 48443:443 $2 &> "$outputs_dir/run/running_servers/$(echo $1 | sed 's/\s/_/g')" &
  sudo echo -e "Docker image running\n"
  
  success=0
  for i in $(seq 0 30); do
    echo -n "."
    lines=$(curl -k https://localhost:48443 2>/dev/null | grep 'diaspora*' | wc -l)
    if [ $lines -gt 1 ]; then
      success=1
      curl -k https://localhost:48443 2>/dev/null > "$outputs_dir/run/success_pages/$(echo $1 | sed 's/\s/_/g')" 
      printf "${OK}OK${END}\n"
      break
    fi
    sleep 5
  done

  if [ $success -eq 0 ]; then 
    printf "${ERR}FAILED${END}\n"
  fi

  sudo docker stop test &> /dev/null
  sudo docker rm test &> /dev/null

  echo -e "\n\n"

  return $success
}

# Create the output directory and backup the old one
prepare_output_dir () {
  # Clean output directory
  if [ -d $outputs_dir ]; then
    if [ -d "${outputs_dir}.bak" ]; then
      rm -r "${outputs_dir}.bak"
    fi

    mv $outputs_dir "${outputs_dir}.bak"
  fi

  mkdir $outputs_dir
  mkdir "$outputs_dir/build"
  mkdir "$outputs_dir/run"
  mkdir "$outputs_dir/run/success_pages"
  mkdir "$outputs_dir/run/running_servers"
}


clean=false
build=false
run=false

for arg in $*; do
  if [[ $arg = "-c" || $arg = "--clean" ]]; then
    clean=true
  elif [[ $arg = "-b" || $arg = "--build" ]]; then
    build=true
  elif [[ $arg = "-r" || $arg = "--run" ]]; then
    run=true
  elif [[ $arg = "-h" || $arg = "--help" ]]; then
    print_help
    exit 0
  else
    echo "Unknow option: $arg"
    print_help
    exit -1
  fi
done

# Make the output directory
prepare_output_dir

# Clean previous builds
if [ $clean = true ]; then
  clean
fi

# Build tests
if [ $build = true ]; then
  # First pass
  make_build_test "without http and sql"               1
  check_build_error $?

  # Second pass
  make_build_test "with Apache and MySQL"              2
  ret1=$?
  make_build_test "with Apache and PostgreSQL"         3
  ret2=$?
  make_build_test "with NGinx and MySQL"               4
  ret3=$?
  make_build_test "with NGinx and PostgreSQL"          5
  ret4=$?
  make_build_test "with NGinx and MySQL (Development)" 6
  ret5=$?

  check_build_error $ret1 $ret2 $ret3 $ret4 $ret5

  # Third pass
  make_build_test "Apache and MySQL"                   7
  ret1=$?
  make_build_test "Apache and PostgreSQL"              8
  ret2=$?
  make_build_test "NGinx and MySQL"                    9
  ret3=$?
  make_build_test "NGinx and PostgreSQL"               10
  ret4=$?

  check_build_error $ret1 $ret2 $ret3 $ret4

fi


if [ $run = true ]; then
  make_run_test "Apache and MySQL"      "chocobozzz/diaspora-docker:apache_mysql"
  make_run_test "Apache and PostgreSQL" "chocobozzz/diaspora-docker:apache_postgre"
  make_run_test "NGinx and MySQL"       "chocobozzz/diaspora-docker:nginx_mysql"
  make_run_test "NGinx and PostgreSQL"  "chocobozzz/diaspora-docker:nginx_postgre"
  make_run_test "Dev NGinx and MySQL"   "chocobozzz/diaspora-docker:dev_nginx_mysql"
fi
