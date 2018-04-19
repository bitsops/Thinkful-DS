--Unit1/Lesson2/Section2
--Drills "Select,From,Where"

--1. The ID's and durations for all trips of duration greater than 500, ordered by duration.
SELECT trip_id, duration
FROM trips
WHERE duration > 500
ORDER BY duration DESC

--2. Every column of the stations table for station id 84.
SELECT *
FROM stations
WHERE station_id = 84

--3. The min temperatures of all the occurrences of rain in zip 94301.
SELECT MinTemperatureF 
FROM weather
WHERE Events = 'Rain' AND ZIP = 94301
ORDER BY MinTemperatureF DESC

--Unit1/Lesson2/Section3
--Drills "Aggregates and Groups"

--1. What was the hottest day in our data set? Where was that?
SELECT MaxTemperatureF,Date,ZIP
FROM weather
ORDER BY MaxTemperatureF DESC
LIMIT 1

--2. How many trips started at each station?
SELECT start_station,COUNT(trip_id) num_trips
FROM trips
GROUP by start_station
ORDER BY num_trips DESC

--3. What's the shortest trip that happened?
SELECT duration, COUNT(*)
FROM trips
GROUP BY duration
LIMIT 1

SELECT *
FROM trips
WHERE duration = 60

--4. What is the average trip duration, by end station?

SELECT end_station, AVG(duration) avg_duration
FROM trips
GROUP BY end_station
ORDER BY avg_duration DESC


--Unit1/Lesson2/Section4 
--Drills "Joins and CTEs"

--1. What are the three longest trips on rainy days?
SELECT t.trip_id, MAX(t.duration)
FROM trips t
INNER JOIN weather w
ON substr(t.start_date,0,instr(t.start_date," ")) = w.date
WHERE w.Events = 'Rain'
GROUP BY t.trip_id
ORDER BY MAX(t.duration) DESC
LIMIT 3

--2. Which station is full most often?
WITH
	full_stations
AS (
SELECT station_id, COUNT(*) times_full
FROM status
WHERE docks_available = 0
GROUP BY 1
ORDER BY times_full DESC
LIMIT 1
)

SELECT name
FROM stations
WHERE station_id IN (SELECT station_id FROM full_stations)

--3.Return a list of stations with a count of number of trips starting at that station but ordered by dock count.
WITH
	station_starts
AS (
SELECT start_station, COUNT(*) trips_started
FROM trips
GROUP BY start_station
)

SELECT start_station, trips_started, dockcount
FROM station_starts ss
INNER JOIN stations s
ON ss.start_station = s.name
ORDER BY dockcount DESC

--4. (Challenge) What's the length of the longest trip for each day it rains anywhere?

SELECT substr(start_date,0,instr(start_date," "))  s_date, MAX(duration)
FROM trips 
WHERE s_date IN (SELECT DISTINCT date FROM weather WHERE Events = 'Rain')
GROUP BY s_date
ORDER BY s_date

