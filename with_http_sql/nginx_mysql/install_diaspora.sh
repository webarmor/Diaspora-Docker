#!/bin/bash

cd diaspora

RAILS_ENV=production bundle install --without test development
RAILS_ENV=production bundle exec rake db:create db:schema:load
bundle exec rake assets:precompile
