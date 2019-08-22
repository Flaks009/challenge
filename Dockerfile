FROM ruby:2.6.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /challenge-fretadao
WORKDIR /challenge-fretadao
COPY Gemfile /challenge-fretadao/Gemfile
COPY Gemfile.lock /challenge-fretadao/Gemfile.lock
RUN bundle install
COPY . /challenge-fretadao

# Add a script to be executed every time the container starts.

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
