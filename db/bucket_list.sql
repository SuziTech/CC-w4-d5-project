DROP TABLE IF EXISTS travels;
DROP TABLE IF EXISTS experiences;
DROP TABLE IF EXISTS destinations;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  home_location VARCHAR(1024)
);

CREATE TABLE destinations (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  priority INT2,
  reason_to_go TEXT,
  travel_method TEXT,
  visited_or_not BOOLEAN
);

CREATE TABLE experiences (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  description TEXT,
  destination_id INT4 REFERENCES destinations(id)
);

CREATE TABLE travels (
  id SERIAL4 PRIMARY KEY,
  user_id INT4 REFERENCES users(id),
  destination_id INT4 REFERENCES destinations(id),
  travel_date DATE
);
