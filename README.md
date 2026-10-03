## Purpose

Lab 2: logical design of a relational database "Cinema reference service" (variant 10).

## Usage

Requires Docker (https://docs.docker.com/get-docker/).

Create and start the database:

    ./_create.sh

Open psql in another terminal:

    ./_psql.sh
    \c cinema_db
    \dt

Run a sample query:

    \i /repo/sample_query_1.sql

## Files

- schema.sql – tables and constraints
- data.sql – test data
- sample_query_1..7.sql – SELECT queries from the variant task
