					-- Originally Project 2, rewritten to Project 3

USE master
GO
--Drop disk_inventoryKS Database if it already exists
DROP DATABASE IF EXISTS disk_inventoryKS
GO
--After dropping, then create the database
CREATE DATABASE disk_inventoryKS
GO

USE disk_inventoryKS

--Create User
IF SUSER_ID ('labuser') IS NULL
	CREATE LOGIN labuser WITH PASSWORD = 'MSPress#1', DEFAULT_DATABASE = disk_inventoryKS;

	USE disk_inventoryKS;

	IF USER_ID ('labuser') IS NULL
	CREATE USER labuser;

	ALTER ROLE db_datareader ADD MEMBER labuser;

--Create Tables

CREATE TABLE status -- Create status Table
(
status_id INT PRIMARY KEY IDENTITY,
description VARCHAR(100) NOT NULL,
);

CREATE TABLE disk_type -- Create disk_type Table
(
disk_type_id INT PRIMARY KEY IDENTITY,
description VARCHAR(100) NOT NULL
);

CREATE TABLE genre -- Create genre table
(
genre_id INT PRIMARY KEY IDENTITY,
description VARCHAR(100) NOT NULL
);

CREATE TABLE artist_type -- Create artist_type table
(
artist_type_id INT PRIMARY KEY IDENTITY,
description VARCHAR(50) NOT NULL
);

CREATE TABLE artist -- Create artist table
(
artist_id INT PRIMARY KEY IDENTITY,
fname VARCHAR(20) NOT NULL,
lname VARCHAR(20) NOT NULL,
artist_type_id INT NOT NULL REFERENCES artist_type (artist_type_id)
);

CREATE TABLE borrower -- Create borrower table
(
borrower_id INT PRIMARY KEY IDENTITY,
fname VARCHAR(20) NOT NULL,
lname VARCHAR(20) NOT NULL,
phone_number INT NOT NULL
);

CREATE TABLE disk -- Create disk table
(
disk_id INT PRIMARY KEY IDENTITY,
disk_name VARCHAR(50) NOT NULL,
release_date DATE NOT NULL,
genre_id INT NOT NULL REFERENCES genre (genre_id),
status_id INT NOT NULL REFERENCES status (status_id),
disk_type_id INT NOT NULL REFERENCES disk_type (disk_type_id)
);

--Altered table to include correct columns
DROP TABLE IF EXISTS disk_has_borrowed
CREATE TABLE disk_has_borrowed
	(
	disk_has_borrowed_id	INT NOT NULL PRIMARY KEY IDENTITY,
	borrowed_date			DATETIME2 NOT NULL,
	due_date				DATETIME2 NOT NULL DEFAULT (GETDATE() + 30),
	returned_date			DATETIME2 NULL,
	borrower_id				INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id					INT NOT NULL REFERENCES disk(disk_id)		
	);

CREATE TABLE disk_has_artist -- Create disk_has_artist table
(
disk_has_artist_id INT PRIMARY KEY IDENTITY,
disk_id INT NOT NULL REFERENCES disk (disk_id),
artist_id INT NOT NULL REFERENCES artist (artist_id),
);
--Disk_type, Genre, & Status – insert 5+ rows into each using real-world data
INSERT INTO disk_type (description)
VALUES ('Vinyl'), ('CD'), ('DAT'), ('MiniDisc'), ('Cassette')

INSERT INTO genre (description)
VALUES ('Rock'), ('Pop'), ('Metal'), ('Rap'), ('Hip Hop')

INSERT INTO status (description)
VALUES ('available'), ('borrowed'), ('broken'), ('lost'), ('reserved')
/*
	Disk table:
	Insert at least 20 rows of data into the table using real-world disk names
	Update only 1 row using a where clause
	At least 1 disk has only 1 word in the name
	At least 1 disk has only 2 words in the name
	At least 1 disk has more than 2 words in the name
*/
INSERT INTO disk (disk_name, release_date, genre_id, status_id, disk_type_id)
	VALUES 
	('Sign O the Times', '1987-03-31', '1', '2', '5'),('Revolver', '1966-08-05', '2', '4', '4'),('Rumours', '1977-02-04', '3', '1', '3'),('Rubber Soul', '1965-12-03', '4', '3', '2'),
	('Graceland', '1986-08-12', '5', '5', '1'),('Abbey Road', '1969-09-26', '1', '1', '5'),('Court and Spark', '1974-01-17', '2', '2', '4'),('Pet Sounds', '1966-05-16', '3', '4', '3'),
	('Third', '1978-03-18', '4', '1', '2'),('Achtung Baby', '1991-11-18', '5', '3', '1'),('Tapestry', '1971-02-10', '1', '5', '5'),('A Hard Days Night', '1964-07-10', '2', '4', '4'),
	('All Things Must Pass', '1970-11-27', '3', '1', '3'),('Happier Than Ever',  '2021-07-30', '4', '3', '2'),('Thriller', '1982-11-30', '5', '5', '1'),('The SMiLE Sessions', '2011-11-01', '1', '2', '5'),
	('Tunnel of Love', '1987-10-09', '2', '4', '4'),('Purple Rain',  '1984-06-25', '3', '1', '3'),('Help',  '1965-08-06', '4', '3', '2'),('SOUR', '2021-05-21', '5', '5', '1')
	UPDATE disk
	SET disk_name = 'Midnights', release_date = '2022-10-21', genre_id = '2', status_id = '1', disk_type_id = '2'
	WHERE disk_name= 'All Things Must Pass'
	SELECT * FROM disk
