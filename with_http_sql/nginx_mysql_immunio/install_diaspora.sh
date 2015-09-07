#!/bin/bash

cd diaspora

printf 'key: "test-key"\nsecret: "test-secret"\nhello_url: "https://agent-stg.webarmor.io"' > config/immunio.yml \
 && echo "require 'immunio'" >> config/additional_environment.rb

# RUN sed -i 's/gem "rails", "3.2.21"/gem "rails", "3.2.17"/g' Gemfile
cat Gemfile
printf 'gem "newrelic_rpm"\ngem "immunio", git: "https://immunioro:25a4a37c53b42e7c2eaa0aeecca2b548b85159f8@github.com/webarmor/agent-ruby.git", submodules: true' >> Gemfile
#RUN bundle update
#RUN bundle install


RAILS_ENV=production bundle install --without test development
RAILS_ENV=production bundle exec rake db:create db:schema:load
bundle exec rake assets:precompile
