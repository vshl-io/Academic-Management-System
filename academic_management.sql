-- Create CoursesInfo Table
CREATE TABLE Courseslnfo ( 
COURSE_ID INT PRIMARY KEY, 
COURSE_NAME NOT NULL, 
COURSE_INSTRUCTOR_NAME NOT NULL
);

-- Create Studentlnfo Table
CREATE TABLE Studentlnfo ( 
STU_ID SERIAL PRIMARY KEY, 
STU_NAME NOT NULL, 
DOB DATE CHECK (DOB < CURRENT_DATE) NOT NULL, 
PHONE_NO VARCHAR(15) NOT NULL, --to store STD, ISD Codes used varchar 
EMAIL_ID VARCHAR(50) UNIQUE NOT NULL, 
ADDRESS VARCHAR(150) NOT NULL
);

-- Create Enrollmentlnfo Table
CREATE TABLE Enrollmentlnfo ( 
ENROLLMENT_ID SERIAL PRIMARY KEY, 
STU_ID INT REFERENCES Student1nfo(STU_ID) , 
COURSE_ID INT REFERENCES Courses1nfo(COURSE_ID) , 
ENROLL_STATUS VARCHAR(15) NOT NULL CHECK (ENROLL_STATUS IN ('Enrolled', 'Not Enrolled')) 
);

-- Inserting data into StudentInfo table
INSERT INTO StudentInfo (STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES 
('Alice Smith', '2000-01-01', '+1234567890', 'alice.smith@gmail.com', '123 Maple St, Springfield'),
('Bob Johnson', '2001-02-15', '+1987654321', 'bob.johnson@gmail.com', '456 Oak Rd, Rivertown'),
('Charlie Lee', '1999-11-30', '+1122334455', 'charlie.lee@yahoo.com', '789 Pine Ln, Lakeside');

-- Inserting data into CoursesInfo table
INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES 
(101, 'SQL', 'John Doe'),
(102, 'Python', 'Jane Milter'),
(103, 'Java Basics', 'Emily Clark');

-- Inserting data into EnrollmentInfo table
INSERT INTO EnrollmentInfo (STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES 
(1, 101, 'Enrolled'),
(1, 102, 'Enrolled'),
(2, 103, 'Enrolled'),
(3, 101, 'Not Enrolled');

--Write a query to retrieve student details, such as student name, contact informations, and Enrollment status.
SELECT stu_name, phone_no, email_id, enroll_status FROM StudentInfo s
JOIN EnrollmentInfo e
ON s.stu_id = e.stu_id;


--Write a query to retrieve a list of courses in which a specific student is enrolled.
SELECT c.course_name FROM StudentInfo s
JOIN EnrollmentInfo e 
ON s.stu_id = e.stu_id
JOIN CoursesInfo c 
ON e.course_id = c.course_id
WHERE s.stu_name = 'Alice Smith';


--Write a query to retrieve course information, including course name, instructor information.
SELECT c.course_id, c.course_name, c.course_instructor_name FROM CoursesInfo c
JOIN EnrollmentInfo e 
ON c.course_id = e.course_id;


--Write a query to retrieve course information for a specific course.
SELECT * FROM CoursesInfo c
WHERE c.course_name = 'SQL';


--Write a query to retrieve course information for multiple courses.
SELECT * FROM CoursesInfo c
WHERE c.course_name IN ('SQL', 'Python');


--Write a query to retrieve the number of students enrolled in each course
SELECT c.course_name, COUNT(*) AS number_of_students FROM CoursesInfo c
JOIN EnrollmentInfo e 
ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING e.enroll_status = 'Enrolled';

-- Write a query to retrieve the list of students enrolled in a specific course
SELECT s.stu_name, c.course_name, e.enroll_status FROM StudentInfo s
JOIN EnrollmentInfo e 
ON s.stu_id = e.stu_id
JOIN CoursesInfo c 
ON e.course_id = c.course_id
WHERE c.course_name = 'SQL' AND e.enroll_status = 'Enrolled';


--Write a query to retrieve the count of enrolled students for each instructor.
SELECT c.course_instructor_name, COUNT(*) AS "count of enrolled students" FROM CoursesInfo c
JOIN EnrollmentInfo e 
ON c.course_id = e.course_id
GROUP BY c.course_instructor_name
HAVING e.enroll_status = 'Enrolled';


--Write a query to retrieve the list of students who are enrolled in multiple courses
SELECT s.stu_id, stu_name, enroll_status, COUNT(*) AS course_count FROM StudentInfo s
JOIN EnrollmentInfo e 
ON s.stu_id = e.stu_id
JOIN CoursesInfo c 
ON c.course_id = e.course_id
GROUP BY s.stu_id, stu_name, enroll_status
HAVING COUNT(*) > 1 AND enroll_status = 'Enrolled';

--Write a query to retrieve the courses that have the highest number of enrolled students(arranging from highest to lowest)
SELECT c.course_name, e.enroll_status, COUNT(*) AS course_count FROM StudentInfo s
JOIN EnrollmentInfo e 
ON s.stu_id = e.stu_id
JOIN CoursesInfo c 
ON c.course_id = e.course_id
GROUP BY c.course_name, e.enroll_status
HAVING e.enroll_status = 'Enrolled'
ORDER BY COUNT(*) DESC;




