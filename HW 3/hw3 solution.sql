-- Solutions to CS308 HW 3, Fall 2013
--
-- NOTES:
-- Even for fairly straight-forward problems like these, there are many
-- different queries that are equivalent. 
-- For some of the problems, we're providing two or more solutions
-- (e.g. differing in the way the join conditions are expressed.)
-- If you're not sure whether your solution is equivalent to these
-- solutions, execute it and compare the results.
-- (If the results are different, there's a bug; If the results are
--   the same your answers *might* be equivalent, but they might
--   still give different results on different data.)


-- PROBLEM 1
-- #1 pi(id,name)(sigma(salary > 90,000)(instructor))
select id,
       name
from instructor
where salary > 90000;

-- -------------------
-- query result
-- -------------------
-- id		name
-- -------------------
-- 22222	Einstein
-- 83821	Brandt
-- -------------------

-- #2 pi(id, name)(sigma(course_id = 'CS-101')(instructor natural join teaches))
select id, name
from instructor natural join teaches
where course_id = 'CS-101';

-- or, equivalently

select instructor.id, name
from instructor, teaches
where instructor.id = teaches.id
and course_id = 'CS-101';


-- -------------------
-- query result
-- -------------------
-- id		name
-- -------------------
-- 10101	Srinivasan
-- 45565	Katz
-- -------------------


-- PROBLEM 2
-- There are two issues for question 13 - 16.
-- 1. If a student takes a class more than once, do we need to count it once?
--    For example, Ann took 'Introduction to CS' in fall 2010 and retook the same course in spring 2011.

-- 2. If a student receives a NULL or F grade for a course, do we need to count it?

-- The assumptions for these solutions are the following.
-- 1. If a student takes a class more than once, we count each of them as taking 1 course.
--    In the case of the example, Ann took 2 courses.

-- 2. We count courses regardless of grades given.

-- If you made other assumptions, your results might be different, but still OK.




-- #1 Find IDs of students in the Comp. Sci. department
select id
from student
where dept_name = 'Comp. Sci.';


-- #2 Find IDs and names of students in the Comp. Sci. department who have less than 60 credits
select id,
       name
from student
where dept_name = 'Comp. Sci.'
and tot_cred < 60;


-- #3 Find IDs of students who got an A in CS-101
select id from takes
where course_id = 'CS-101'
and grade = 'A';


-- #4 Find IDs of students who got an A in CS-101 in Fall 2009
select id
from takes
where course_id = 'CS-101'
and grade = 'A'
and semester = 'Fall'
and year = 2009;


-- #5 Find IDs and names of students who got an A in CS-101
select id, name
from student natural join takes
where course_id = 'CS-101'
and grade = 'A';

select student.id,
       student.name
from student,
     takes
where student.id = takes.id
and course_id = 'CS-101'
and grade = 'A';


-- #6 Find IDs and names of students who got an A in CS-101 or in CS-190
select distinct student.id, name
from student natural join takes
where (course_id  = 'CS-101' or course_id = 'CS-190')
and grade = 'A';

select distinct student.id, name
from student, takes
where student.id = takes.id
and (course_id  = 'CS-101' or course_id = 'CS-190')
and grade = 'A';

select distinct student.id, name
from student, takes
where student.id = takes.id
and course_id in ('CS-101', 'CS-190')
and grade = 'A';


-- #7 Find IDs and names of students who took courses with 'Intro' in the 
--    title, along with the titles of the course(s) each of them took
select distinct id, name, title
from student natural join takes, course
where title like '%Intro%'
and   takes.course_id = course.course_id;
-- NOTE: beware of dept_name used with slightly different 
-- meanings in student and course.
-- can't just natural join all three tables together,
-- or courses in dept X taken by students in dept Y won't 
-- be included in the result when X != Y

select distinct student.id, name, title
from student, takes, course
where student.id = takes.id
and   takes.course_id = course.course_id
and title like '%Intro%';


-- #8 Find IDs and names of instructors who taught courses with 'Intro' in
--    the title, along with the titles of the course(s) each of them taught
select id,
       name,
       title
from instructor  natural join teaches, course
where title like '%Intro%'
and   teaches.course_id = course.course_id;
-- NOTE: similar issue to problem 7

select instructor.id,
       name,
       title
from instructor,
     teaches,
     course
where instructor.id = teaches.id
and   teaches.course_id = course.course_id
and title like '%Intro%';


-- #9 Find students who've taken courses from instructors with salaries over 70000
select  student.*
from instructor,
     teaches,
     student,
     takes
where instructor.id = teaches.id
and   teaches.course_id = takes.course_id
and   student.id = takes.id
and   takes.year = teaches.year
and   takes.sec_id = teaches.sec_id
and   takes.semester = teaches.semester
and   salary > 70000;
-- similar issue to problem 7
-- id in instructor or teaches and student or takes
-- have a different meaning


-- #10 Find instructors who've taught in the Packard Building
select distinct instructor.*
from section natural join
     instructor natural join
     teaches
where building = 'Packard';

select distinct instructor.*
from section,
     instructor,
     teaches
where teaches.course_id = section.course_id
and   teaches.sec_id = section.sec_id
and   teaches.semester = section.semester
and   teaches.year = section.year
and   teaches.id = instructor.id
and   building = 'Packard';


-- #11 Find the number of students who've taken CS-101
select count(id) as number_of_students
from takes
where course_id = 'CS-101';


-- #12 Find the number of students who've gotten each grade in CS-101
select grade, count(id) as number_of_students
from takes
where course_id = 'CS-101'
group by grade;


-- #13 Find the number of courses each student has taken
select student.id, name,
       count(course_id) as number_of_courses
from student,
     takes
where student.id = takes.id
group by student.id, name;

select id, name,
       count(course_id) as number_of_courses
from student natural join
     takes
group by id, name;


-- #14 Find the total number of credits each student has taken, based on the
--     information in the takes table (not on the student.tot cred attribute)
select student.id, name,
       sum(credits) as total_number_of_credits
from student,
     takes,
     course
where student.id = takes.id
and   takes.course_id = course.course_id
group by student.id, name;


-- #15 Find IDs students who have taken fewer than three courses
select student.id
from student,
     takes
where student.id = takes.id
group by student.id
having count(course_id) < 3;

select id
from student natural join
     takes
group by id
having count(course_id) < 3;


-- #16 Find IDs and names of students who have taken fewer than three courses
select student.id,
       name
from student,
     takes
where student.id = takes.id
group by student.id,
         name
having count(course_id) < 3;

select id,
       name
from student natural join
     takes
group by id,
         name
having count(course_id) < 3;


-- #17 Find IDs and names of students in the Comp Sci department who have taken fewer than three courses
select student.id,
       name
from student,
     takes
where student.id = takes.id
and   dept_name = 'Comp. Sci.'
group by student.id,
         name
having count(course_id) < 3;

select id,
       name
from student natural join
     takes
where dept_name = 'Comp. Sci.'
group by id,
         name
having count(course_id) < 3;


-- #18 Find the average number of credits of courses in each department
select dept_name,
       sum(credits)/count(course_id) as average_number_of_credits
from   course
group by dept_name;

select dept_name,
       avg(credits) as average_number_of_credits
from   course
group by dept_name;


-- #19 Find the number of sections taught in each building, each year
select building,
       year,
       count(sec_id) as number_of_sections
from   section
group by building,
         year;
		 
         
-- #20 Find the maximum salary of an instructor
select max(salary) as max_salary
from   instructor;
