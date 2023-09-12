#!/bin/bash

COMMIT_HASH=$(git rev-parse --short HEAD)
export COMMIT_HASH

docker build -t ccs-conclave-document-upload:$COMMIT_HASH .

docker compose -f docker-compose.built.yml run -e DATABASE_CLEANER_ALLOW_PRODUCTION=true -e DATABASE_CLEANER_ALLOW_REMOTE_DATABASE_URL=true \
  -e CORS_ORIGINS="http://example.com,http://localhost:3000" ccs-conclave-document-upload \
  sh -c "rails db:create RAILS_ENV=test && rails db:schema:load RAILS_ENV=test && bundle exec rspec"

if [ $? -ne 0 ]; then
  echo "Tests failed! Exiting with status 1..."
  exit 1
fi
