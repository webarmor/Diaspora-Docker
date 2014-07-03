#!/bin/bash

rvm use 2.0.0-p353
cd diaspora

bundle install
bundle exec rake db:create db:schema:load
