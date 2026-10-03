      *** Lab 2: Logical design of a relational database ***
      *** Variant 10: Cinema reference service           ***


This project is based on the sample project lab2_docker_sample:
   https://github.com/alysenko4317/ntu-db/tree/main/lab2_docker_sample

=============================================

## Description

The database stores information about cinemas of the city, their halls,
films, film sessions (repertoire) and tickets. It is designed for the
staff of the cinema reference service.

Tables: cinema, hall, film, genre, country, actor, session, ticket,
        film_genre, film_country, film_actor.

=============================================

## Usage

This project uses Docker to run the PostgreSQL database, to avoid installing
a bunch of packages on your machine and potentially running into different
platform and environment issues.

To create the container and the database (schema.sql and data.sql are
executed automatically) use:
   ./_create.sh          (Linux / macOS)
   _create.bat           (Windows)
   ./_create_under_gitbash.sh   (Git Bash on Windows)

To open a psql prompt in that container, run the following in another terminal:
   ./_psql.sh            (Linux / macOS / Git Bash)
   _psql.bat             (Windows)

To select the project database use:
   \c cinema_db
   HINT: \l displays list of databases created

Check that all is going well:
   \dt      (will list all created tables)

To run SQL statements located in .sql files in psql use:
   \i /repo/sample_query_1.sql

=============================================

## Sample queries (variant 10)

   sample_query_1.sql - repertoire of a cinema
   sample_query_2.sql - address and district of a cinema
   sample_query_3.sql - number of free seats for a session in a given cinema
   sample_query_4.sql - ticket price for a session in a given cinema
   sample_query_5.sql - genre, country of production and director of a film
   sample_query_6.sql - films with awards: when and in which cinemas they are shown
   sample_query_7.sql - cinemas where a film of the given genre (comedy)
                        is shown on the specified sessions

=============================================

Other psql commands that can be useful for you:

Listing databases:    \l
Switching Databases:  \c database
Listing Tables:       \dt
List of Relations:    \d
Quit:                 \q
Execute query:        \i /repo/sample_query_1.sql
List of roles:        \du
Show current user:    :whoami   (short alias defined in .psqlrc)

   NOTE: you can also connect to PostgreSQL running in the container
         from the host machine using port 5434 (instead of the default 5432);
         password for user 'postgres' is set to 'foo'
         (all these parameters are configured in _create.sh, so you can
         change them if you need).
         For example, you can use the PgAdmin GUI client installed on the host
         or an embedded DBMS client, for example in IntelliJ or PyCharm.

   NOTE: don't forget to put ; at the end of each SQL statement
         while typing in psql shell.

=============================================
