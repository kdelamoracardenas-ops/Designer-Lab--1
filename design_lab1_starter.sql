/* ==========================================================================
   design_lab1_starter.sql
   CIS 4720 Database Management and SQL
   Design Lab 1, From a Spreadsheet to Tables

   WHAT THIS FILE IS
   The campus tutoring center keeps its records in a spreadsheet. This file
   loads that spreadsheet into a table called tutoring_sheet, exactly as the
   center keeps it, and has a numbered heading for every step of the lab.

   HOW TO RUN IT
   One statement at a time. Put the cursor on it and press Ctrl + E twice.

   LABELING AND COMMENTING IS REQUIRED
   Above every statement you write, put a short comment in your own words
   saying what it does. Some steps also ask you to answer a question in a
   comment. The comments are graded.
   ========================================================================== */


-- =================================================================
-- SETUP. Run these three first, one at a time, while you are still
-- connected to information_schema.
-- =================================================================

-- every schema on this server. tutoring_db will not be in the list yet.
show databases;

-- make yours. IF NOT EXISTS means it is safe to run twice.
create database if not exists tutoring_db;

-- switch into it, so everything below lands in the right place.
use tutoring_db;


-- ======================================================================
-- THE SPREADSHEET. One row per tutoring session. Look at the students
-- column: every student who came is crammed into one cell.
-- ======================================================================

CREATE TABLE tutoring_sheet (
    session_id   INT,
    session_date DATE,
    room         VARCHAR(10),
    tutor_id     INT,
    tutor_name   VARCHAR(40),
    tutor_email  VARCHAR(60),
    course_code  VARCHAR(10),
    course_title VARCHAR(40),
    students     VARCHAR(200)
);
INSERT INTO tutoring_sheet VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS), 1003 Chloe Nguyen (CIS)');
INSERT INTO tutoring_sheet VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting)');
INSERT INTO tutoring_sheet VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', '1001 Ana Lopez (CIS), 1004 Dev Patel (Biology), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', '1003 Chloe Nguyen (CIS), 1004 Dev Patel (Biology)');
INSERT INTO tutoring_sheet VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS)');

-- CHECK. Six rows, sessions 101 to 106.
SELECT * FROM tutoring_sheet;


-- ######################################################################
-- YOUR DESIGN LAB 1 WORK STARTS BELOW THIS LINE
--
-- LABELING AND COMMENTING IS REQUIRED. It is worth a full point.
-- ######################################################################


-- =================================================================
-- STEP 3. Ask the spreadsheet two questions
--
-- Copy the queries from the handout. Answer the question in a comment.
-- =================================================================
-- asking spreadsheet two questions
-- how many sessions did Ana come to? search inside the text
-- 3, is right because the name is typed the same way every time
SELECT COUNT(*) FROM tutoring_sheet WHERE students LIKE '%Ana Lopez%';
-- how many student visits were there in total?
--6, not right because this counts sessions. Eleven students came
SELECT COUNT(*) FROM tutoring_sheet;


-- count can't see students because student column holds a list so databasse sees one value per row, not one value per student
-- =================================================================
-- STEP 4. First normal form, one value per cell
--
-- Write the CREATE TABLE. Then run the DATA FOR STEP 4 block below it.
-- =================================================================
Create table if not exists tutoring_1nf(
    session_id INT NOT NULL,
    session_date DATE,
    room VARCHAR(10),
    tutor_id INT,
    tutor_name VARCHAR(40),
    tutor_email VARCHAR(60),
    course_code VARCHAR(10),
    course_title VARCHAR(40),
    student_id INT NOT NULL,
    student_name VARCHAR(40),
    student_major VARCHAR(30),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    Primary key (session_id, student_id)
    );

    show full tables;

-- ----------------------------------------------------------------------
-- DATA FOR STEP 4. Run these eleven INSERTs AFTER your CREATE TABLE for
-- tutoring_1nf. They only work if your columns are in the same order as
-- the table in the handout. One row per student per session.
-- ----------------------------------------------------------------------

INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 3);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1001, 'Ana Lopez', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1004, 'Dev Patel', 'Biology', 5);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1005, 'Elena Ruiz', 'Undeclared', 2);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 4);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1005, 'Elena Ruiz', 'Undeclared', 3);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1004, 'Dev Patel', 'Biology', 4);
INSERT INTO tutoring_1nf VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);



-- =================================================================
-- STEP 5. Make a copy to break
-- =================================================================

create table anomaly_copy as
select * from tutoring_1nf;

-- the copy has eleven rows, just like tutoring_1nf

select * from anomaly_copy;

--syntax is copied from the handout
-- =================================================================
-- STEP 6. The update problem
--
-- Copy the UPDATE from the handout. Answer the question in a comment.
-- =================================================================

-- Update Maya Chen's email
-- View the data in the anomaly copy table first
Select * from anomaly_copy;

-- syntax below is copied from the instructioin file
-- change Maya's email, but only where session 101 is
UPDATE anomaly_copy
SET tutor_email = 'maya.chen@campus.edu'
WHERE session_id = 101;
-- what does the database now say her email is?
SELECT DISTINCT tutor_id, tutor_name, tutor_email
FROM anomaly_copy
WHERE tutor_id = 501;

-- Answer; The new one is correct but nothing in the table saids so.
-- both appear equally often in query, so reader can't tell which is 
-- current. Her email is stored on 6 rows, and all 6 had to change. 
-- this is update anomaly.

-- =================================================================
-- STEP 7. The insert problem
--
-- Write the INSERT. Copy the error into a comment.
-- =================================================================
Insert into table anamoly_copy include course_code = CIS 4720 and course_title = Database Management
-- error: field session_id doesn't have default value

-- Answer session id and student id form the key, so every row needs both,
-- A course cannot be recorded until a session has happened in it. This is the insert anomaly

select * from anamoly_copy;
-- =================================================================
-- STEP 8. The delete problem
--
-- Write the DELETE and the check. Answer the question in a comment.
-- =================================================================

-- session 103 was entered by mistake. Remove every row with session_id = 103
-- delete from anomaly_copy where session_id= 103;

SELECT DISTINCT course_code, course_title
FROM anomaly_copy
ORDER BY course_code;

-- Answer I meant to delete  one fact and error 103 happened
-- Math 1600 statistics went with it because session 103 was the only
-- row that recorded that the course exists.this is Delete anomaly.
-- =================================================================
-- STEP 9. Find the dependencies, and design third normal form
--
-- Answer in comments. Use the template in the handout.
-- =================================================================
-- finding dependancies
select student_id,
count(DISTINCT student_name) as names,
count(DISTINCT student_major) as majors
from tutoring_1nf
group by student_id;

--- the key is student_id, and session_id
-- column ( SESSION_DATE, TUTOR_NAME, ROOM, TUTOR_EMAIL, COURSE_CODE, COURSE_TITLE, STUDENT_NAME, STUDENT_MAJOR, RATING.)
-- DETERMINES (SESSION_DATE, TUTOR_ID, SESION_ID, TUTOR_EMAIL, COURSE_CODE, COURSE_TITLE, STUDENT_NAME, STUDENT_MAJOR, RATING.)



-- each student_id has exactly one name and one major. every count is 1

-- =================================================================
-- STEP 10. Build the five tables
--
-- Order matters: a table that is pointed at must exist first.
-- =================================================================

-- one row per student. student_id is the key
CREATE TABLE student (
student_id INT PRIMARY KEY,
student_name VARCHAR(40) NOT NULL,
student_major VARCHAR(30)
);

-- create table tutor
CREATE TABLE tutor (
tutor_id INT PRIMARY KEY,
tutor_name VARCHAR(40) NOT NULL,
tutor_email VARCHAR(60) NOT NULL
);

-- create table course
CREATE TABLE course (
course_code VARCHAR(10) PRIMARY KEY,
course_title VARCHAR(40) NOT NULL
);

-- create table course
CREATE TABLE session (
session_id INT PRIMARY KEY,
session_date DATE NOT NULL,
room VARCHAR(10) ,
tutor_id INT NOT NULL,
course_code VARCHAR(10) NOT NULL,
FOREIGN KEY (tutor_id) REFERENCES tutor(tutor_id),
FOREIGN KEY (course_code) REFERENCES course(course_code)
);

