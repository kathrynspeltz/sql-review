CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    major VARCHAR(20) DEFAULT 'undecided'

);

INSERT INTO student VALUES(1, 'Jack', 'Anderson', 'Biology'),( 2, 'Jill', 'Anderson', 'Math' ), (3, 'Mike', 'Jones', 'Comp Sci');
INSERT INTO student( first_name, last_name) VALUES('Reg', 'George'),('Elle', 'Woods');

UPDATE student
SET major = 'Bio'
WHERE major = 'Biology';

UPDATE student
SET major = 'Fashion'
WHERE student_id = 3;

DELETE FROM student
where student_id = 1;

ALTER TABLE student DROP COLUMN major; 

SELECT first_name, major FROM student
ORDER BY major
LIMIT 3;

SELECT * FROM student;

SELECT first_name FROM student
WHERE major = 'undecided' AND first_name <> 'Reg';

SELECT last_name FROM student
WHERE first_name IN ('Mike', 'Jill');

SELECT * FROM student;

DROP TABLE student;

