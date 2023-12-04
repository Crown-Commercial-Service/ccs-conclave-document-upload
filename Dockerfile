FROM public.ecr.aws/docker/library/ruby:3.0.3-alpine
WORKDIR /app
RUN apk upgrade && apk add build-base curl libpq-dev nodejs nghttp2
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 4 --retry 5
COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
