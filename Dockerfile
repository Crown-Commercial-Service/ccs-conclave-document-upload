FROM ruby:3.0.3

WORKDIR /app

# Temporarily comment out for speed
# RUN apt-get update && apt-get install -y \
#   build-essential \
#   nodejs

# COPY Gemfile Gemfile.lock ./
# RUN gem install bundler && bundle install --jobs 20 --retry 5

# COPY . .

# EXPOSE 3000

# CMD ["rails", "server", "-b", "0.0.0.0"]