-- create table attendance
CREATE TABLE attendance (
session_id INT NOT NULL,
student_id INT NOT NULL,
rating INT CHECK (rating BETWEEN 1 AND 5),
PRIMARY KEY (session_id, student_id),
FOREIGN KEY (session_id) REFERENCES session(session_id),
FOREIGN KEY (student_id) REFERENCES student(student_id)
);


show full tables;

-- =================================================================
-- STEP 11. Load the five tables from tutoring_1nf
-- =================================================================

--each table loaded from tutoring_1nf. Distinct removes repeats
-- Insert can take its rows from a select instead of a values list.

-- one row per student, taken from the 1NF table

-- 5 rows
INSERT INTO student (student_id, student_name, student_major)
SELECT DISTINCT student_id, student_name, student_major
FROM tutoring_1nf;

-- 3 rows
INSERT INTO tutor (tutor_id, tutor_name, tutor_email)
SELECT DISTINCT tutor_id, tutor_name, tutor_email
FROM tutoring_1nf;


-- 3
INSERT INTO course (course_code, course_title)
SELECT DISTINCT course_code, course_title
FROM tutoring_1nf;

select * from course;

-- 6
INSERT INTO session (session_id, session_date, room, tutor_id, course_code)
SELECT DISTINCT session_id, session_date, room, tutor_id, course_code
FROM tutoring_1nf;
select * from session;


-- 11 rows
-- No distinct every 1NF row is already one attendance
INSERT INTO attendance (session_id, student_id, rating)
SELECT session_id, student_id, student_rating
FROM tutoring_1nf;

select * from attendance;


-- =================================================================
-- STEP 12. Put the spreadsheet back together
--
-- Copy the view and the check from the handout.
-- =================================================================

-- one row per student, taken from the 1NF table
-- the five tables joined back into the 1NF shape
-- the five tables joined back into the 1NF shape
CREATE VIEW tutoring_rebuilt AS
SELECT se.session_id, se.session_date, se.room,
t.tutor_id, t.tutor_name, t.tutor_email,
c.course_code, c.course_title,
st.student_id, st.student_name, st.student_major,
a.rating
FROM attendance a
JOIN session se ON a.session_id = se.session_id
JOIN tutor t ON se.tutor_id = t.tutor_id
JOIN course c ON se.course_code = c.course_code
JOIN student st ON a.student_id = st.student_id;-- how many rows match tutoring_1nf on every column?
SELECT COUNT(*)
FROM tutoring_1nf o
JOIN tutoring_rebuilt r
ON o.session_id = r.session_id AND o.student_id = r.student_id
WHERE o.session_date = r.session_date AND o.room = r.room
AND o.tutor_email = r.tutor_email AND o.course_title = r.course_title
AND o.student_name = r.student_name AND o.student_major = r.student_major
AND o.rating = r.rating;


SELECT * FROM tutoring_rebuilt;


-- =================================================================
-- STEP 13. Show the three problems are gone
-- =================================================================

-- update problem change mayas email in the one place it is stored


UPDATE tutor
SET tutor_email = 'maya.chen@campus.edu'
WHERE tutor_id = 501;


-- all 6 of her sessions now show the same email
SELECT DISTINCT tutor_email
FROM tutoring_rebuilt
WHERE tutor_id = 501;

-- a course with no sessions can now be recorded 
INSERT INTO course (course_code, course_title)
VALUES ('CIS 4720', 'Database Management');


-- refused because three attendance rows point at section 103
DELETE FROM session
WHERE session_id = 103;

 -- cannot delete or updat epaent row, a foreign key constraint fails


-- Answers: update: email is stored once in tutor so on echange fixes every session
-- insert: a course has its own table and no longer needs a session to exist
-- delete: the course lives in its own table, so removing session could not remove course. Foreign key
-- also stops session vanishig while attendance still points at it
-- =================================================================
-- STEP 14 and 15. Push to GitHub and submit the URL
--
-- Nothing to write here. Follow the handout.
-- =================================================================