/*
	Borrower table:
	Insert at least 21 rows of data into the table using real-world borrower names
	Delete only 1 row using a where clause
*/
INSERT INTO borrower (fname, lname, phone_number)
	VALUES ('Barrett','Fisher', '2080000000'),('Elliot','Rice', '2080000001'),('Ismael','Marks', '2080000002'),('Nyasia','Macias', '2080000003'),
	('Danica','Klein', '2080000004'),('Tamia','Archer', '2080000005'),('Aarav','Johnston', '2080000006'),('Carmelo','Wilkerson', '2080000007'),
	('Naomi','Gonzales', '2080000008'),('Amelia','Ballard', '2080000009'),('Gordon','Sandoval', '2080000010'),('Reese','Bond', '2080000011'),
	('Tyler','Edwards', '2080000012'),('Andres','Rios', '2080000013'),('Melody','Pena', '2080000014'),('Mattie','Donovan', '2080000015'),
	('Luis','Chapman', '2080000016'),('Brenton','Walter', '2080000017'),('Eddie','Everett', '2080000018'),('Davin','Manning', '2080000019'),('Kody','Galloway', '2080000020')
	DELETE FROM borrower
	WHERE fname='Kody' AND lname='Galloway'
	SELECT * FROM borrower
/*
	DiskHasBorrower table:
	Insert at least 20 rows of data into the table
	Insert at least 2 different disks
	Insert at least 2 different borrowers
	At least 1 disk has been borrowed by the same borrower 2 different times
	At least 1 disk in the disk table does not have a related row here
	At least 1 disk must have at least 2 different rows here
	At least 1 borrower in the borrower table does not have a related row here
	At least 1 borrower must have at least 2 different rows here
*/
INSERT INTO disk_has_borrowed
(borrowed_date, due_date, returned_date, borrower_id, disk_id)
VALUES
('01-01-2024', '01-30-2024', '01-15-2024', '1', '1'), ('01-02-2024', '02-01-2024', '01-16-2024', '6', '2'), 
('01-03-2024', '02-02-2024', '01-17-2024', '11', '3'), ('01-04-2024', '02-03-2024', '01-18-2024', '16', '4'), 
('01-05-2024', '02-04-2024', '01-19-2024', '2', '5'), ('01-06-2024', '02-05-2024', NULL, '7', '6'), 
('01-07-2024', '02-06-2024', '01-21-2024', '12', '7'), ('01-08-2024', '02-07-2024', '01-22-2024', '17', '8'), 
('01-09-2024', '02-08-2024', '01-23-2024', '3', '9'), ('01-10-2024', '02-09-2024', '01-24-2024', '8', '10'), 
('01-11-2024', '02-10-2024', NULL, '13', '11'), ('01-12-2024', '02-11-2024', '01-26-2024', '18', '12'), 
('01-13-2024', '02-12-2024', '01-27-2024', '4', '13'), ('01-14-2024', '02-13-2024', '01-28-2024', '9', '14'), 
('01-15-2024', '02-14-2024', '01-29-2024', '14', '15'), ('01-16-2024', '02-15-2024', NULL, '19', '16'), 
('01-17-2024', '02-16-2024', '01-31-2024', '5', '17'), ('01-18-2024', '02-17-2024', '02-01-2024', '10', '18'), 
('01-19-2024', '02-18-2024', '02-02-2024', '1', '1'), ('01-20-2024', '02-19-2024', '02-02-2024', '20', '20') 
--Borrower 1 appears twice, borrowing the same disk 1 on 01-19-2024 
--Borrower 15 does not have a related row here, neither does disk 19
SELECT * FROM disk_has_borrowed

/*	Create a query to list the disks that are on loan and have not been returned.
Sample Output:
Borrower_id   Disk_id  	Borrowed_date		Return_date 
9		2	2012-04-02		NULL
9		4	2012-04-02		NULL
*/
SELECT * FROM disk_has_borrowed
WHERE returned_date IS NULL
--OR? Specified version...
SELECT borrower_id, disk_id, borrowed_date, returned_date
FROM disk_has_borrowed
WHERE returned_date IS NULL

							-- PROJECT FOUR!!! February 8, 2024

-- STEP ONE
/*Selects all columns from disk, disk_type, genre, and status.
Joins disk_type to allow access to description, joins genre to allow access to description, joins status to allow access to description*/
SELECT disk.disk_name AS [Disk Name], disk.release_date as [Release Date],
disk_type.description AS Type, genre.description AS Genre, status.description AS Status
FROM disk
INNER JOIN disk_type ON disk.disk_type_id = disk_type.disk_type_id
INNER JOIN genre ON disk.genre_id = genre.genre_id
INNER JOIN status ON disk.status_id = status.status_id

