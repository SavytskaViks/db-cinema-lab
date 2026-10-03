#!/bin/bash
docker run \
  --name=lab2 \
  --rm \
  --volume="$(pwd)/schema.sql:/docker-entrypoint-initdb.d/1-schema.sql" \
  --volume="$(pwd)/data.sql:/docker-entrypoint-initdb.d/2-data.sql" \
  --volume="$(pwd):/repo" \
  --env=PSQLRC=/repo/.psqlrc \
  --env=POSTGRES_PASSWORD=foo \
  -p 5434:5432 \
  postgres:14.0 -c log_statement=all