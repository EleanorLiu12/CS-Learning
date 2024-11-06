CREATE TABLE `employee`(
	`emp_id` INT PRIMARY KEY,
    `name` VARCHAR(20),
    `birth_date` DATE,
    `sex` VARCHAR(1),
    `salary` INT,
    `branch_id` INT,
    `sup_id` INT
);

-- foreign keys
CREATE TABLE `branch`(
	`branch_id` INT PRIMARY KEY,
    `branch_name` VARCHAR(20),
    `manager_id` INT,
    FOREIGN KEY (`manager_id`) REFERENCES `employee`(`emp_id`) ON DELETE SET NULL
);

CREATE TABLE `client`(
	`client_id` INT PRIMARY KEY,
    `client_name` VARCHAR(20),
    `phone` INT
);

CREATE TABLE `works_with`(
	`emp_id` INT,
    `client_id` INT,
    `total_sales` INT,
    PRIMARY KEY(`emp_id`, `client_id`),
    FOREIGN KEY (`emp_id`) REFERENCES `employee`(`emp_id`) ON DELETE CASCADE,
    FOREIGN KEY (`client_id`) REFERENCES `client`(`client_id`) ON DELETE CASCADE
);


ALTER TABLE `employee`
ADD FOREIGN KEY(`branch_id`)
REFERENCES `branch`(`branch_id`)
ON DELETE SET NULL;

ALTER TABLE `employee`
ADD FOREIGN KEY(`sup_id`)
REFERENCES `employee`(`emp_id`)
ON DELETE SET NULL;


-- add info to Bracnch
INSERT INTO `branch` VALUES(1, 'IT', NULL);
INSERT INTO `branch` VALUES(2, 'Management', NULL);
INSERT INTO `branch` VALUES(3, 'Journalism', NULL);

-- add info to Employee
INSERT INTO `employee` VALUES(206, 'Miss.Green', '1998-12-21', 'F', 50000, 1, NULL);
INSERT INTO `employee` VALUES(207, 'Miss.Grey', '1995-02-02', 'F', 29000, 2, NULL);
INSERT INTO `employee` VALUES(208, 'Miss.Pink', '1990-03-15', 'F', 35000, 3, NULL);
INSERT INTO `employee` VALUES(209, 'Miss.Blue', '2000-05-20', 'M', 390000, 3, NULL);
INSERT INTO `employee` VALUES(210, 'Miss.Orange', '1982-07-09', 'M', 84000, 1, NULL);

-- add foreign keys
UPDATE `branch`
SET `manager_id` = 206
WHERE `branch_id` = 1;

UPDATE `branch`
SET `manager_id` = 207
WHERE `branch_id` = 2;

UPDATE `branch`
SET `manager_id` = 208
WHERE `branch_id` = 3;

-- add info to Client
INSERT INTO `client` VALUES(400, 'Ms.Happy', '24689');
INSERT INTO `client` VALUES(401, 'Ms.Exited', '13579');
INSERT INTO `client` VALUES(402, 'Ms.Interest', '23433');
INSERT INTO `client` VALUES(403, 'Ms.Smart', '46758');
INSERT INTO `client` VALUES(404, 'Ms.Clever', '17684');

-- add info to Works_With
INSERT INTO `works_with` VALUES(206, 400, '70000');
INSERT INTO `works_with` VALUES(207, 401, '24000');
INSERT INTO `works_with` VALUES(208, 402, '9800');
INSERT INTO `works_with` VALUES(209, 403, '24000');
INSERT INTO `works_with` VALUES(210, 404, '87940');




-- Practice

-- 1. Get all the information about employees
SELECT * FROM `employee`; 

-- 2. Get all the information about clients
SELECT * FROM `client`; 

-- 3. 按薪水从低到高取得员工资料
SELECT * FROM `employee`
ORDER BY `salary` ASC;

-- 4. 取薪水前三高的员工资料
SELECT * FROM `employee`
ORDER BY `salary` DESC
LIMIT 3;

-- 5. 取所有员工的名字
SELECT `name` FROM `employee`;
-- 去掉重复
SELECT DISTINCT `branch_id` FROM `employee`;



-- aggregate functions 聚合函数

-- 1.取得员工人数
SELECT COUNT(*) FROM `employee`;
SELECT COUNT(`sup_id`) FROM `employee`;