-- STEP TWO
/*Selects all columns from lname, fname, disk_name, borrowed_date, and returned - assigns names as appropriate
Joins borrower to allow access to lname and fname, joins disk to allow access to returned_date*/
SELECT borrower.lname AS Last, borrower.fname AS First, disk.disk_name AS [Disk Name],
FORMAT(disk_has_borrowed.borrowed_date, 'yyyy-MM-dd') AS [Borrowed Date], FORMAT(disk_has_borrowed.returned_date, 'yyyy-MM-dd') AS [Returned Date]
FROM disk_has_borrowed  
INNER JOIN borrower ON disk_has_borrowed.borrower_id = borrower.borrower_id
INNER JOIN disk ON disk_has_borrowed.disk_id = disk.disk_id;

-- STEP THREE
/*Selects all columns from disk_name, paired with COUNT(...), GROUP BY finds the amount of times a borrower_id has been in the borrower table, 
and then groups it by how many times it was associated with one disk. Returns only rows/disks where a borrower has been associated with it more than once*/
SELECT disk.disk_name AS [Disk Name], COUNT(borrower.borrower_id) AS [Times Borrowed] 
FROM disk_has_borrowed
INNER JOIN disk ON disk_has_borrowed.disk_id = disk.disk_id
INNER JOIN borrower ON disk_has_borrowed.borrower_id = borrower.borrower_id
GROUP BY disk_name
HAVING COUNT(borrower.borrower_id) > 1;

-- STEP FOUR
/*Selects disk_name, the formatted borrowed_date, returned_date, lname, and fname -- assigns all as appropriate
If the returned date is null, then the disk has not been returned. Therefore, it is outstanding. If it is not null, then it has been returned.
Returns only "Outstanding" loans. Ommit WHERE clause to show which disks have been returned and which ones are still outstanding*/
SELECT disk.disk_name AS [Disk Name], FORMAT(borrowed_date, 'yyyy-MM-dd') as Borrowed,
CASE WHEN returned_date IS NULL THEN 'Outstanding'
ELSE 'Returned' END AS 'Returned', 
borrower.lname AS [Last Name], borrower.fname AS [First Name]
FROM disk_has_borrowed 
INNER JOIN disk ON disk_has_borrowed.disk_id = disk.disk_id
INNER JOIN borrower ON disk_has_borrowed.borrower_id = borrower.borrower_id
WHERE returned_date IS NULL;

-- STEP FIVE
/*In the case that View_Borrower_No_Loans_Join Exists, 
it is dropped so it can be recreated*/
DROP VIEW IF EXISTS View_Borrower_No_Loans_Join;
GO

/*Selects lname and fname from borrower, selects borrower_id from disk_has_borrowed for subquery.
Joins disk table, names left join subquery as borrowed_disks.
Filters to where any lname and fname that do not exist in borrowed_disks query are shown*/
CREATE VIEW View_Borrower_No_Loans_Join AS -- Creates the view
SELECT borrower.lname AS LastName, borrower.fname AS FirstName
FROM borrower
LEFT JOIN (
    SELECT disk_has_borrowed.borrower_id
    FROM disk_has_borrowed -- 
    INNER JOIN disk ON disk_has_borrowed.disk_id = disk.disk_id -- 
) AS borrowed_disks ON borrower.borrower_id = borrowed_disks.borrower_id -- 
WHERE borrowed_disks.borrower_id IS NULL;
GO

-- STEP SIX
DROP VIEW IF EXISTS View_Borrower_No_Loans_SubQ; /*In the case that View_Borrower_No_Loans_SubQ Exists, 
it is dropped so it can be recreated*/
GO

/*Selects lname and fname from borrower. Selects borrower_id in a subquery, filters by whether the borrower is in the disk_has_borrowed table*/
CREATE VIEW View_Borrower_No_Loans_SubQ AS
SELECT lname AS LastName, fname AS FirstName
FROM borrower
WHERE borrower.borrower_id NOT IN (
    SELECT disk_has_borrowed.borrower_id
    FROM disk_has_borrowed
    INNER JOIN disk ON disk_has_borrowed.disk_id = disk.disk_id
);
GO

-- STEP SEVEN
/* Selects all columns from lname and fname, Paired with COUNT(...), GROUP BY finds the amount of times a borrower_id has been in the borrower table,
and then groups it by how many times it was associated with one disk.
Returns only borrowers that have borrowed more than one disk
*/
SELECT borrower.lname AS [Last Name], borrower.fname AS [First Name],
COUNT(disk_has_borrowed.borrower_id) AS [Disks Borrowed]
FROM disk_has_borrowed
INNER JOIN disk ON disk_has_borrowed.disk_id = disk.disk_id
INNER JOIN borrower ON disk_has_borrowed.borrower_id = borrower.borrower_id
GROUP BY borrower.lname, borrower.fname 
HAVING COUNT(disk_has_borrowed.borrower_id) > 1