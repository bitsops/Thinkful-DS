--Unit1/Lesson2/Section2
--Drills
--The ID's and durations for all trips of duration greater than 500, ordered by duration.
SELECT trip_id, duration
FROM trips
WHERE duration > 500
ORDER BY duration DESC

--Every column of the stations table for station id 84.
SELECT *
FROM stations
WHERE station_id = 84

--The min temperatures of all the occurrences of rain in zip 94301.
SELECT MinTemperatureF 
FROM weather
WHERE Events = 'Rain' AND ZIP = 94301
ORDER BY MinTemperatureF DESC

--Unit1/Lesson2/Section3
--Drills
--What was the hottest day in our data set? Where was that?

SELECT MaxTemperatureF,Date,ZIP
FROM weather
ORDER BY MaxTemperatureF DESC
LIMIT 1

--How many trips started at each station?
SELECT start_station,COUNT(trip_id) num_trips
FROM trips
GROUP by start_station
ORDER BY num_trips DESC

--What's the shortest trip that happened?
SELECT duration, COUNT(*)
FROM trips
GROUP BY duration
LIMIT 1

SELECT *
FROM trips
WHERE duration = 60

--What is the average trip duration, by end station?

SELECT end_station, AVG(duration) avg_duration
FROM trips
GROUP BY end_station
ORDER BY avg_duration DESC

