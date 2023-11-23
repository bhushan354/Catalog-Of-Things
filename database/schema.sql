CREATE DATABASE catalog_of_my_things;

\c catalog_of_my_things;

CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    last_played_at DATE,
    multiplayer BOOLEAN,
    publish_date DATE,
    author_id INTEGER REFERENCES authors(id) 
);