-- 2.取得所有出生于1990-01-01之后的女员工人数
SELECT COUNT(*) 
FROM `employee` 
WHERE `birth_date` > '1990-01-01' AND `sex` = 'F';

-- 3.取得所有员工的平均薪水
SELECT AVG(`salary`) FROM `employee`;

-- 4.取得所有员工薪水的总和
SELECT SUM(`salary`) FROM `employee`;

-- 5.取得薪水最高的员工
SELECT MAX(`salary`) FROM `employee`;

-- 6.取得薪水最低的员工
SELECT MIN(`salary`) FROM `employee`;




-- wildcards 万用字元  
-- % 代表多个字元
-- _ 代表一个字元

-- 1.取得电话号码尾数是335的客户
SELECT * 
FROM `client` 
WHERE `phone` LIKE '%33';

-- 取头
SELECT * 
FROM `client` 
WHERE `phone` LIKE '2%';

-- 取中
SELECT * 
FROM `client` 
WHERE `phone` LIKE '%8%';

-- 2.取得姓Happy的客户
SELECT * 
FROM `client` 
WHERE `client_name` LIKE '%Happy';

-- 3.取得生日在12月的员工
SELECT * 
FROM `employee` 
WHERE `birth_date` LIKE '_____12%';



-- union 并集

-- 1.员工名字 U 客户名字
SELECT `name`
FROM `employee`
UNION
SELECT `client_name`
FROM `client`
UNION 
SELECT `branch_name`
FROM `branch`;

-- 2.（员工ID + 员工名字）U （客户ID + 客户名字）
SELECT `emp_id`, `name`
FROM `employee`
UNION 
SELECT `client_id`, `client_name`
FROM `client`;

-- 改变列的名字
SELECT `emp_id` AS `total_id`, `name`AS `total_name`
FROM `employee`
UNION 
SELECT `client_id` , `client_name`
FROM `client`;

-- 3.员工薪水 U 销售金额
SELECT `salary` AS `total_money`
FROM `employee`
UNION
SELECT `total_sales`
FROM `works_with`;



-- join 连接
INSERT INTO `branch` VALUES(4, `lazy`, NULL);

-- 取得所有部门经理的名字
SELECT `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name`
FROM `employee`
JOIN `branch`
ON `employee`.`emp_id` = `branch`.`manager_id`;

-- left join(keep all the left, null if not exists)
SELECT `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name`
FROM `employee` LEFT JOIN `branch`
ON `employee`.`emp_id` = `branch`.`manager_id`;

-- right join(keep all the right, null if not exists)
SELECT `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name`
FROM `employee` RIGHT JOIN `branch`
ON `employee`.`emp_id` = `branch`.`manager_id`;




-- subquery 子查询

-- 1.找出某部门的经理名字
SELECT `name`
FROM `employee`
WHERE `emp_id` = (
	SELECT `manager_id` 
	FROM `branch`
	WHERE `branch_name` = 'IT'
);

-- 2.找出对单一位客户销售金额超过50000的员工名字
SELECT `name`
FROM `employee`
WHERE `emp_id` IN (
	SELECT `emp_id`
    FROM `works_with`
    WHERE `total_sales` > 50000
);




-- on delete

-- ON DELETE SET NULL: 不见了设置为null
CREATE TABLE `branch`(
	`branch_id` INT PRIMARY KEY,
    `branch_name` VARCHAR(20),
    `manager_id` INT,
    FOREIGN KEY (`manager_id`) REFERENCES `employee`(`emp_id`) ON DELETE SET NULL
);

DELETE FROM `employee`
WHERE `emp_id` = 207;

SELECT * FROM `employee`;

-- ON DELETE CASCADE: 不见了就把整笔资料删掉
-- primary key cannot be null
CREATE TABLE `works_with`(
	`emp_id` INT,
    `client_id` INT,
    `total_sales` INT,
    PRIMARY KEY(`emp_id`, `client_id`),
    FOREIGN KEY (`emp_id`) REFERENCES `employee`(`emp_id`) ON DELETE CASCADE,
    FOREIGN KEY (`client_id`) REFERENCES `client`(`client_id`) ON DELETE CASCADE
);

SELECT * FROM `works_with`;







