FROM ruby:2.6.2

RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs yarn

#ADD the engines!
#Add Gemfile and gemfile locks 
COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install
ADD . /usr/src/app

EXPOSE 3000
CMD ["bin/rails","s","-b","0.0.0.0"]
