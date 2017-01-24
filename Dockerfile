FROM ruby:2.1.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev memcached
RUN mkdir /ofn
WORKDIR /ofn

ENV VERSION v1.8.6

RUN wget https://github.com/openfoodfoundation/openfoodnetwork/archive/${VERSION}.tar.gz -O ofn.tgz
RUN tar xfzv ofn.tgz --strip-components=1

RUN bundle install

RUN gem install dalli

RUN rake assets:precompile

## load DB
#RUN rake db:schema:load
#RUN rake db:seed

## change dalli to memory_store
# config/environments/production.rb
#'config.cache_store = :memory_store'
