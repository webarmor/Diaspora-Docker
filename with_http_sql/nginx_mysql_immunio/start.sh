
if [ -f agent-ruby/immunio.gemspec -a ! -f agent-ruby/lib/immunio/lua-hooks.so ]; then
  cd agent-ruby
  sudo -u diaspora -i bash -c "cd /home/diaspora/diaspora/agent-ruby; rvm all do bundle install; rvm all do rake compile"
  rake compile
  cd ..
fi

if [ -f agent-ruby/immunio.gemspec ] && ! grep -q 'path: "agent-ruby"' Gemfile; then
  sed -i 's/^gem "immunio".*$/gem "immunio", path: "agent-ruby"/' Gemfile
fi

sudo -u diaspora -i bash -c "cd /home/diaspora/diaspora/; rvm all do bundle update immunio"

/usr/bin/mysqld_safe &

/usr/bin/redis-server &

/usr/sbin/nginx &

sleep 5

sudo -E -u diaspora -i /home/diaspora/diaspora/script/server
