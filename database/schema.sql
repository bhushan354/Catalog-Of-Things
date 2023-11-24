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

CREATE TABLE Books (
    id SERIAL PRIMARY KEY,
    publisher VARCHAR(255),
    cover_state VARCHAR(255),
    publish_date DATE
);

CREATE TABLE Labels (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    color VARCHAR(255)
);
