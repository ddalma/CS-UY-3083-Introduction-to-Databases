1. SELECT ID, course_id, room_number
from takes NATURAL JOIN section
WHERE takes.course_id = section.course_id AND (room_number = '101' or room_number = '120');


2.


5. SELECT id
FROM(
    SELECT id, course_id, COUNT(*) AS num 
    FROM takes
    GROUP BY id, course_id
    HAVING num > 1
    ) AS tmp

6. create table gradepoint(
	letter	varchar(2) PRIMARY KEY,
	points	decimal(2,1) NOT NULL
);
insert into gradepoint values(


);


14. SELECT DISTINCT ID, grade from takes NATURAL JOIN student WHERE grade!= 'A' AND grade!='A-'

15.

16. SELECT name
FROM instructor
WHERE dept_name = "Comp. Sci."

18. SELECT ID, course_id FROM teaches
