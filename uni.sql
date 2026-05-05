-- Step 1: Create Database
CREATE DATABASE UniversityDB;
USE UniversityDB;

-- Step 2: Create Tables

CREATE TABLE department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget DECIMAL(10,2)
);

CREATE TABLE course (
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    dept_name VARCHAR(50),
    credits INT,
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

CREATE TABLE instructor (
    ID INT PRIMARY KEY,
    name VARCHAR(50),
    dept_name VARCHAR(50),
    salary DECIMAL(10,2),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

CREATE TABLE section (
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    building VARCHAR(50),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE teaches (
    ID INT,
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES instructor(ID),
    FOREIGN KEY (course_id, sec_id, semester, year)
        REFERENCES section(course_id, sec_id, semester, year)
);

-- Step 3: Insert Sample Data

INSERT INTO department VALUES
('CSE', 'Building A', 100000),
('EEE', 'Building B', 120000),
('Physics', 'Building C', 90000);

INSERT INTO course VALUES
('C101', 'DBMS', 'CSE', 3),
('C102', 'Algorithms', 'CSE', 4),
('P101', 'Quantum', 'Physics', 3);

INSERT INTO instructor VALUES
(12121, 'Rahim', 'CSE', 95000),
(12122, 'Karim', 'EEE', 85000),
(12123, 'Sakib', 'Physics', 70000);

INSERT INTO section VALUES
('C101', '1', 'Fall', 2017, 'A'),
('C101', '2', 'Spring', 2018, 'A'),
('C102', '1', 'Fall', 2017, 'B');

INSERT INTO teaches VALUES
(12121, 'C101', '1', 'Fall', 2017),
(12121, 'C101', '2', 'Spring', 2018),
(12122, 'C102', '1', 'Fall', 2017);

-- Step 4: Queries

-- i. Salary > 90000
SELECT * FROM instructor
WHERE salary > 90000;

-- ii. Courses taught in both Fall 2017 and Spring 2018
SELECT course_id
FROM teaches
WHERE (semester = 'Fall' AND year = 2017)
INTERSECT
SELECT course_id
FROM teaches
WHERE (semester = 'Spring' AND year = 2018);

-- iii. Instructors earning more than ID 12121
SELECT ID, name
FROM instructor
WHERE salary > (
    SELECT salary FROM instructor WHERE ID = 12121
);

-- iv. Instructor names who taught any course
SELECT DISTINCT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID;

-- v. Instructors except Physics department
SELECT name
FROM instructor
WHERE dept_name <> 'Physics';
