CREATE DATABASE `sql_tutorial`;
SHOW DATABASES;
USE`sql_tutorial`;

CREATE TABLE `student`(
	`student_id` INT PRIMARY KEY,
    `name` VARCHAR(20),
    `major` VARCHAR(20)
);

DESCRIBE `student`;
ALTER TABLE `student` ADD gpa DECIMAL(3,2);
ALTER TABLE `student` DROP COLUMN gpa;

SHOW TABLES;

SELECT * FROM `student`;
INSERT INTO `student` VALUES(1, 'Mr.White', 'History');
INSERT INTO `student` VALUES(2, 'Mr.Green', 'Chinese');
INSERT INTO `student` VALUES(3, 'Mr.Pink', NULL);
INSERT INTO `student`(`name`, `major`, `student_id`) VALUES('Mr.Blue', 'English', 4);
INSERT INTO `student`(`major`, `student_id`) VALUES('English', 5);


-- constraints
DROP TABLE `student`;
CREATE TABLE `student`(
	`student_id` INT AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `major` VARCHAR(20) UNIQUE DEFAULT 'Chinese',
    PRIMARY KEY(`student_id`)
);

INSERT INTO `student` VALUES(1, NULL, 'History');
INSERT INTO `student` VALUES(2, 'Mr.Green', 'History');
INSERT INTO `student` VALUES(2, 'Mr.Grey', 'Math');
INSERT INTO `student`(`name`, `student_id`) VALUES('Mr.Right', 5);
INSERT INTO `student`(`name`, `major`) VALUES('Mr.Blue', 'English');


-- modify & delete

SET SQL_SAFE_UPDATES = 0;

DROP TABLE `student`;
CREATE TABLE `student`(
	`student_id` INT PRIMARY KEY,
    `name` VARCHAR(20),
    `major` VARCHAR(20),
    `score` INT
);

INSERT INTO `student` VALUES(1, 'Mr.White', 'History', 90);
INSERT INTO `student` VALUES(2, 'Mr.Green', 'Chinese', 80);
INSERT INTO `student` VALUES(3, 'Mr.Pink', 'Math', 70);
INSERT INTO `student` VALUES(4, 'Mr.Purple', 'English', 60);
INSERT INTO `student` VALUES(5, 'Mr.Turtle', 'Chemistry', 50);
INSERT INTO `student` VALUES(6, 'Mr.Rabbit', 'German', 90);
INSERT INTO `student` VALUES(7, 'Miss.Deer', 'French', 90);
INSERT INTO `student` VALUES(8, 'Miss.Goat', 'English', 70);

SELECT * FROM `student`;

-- basics
UPDATE `student`
SET `major` = 'English Literature'
WHERE `major` = 'English';

-- select multiple features
UPDATE `student`
SET `major` = 'Literature'
WHERE `major` = 'English' OR `major` = 'Chinese';

-- change multiple features
UPDATE `student`
SET `name` = 'Miss.Pretty', `major` = 'Statistics'
WHERE `major` = 'Literature';

-- Deletion
DELETE FROM `student`
WHERE `student_id` = 2;

-- select mutiple objects
DELETE FROM `student`
WHERE `name` = 'Mr.White' AND `major` = 'History';

-- set conditions
DELETE FROM `student`
WHERE `score` <= 96;

-- delete all rows if you don't specify WHERE
DELETE FROM `student`;


-- get specific information

-- select columns
SELECT `name`, `major` FROM `student`;

-- Sort; * means all; default - ASC
SELECT * 
FROM `student` 
ORDER BY `score`;

-- descending
Select * 
FROM `student` 
ORDER BY `score` DESC;

-- priority
SELECT * 
FROM `student` 
ORDER BY `score`, `student_id`;

-- only want the first few of the result
SELECT * 
FROM `student` 
ORDER BY `score` DESC
LIMIT 3;

-- set conditions
SELECT * 
FROM `student` 
WHERE `major` = 'English' AND `student_id` = 8;

-- <> means not equal
SELECT * 
FROM `student` 
WHERE `major` = 'English' OR `score` <> 90
LIMIT 3;

-- <> means not equal
SELECT * 
FROM `student` 
WHERE `major` = 'English' OR `score` <> 90
LIMIT 3;

-- use list
SELECT * 
FROM `student` 
WHERE `major` IN('English', 'German', 'French');


SELECT * FROM `student`;
