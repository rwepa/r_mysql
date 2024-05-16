# file     : r_mysql.R
# author   : Ming-Chang Lee
# date     : 2024.05.16
# YouTube  : https://www.youtube.com/@alan9956
# RWEPA    : http://rwepa.blogspot.tw/
# GitHub   : https://github.com/rwepa
# Email    : alan9956@gmail.com

# 大綱
# 1.MySQL 安裝
# 2.MySQL Workbench
# 3.MySQL Shell
# 4.RStudio 連接MySQL三大方法

##############################
# 1.MySQL 安裝
##############################

# 1.下載 MySQL Installer 8.0.37
# https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-community-8.0.37.0.msi# 
# 2. Choosing a Setup Type --> 選取 [Full]# 
# 3. root 密碼: 123456

##############################
# 2.MySQL Workbench
##############################

# USE sakila;
# SELECT * FROM rental;

##############################
# 3.MySQL Shell
##############################

# 切換至SQL模式
# \sql

# 連接資料庫
# \connect root@localhost:3306

# 資料庫狀態
# \status

# 顯示資料庫
# SHOW databases;

# 使用資料庫
# USE sakila;

# 查詢前6筆資料
# SELECT * FROM rental limit 6; 

##############################
# 4.RStudio 連接MySQL三大方法
##############################

# 方法1 使用 Connections-字串左右二側不用加上雙引號(或單引號)
# Server = localhost; Database = sakila; UID = root; PWD = 123456;

# 方法2 使用dbConnect+寫入密碼
library(odbc)
con <- dbConnect(odbc::odbc(), .connection_string = "Driver={MySQL ODBC 8.0 Unicode Driver};Server = localhost; Database = sakila; UID = root; PWD = 123456;", timeout = 10)

# 顯示資料庫
odbcListObjects(con)

# 顯示資料庫中資料表,檢視等物件
odbcListObjects(con, catalog="sakila")

# 使用 SQL查詢資料
df <- dbGetQuery(con, "SELECT * FROM rental")
class(df) # data.frame
head(df)

# 方法3 使用dbConnect+詢問密碼
con <- dbConnect(odbc::odbc(),
                 Driver= "MySQL ODBC 8.0 Unicode Driver",
                 Server = "localhost",
                 Database = "sakila",
                 UID = "root",
                 PWD = rstudioapi::askForPassword("Database password")
)
# end