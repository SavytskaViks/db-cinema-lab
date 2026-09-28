CREATE DATABASE cinema_db;
\c cinema_db

CREATE TABLE cinema (
    cinema_id       SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    district        VARCHAR(100) NOT NULL,
    address         VARCHAR(200) NOT NULL,
    category        VARCHAR(50)  NOT NULL,
    status          VARCHAR(20)  NOT NULL DEFAULT 'Active'
                        CHECK (status IN ('Active', 'Under Repair', 'Closed'))
);

CREATE TABLE hall (
    hall_id         SERIAL PRIMARY KEY,
    name            VARCHAR(50) NOT NULL,
    capacity        INTEGER NOT NULL CHECK (capacity > 0),
    cinema_id       INTEGER NOT NULL
                        REFERENCES cinema (cinema_id)
                        ON DELETE CASCADE,
    UNIQUE (cinema_id, name)
);

CREATE TABLE film (
    film_id             SERIAL PRIMARY KEY,
    title               VARCHAR(200) NOT NULL,
    director            VARCHAR(150) NOT NULL,
    cinematographer     VARCHAR(150),
    duration            INTEGER NOT NULL CHECK (duration > 0),
    has_awards          BOOLEAN NOT NULL DEFAULT FALSE,
    rental_status       BOOLEAN NOT NULL DEFAULT TRUE,
    promo_image         VARCHAR(500) 
);

CREATE TABLE genre (
    genre_id        SERIAL PRIMARY KEY,
    name            VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE country (
    country_id      SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE actor (
    actor_id        SERIAL PRIMARY KEY,
    full_name       VARCHAR(150) NOT NULL
);

CREATE TABLE session (
    session_id      SERIAL PRIMARY KEY,
    start_time      TIMESTAMP NOT NULL,
    base_price      NUMERIC(8,2) NOT NULL CHECK (base_price > 0),
    film_id         INTEGER NOT NULL
                        REFERENCES film (film_id)
                        ON DELETE CASCADE,
    hall_id         INTEGER NOT NULL
                        REFERENCES hall (hall_id)
                        ON DELETE CASCADE,
    UNIQUE (hall_id, start_time)
);

CREATE TABLE ticket (
    ticket_id       SERIAL PRIMARY KEY,
    seat_number     INTEGER NOT NULL CHECK (seat_number > 0),
    status          VARCHAR(20) NOT NULL DEFAULT 'Available'
                        CHECK (status IN ('Sold', 'Booked', 'Available')),
    session_id      INTEGER NOT NULL
                        REFERENCES session (session_id)
                        ON DELETE CASCADE,
    UNIQUE (session_id, seat_number)
);

CREATE TABLE film_genre (
    film_id         INTEGER NOT NULL
                        REFERENCES film (film_id)
                        ON DELETE CASCADE,
    genre_id        INTEGER NOT NULL
                        REFERENCES genre (genre_id)
                        ON DELETE CASCADE,
    PRIMARY KEY (film_id, genre_id)
);

CREATE TABLE film_country (
    film_id         INTEGER NOT NULL
                        REFERENCES film (film_id)
                        ON DELETE CASCADE,
    country_id      INTEGER NOT NULL
                        REFERENCES country (country_id)
                        ON DELETE CASCADE,
    PRIMARY KEY (film_id, country_id)
);

CREATE TABLE film_actor (
    film_id         INTEGER NOT NULL
                        REFERENCES film (film_id)
                        ON DELETE CASCADE,
    actor_id        INTEGER NOT NULL
                        REFERENCES actor (actor_id)
                        ON DELETE CASCADE,
    PRIMARY KEY (film_id, actor_id)
);