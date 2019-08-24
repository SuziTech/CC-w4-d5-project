DROP TABLE IF EXISTS experiences;
DROP TABLE IF EXISTS destinations;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id serial4 primary key,
  name VARCHAR(255),
  home_lacation VARCHAR(1024)
);

CREATE TABLE destinations (
  id serial4 primary key,
  name varchar(255),
  priority int2,
  reason_to_go text,
  travel_method text
);

CREATE TABLE experiences (
  id serial4 primary key,
  name VARCHAR(255),
  description text,
  FOREIGN KEY (id) REFERENCES (destinations)
)
