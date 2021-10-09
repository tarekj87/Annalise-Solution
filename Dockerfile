FROM ruby:2.5.1-alpine

ADD . /Sinatra-Docker

WORKDIR /Sinatra-Docker

RUN gem install bundler:1.17.3

RUN bundle install

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
