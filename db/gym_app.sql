DROP TABLE IF EXISTS joinings;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS gym_courses;

CREATE TABLE members
(
  id SERIAL primary key,
  name VARCHAR(255) not null,
  surname VARCHAR(255) not null,
  premium BOOLEAN
);

CREATE TABLE gym_courses
(
  id SERIAL primary key,
  course_name VARCHAR(255) not null,
  capacity INT,
  offpeak BOOLEAN
);

CREATE TABLE joinings
(
  id SERIAL primary key,
  gym_course_id INT REFERENCES gym_courses(id),
  member_id INT REFERENCES members(id)
);
