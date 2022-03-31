show databases;
USE albums_db;
SELECT database();
DESCRIBE albums;
#How many rows are in the albums table? 31
SELECT
    id
FROM albums;
SELECT COUNT(artist)
FROM albums;

#How many unique artist names are in the albums table? 23
SELECT DISTINCT artist
FROM albums;

SELECT COUNT(DISTINCT artist)
FROM albums;

#What is the primary key for the albums table? (id)
SELECT *
FROM albums;

#What is the oldest release date for any album in the albums table? 
#What is the most recent release date?
#1967
#2011
#Sorted rows

#albums by Pink Floyd? 2
SELECT DISTINCT release_date, artist FROM albums;
SELECT name as 'Album Name' FROM albums
WHERE artist = 'Pink Floyd';

#The year Sgt. Pepper's Lonely Hearts Club Band was released? 1967
SELECT DISTINCT(release_date), artist, name
FROM albums;

#The genre for the album Nevermind? Grunge, Alternative Rock
SELECT DISTINCT(genre), name
FROM albums;
SELECT genre FROM albums
WHERE name = 'Nevermind';

#Which albums were released in the 1990s? 11
SELECT DISTINCT(release_date)
FROM albums;

SELECT COUNT(DISTINCT release_date)
FROM albums;

SELECT DISTINCT LEFT(release_date,199)
FROM albums;

SELECT COUNT(DISTINCT release_date, name)
FROM albums
WHERE release_date between 1989 and 1999;
SELECT * FROM albums
WHERE release_date >= 1990
AND release_date < 2000;

#Which albums had less than 20 million certified sales? 11
SELECT COUNT(DISTINCT sales)
FROM albums
WHERE sales < 20;

#All the albums with a genre of "Rock". 
#Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT COUNT(DISTINCT genre)
FROM albums
WHERE genre like '%rock%';

