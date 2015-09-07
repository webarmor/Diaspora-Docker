# Diaspora-Docker

## HOW TO

See [HOW TO Wiki](https://github.com/Chocobozzz/Diaspora-Docker/wiki/How-To)

## Update your image


Build the immunio docker image (from checkout directory):

    # ./build_immunio.sh

This will crunch for a while and then generate an image named immunio/diaspora

You can run it like so:

	# docker run --name=diaspora --rm -it -p 10080:3000 immunio/diaspora:latest

Or use the provided script (edit the paths to suit your system first!):

	# ./run_diaspora.sh

Enjoy!
