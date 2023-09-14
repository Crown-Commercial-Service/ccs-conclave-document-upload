FROM ruby:3.0.3-alpine
WORKDIR /app

RUN apk add build-base libpq-dev

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 4 --retry 5

FROM ruby:3.0.3-alpine
WORKDIR /app

RUN apk add libpq-dev nodejs

COPY --from=0 /usr/local/bundle /usr/local/bundle

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
