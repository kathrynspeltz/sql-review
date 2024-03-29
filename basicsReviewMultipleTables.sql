-- mySQL Practice Database
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

DESCRIBE employee;

DESCRIBE branch;

DESCRIBE client;

DESCRIBE works_with;

DESCRIBE branch_supplier;

-- All tables created

-- Add Corporate branch and employees 
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);
-- CHECK TABLE
SELECT * FROM employee

-- Add Scranton branch and employees 
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- CHECK TABLE
SELECT * FROM employee WHERE branch_id = 2;

-- Add Stamford branch and employees 
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- CHECK TABLE
SELECT * FROM employee WHERE branch_id = 3;


-- BRANCH SUPPLIER Data
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- Check Table

SELECT * FROM branch_supplier;

-- CLIENT Data
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- Check Table
SELECT * FROM client;

-- WORKS_WITH Data
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- Check Table 
SELECT * FROM works_with;



--SINGLE TABLE REVIEW

-- Find employees by first name that make over 75k
SELECT first_name FROM employee
WHERE SALARY > 75000;

-- Find all employees by first name ordered by salary, richest to lowest
SELECT first_name, salary FROM employee
ORDER BY salary DESC;

-- Find all employees ordered by sex then first name
SELECT sex, first_name FROM employee
ORDER BY sex, first_name;

-- Find the first 5 employees in the table 
SELECT * from employee
LIMIT 5;

-- Find the forename and surname of all employees 
SELECT first_name AS forename, last_name AS surname FROM employee;

-- Find out all the different genders
SELECT DISTINCT sex FROM employee;

-- Find the number of employees
SELECT COUNT(emp_id) FROM employee;

-- Find the number for female employees born after 1970
SELECT COUNT(emp_id) FROM employee
WHERE sex = 'F' AND birth_day > '1971-01-01';

-- Find the average of all employees salaries 
SELECT AVG(salary)
FROM employee;

-- Find the total sales of each salesman
SELECT SUM(total_sales), emp_id FROM works_with
GROUP BY emp_id;

-- Find any clients who are an LLC 
SELECT client_name FROM client
WHERE client_name LIKE '%LLC'; 

-- Find any branch suppliers who are in the label business 
SELECT * 
FROM branch_supplier
WHERE supplier_name like '% Label%';

-- Find any empoylees that were born in Oct
SELECT first_name, birth_day FROM employee
WHERE birth_day LIKE '____-10%';

-- Find any clients who are schools
SELECT * FROM client WHERE client_name LIKE '%school%';


-- MULTIPLE TABLE PRACTICE 

-- Find a list of employee and branch names
SELECT first_name AS Names FROM employee
UNION
SELECT branch_name FROM branch;

-- Find a list of all clients and branch suppliers' names
SELECT client_name AS names FROM client
UNION
SELECT supplier_name FROM branch_supplier;

-- Find a list of all the money spent or earned by the company

SELECT salary AS Transactions FROM employee
UNION
SELECT total_sales FROM works_with;

INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

-- Find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

-- Find names of all employees who have sold over 30,000 to a single client
SELECT employee.first_name, employee.last_name FROM employee
WHERE employee.emp_id 
    IN (SELECT works_with.emp_id FROM WORKS_WITH
    WHERE works.with.total_sales > '30000');

-- Find all clients who are handled by the branch that Micheal Scott Manages
-- Assume you know Micheals ID

SELECT client.client_name FROM client
WHERE client.branch_id
    = (SELECT branch.branch_id FROM branch
    WHERE branch.mgr_id = '102'
    LIMIT 1);

-- DELETE options NULL vs CASCADE 

DELETE FROM employee
WHERE emp_id = 102;

DELETE FROM branch
WHERE branch_id = 2;


-- Tiggers

DELIMITER $$ 
CREATE
    TRIGGER my_trigger1 BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('added new employee');
    END$$ 
DELIMITER ; 


DELIMITER $$ 
CREATE
    TRIGGER my_trigger2 BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES(NEW.first_name);
    END$$ 
DELIMITER ; 

INSERT INTO employee
VALUES (109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;

DELIMITER $$ 
CREATE
    TRIGGER my_trigger3 BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        IF NEW.sex = 'M' THEN
            INSERT INTO trigger_test VALUES('added male employee');
        ELSEIF NEW.sex = 'F' THEN
            INSERT INTO trigger_test VALUES('added female employee');
        ELSE
            INSERT INTO trigger_test VALUES('added other employee');
        END IF;
    END$$ 
DELIMITER ; 

INSERT INTO employee
VALUES(111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);

SELECT * FROM trigger_test;
