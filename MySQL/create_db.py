import mysql.connector
from mysql.connector import Error # type: ignore

connection = mysql.connector.connect(host="localhost",
                                     port=3306,
                                     user="root",
                                     password="123456Qqq!",
                                     database="company-info")

cursor = connection.cursor()

# create database
cursor.execute("CREATE DATABASE IF NOT EXISTS happy;")

# get names of all databases
cursor.execute("SHOW DATABASES;")
# get info from branch
records = cursor.fetchall()
for r in records:
    print(r)

# choose a database
cursor.execute("USE `company-info`;")

# create a table
cursor.execute('DROP TABLE IF EXISTS `hello`;')
cursor.execute('CREATE TABLE `hello`(hello INT);')

# add
cursor.execute("INSERT INTO `branch` VALUES(5, 'qq', NULL)")

# modify
cursor.execute('UPDATE `branch` SET `manager_id` = 206 WHERE `branch_id` = 4;')

# delete
cursor.execute("DELETE FROM `branch` WHERE `branch_id` = 5;")

cursor.close()
connection.commit()
connection.close()