CREATE DATABASE cinema_db;
\c cinema_db

CREATE TABLE cinema_category (
    category_id         SERIAL PRIMARY KEY,
    name                VARCHAR(50) NOT NULL UNIQUE,
    price_coefficient   NUMERIC(4,2) NOT NULL CHECK (price_coefficient > 0)
);

CREATE TABLE cinema (
    cinema_id       SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    district        VARCHAR(100) NOT NULL,
    address         VARCHAR(200) NOT NULL,
    category_id     INTEGER NOT NULL
                        REFERENCES cinema_category (category_id),
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

CREATE TABLE repertoire (
    repertoire_id   SERIAL PRIMARY KEY,
    cinema_id       INTEGER NOT NULL
                        REFERENCES cinema (cinema_id)
                        ON DELETE CASCADE,
    film_id         INTEGER NOT NULL
                        REFERENCES film (film_id)
                        ON DELETE CASCADE,
    rental_cost     NUMERIC(10,2) NOT NULL CHECK (rental_cost > 0),
    show_start      DATE NOT NULL,
    show_end        DATE NOT NULL,
    status          VARCHAR(20) NOT NULL DEFAULT 'Active'
                        CHECK (status IN ('Active', 'Removed')),
    CHECK (show_end >= show_start),
    UNIQUE (cinema_id, film_id, show_start)
);

CREATE TABLE session (
    session_id          SERIAL PRIMARY KEY,
    start_time          TIMESTAMP NOT NULL,
    time_coefficient    NUMERIC(4,2) NOT NULL DEFAULT 1.00
                            CHECK (time_coefficient > 0),
    repertoire_id       INTEGER NOT NULL
                            REFERENCES repertoire (repertoire_id)
                            ON DELETE CASCADE,
    hall_id             INTEGER NOT NULL
                            REFERENCES hall (hall_id)
                            ON DELETE CASCADE,
    UNIQUE (hall_id, start_time)
);

CREATE TABLE ticket (
    ticket_id       SERIAL PRIMARY KEY,
    seat_number     INTEGER NOT NULL CHECK (seat_number > 0),
    status          VARCHAR(20) NOT NULL
                        CHECK (status IN ('Booked', 'Sold')),
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
    is_lead         BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (film_id, actor_id)
);

CREATE VIEW session_price AS
SELECT
    s.session_id,
    ROUND(r.rental_cost * 0.01 * cc.price_coefficient * s.time_coefficient, 2) AS ticket_price
FROM session s
JOIN repertoire       r  ON r.repertoire_id = s.repertoire_id
JOIN cinema           c  ON c.cinema_id     = r.cinema_id
JOIN cinema_category  cc ON cc.category_id  = c.category_id;

-- Тригер перевіряє сеанс перед додаванням або зміною:
-- 1) зал має належати кінотеатру, у репертуарі якого цей фільм;
-- 2) дата сеансу має бути в межах періоду показу.
-- Якщо умова не виконується, база відхиляє запис із помилкою.
CREATE FUNCTION check_session_consistency() RETURNS trigger AS $$
DECLARE
    rep         repertoire%ROWTYPE;
    hall_cinema INTEGER;
BEGIN
    SELECT * INTO rep FROM repertoire WHERE repertoire_id = NEW.repertoire_id;
    SELECT cinema_id INTO hall_cinema FROM hall WHERE hall_id = NEW.hall_id;

    IF rep.cinema_id <> hall_cinema THEN
        RAISE EXCEPTION 'Hall % does not belong to cinema % of repertoire entry %',
            NEW.hall_id, rep.cinema_id, NEW.repertoire_id;
    END IF;

    IF NEW.start_time::date NOT BETWEEN rep.show_start AND rep.show_end THEN
        RAISE EXCEPTION 'Session date % is outside the show period % - %',
            NEW.start_time::date, rep.show_start, rep.show_end;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_session_consistency
    BEFORE INSERT OR UPDATE ON session
    FOR EACH ROW EXECUTE FUNCTION check_session_consistency();

-- Тригер перевіряє квиток перед додаванням або зміною:
-- номер місця не може бути більшим за місткість залу сеансу.
CREATE FUNCTION check_ticket_seat() RETURNS trigger AS $$
DECLARE
    hall_capacity INTEGER;
BEGIN
    SELECT h.capacity INTO hall_capacity
    FROM session s
    JOIN hall h ON h.hall_id = s.hall_id
    WHERE s.session_id = NEW.session_id;

    IF NEW.seat_number > hall_capacity THEN
        RAISE EXCEPTION 'Seat % exceeds hall capacity %', NEW.seat_number, hall_capacity;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_ticket_seat
    BEFORE INSERT OR UPDATE ON ticket
    FOR EACH ROW EXECUTE FUNCTION check_ticket_seat();