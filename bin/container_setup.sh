#! /bin/bash
# Set environment to prevent this error https://github.com/rails/rails/issues/34041
bin/rails db:environment:set RAILS_ENV=development

# Creating databases
VERBOSE=true bundle exec rails db:drop:all db:create db:migrate db:seed --trace

# remove server temp file
rm tmp/pids/server.pid

# Starting server
bundle exec rails s -b 0.0.0.0
