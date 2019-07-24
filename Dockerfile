FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client
RUN mkdir /blog_rails

WORKDIR /blog_rails

COPY Gemfile Gemfile.lock ./
COPY ./config/database.yml.sample ./config/database.yml

RUN bundle install
ADD . /blog_rails