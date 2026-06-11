create database Ola_Analysis;

CREATE TABLE Bengaluru_Ola_Booking_Analysis (
    id BIGSERIAL PRIMARY KEY,
    date_DATE,
    time_TIME,
    booking_id VARCHAR(10) UNIQUE,
    booking_status VARCHAR(50),
    customer_id VARCHAR(20),
    vehicle_type VARCHAR(20),
    pickup_location VARCHAR(100),
    drop_location VARCHAR(100),
    avg_vtat NUMERIC(5,2),
    avg_ctat NUMERIC(5,2),
    cancelled_rides_by_customer INTEGER DEFAULT 0,
    reason_for_cancelling_by_customer VARCHAR(255),
    cancelled_rides_by_driver INTEGER DEFAULT 0,
    reason_for_cancelling_by_driver VARCHAR(255),
    incomplete_rides INTEGER DEFAULT 0,
    incomplete_rides_reason VARCHAR(255),
    booking_value NUMERIC(10,2),
    ride_distance NUMERIC(8,2),
    driver_ratings NUMERIC(3,1),
    customer_rating NUMERIC(3,1)
);

SELECT * FROM Bengaluru_Ola_Booking_Analysis;



SELECT * 
FROM information_schema.tables
WHERE table_name = 'Bengaluru_Ola_Booking_Analysis';

TRUNCATE TABLE bengaluru_ola_booking_analysis;

SELECT COUNT(*) 
FROM bengaluru_ola_booking_analysis;

SELECT booking_id, COUNT(*)
FROM bengaluru_ola_booking_analysis
GROUP BY booking_id
HAVING COUNT(*) > 1;

ALTER TABLE bengaluru_ola_booking_analysis
DROP CONSTRAINT bengaluru_ola_booking_analysis_booking_id_key;

SELECT COUNT(*) 
FROM bengaluru_ola_booking_analysis;

TRUNCATE TABLE bengaluru_ola_booking_analysis;

SELECT * FROM bengaluru_ola_booking_analysis;


1. Retrieve all successful bookings:

CREATE VIEW successful_bookings AS
 SELECT * FROM bengaluru_ola_booking_analysis
  WHERE booking_status = 'Successful'

SELECT * FROM SUCCESSFUL_BOOKINGS;


2. Find the average ride distance for each vehicle type:

CREATE VIEW average_ride_distance_for_each_vehicle AS 
SELECT
    vehicle_type,
    AVG(ride_distance) AS avg_ride_distance
FROM bengaluru_ola_booking_analysis
GROUP BY vehicle_type;


3. Get the total number of cancelled rides by customers:

CREATE VIEW number_of_cancelled_rides_by_customers AS
SELECT COUNT (*) FROM BENGALURU_OLA_BOOKING_ANALYSIS 
   WHERE BOOKING_STATUS ='CANCELLED_RIDES_BY_DRIVER'

SELECT * FROM number_of_cancelled_rides_by_customers;


4. List the top 5 customers who booked the highest number of rides:

CREATE VIEW top_5_customers_who_booked_the_highest_number_of_rides AS
SELECT customer_id, COUNT (booking_id) as total_rides
 FROM bengaluru_ola_booking_analysis
   GROUP BY customer_id
     ORDER BY total_rides DESC LIMIT 10;

SELECT * FROM top_5_customers_who_booked_the_highest_number_of_rides;

5. Get the number of rides cancelled by drivers due to personal and car-related issues:

SELECT COUNT(*)
FROM bengaluru_ola_booking_analysis
WHERE reason_for_cancelling_by_driver = 'personal and car-related issue';

6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

SELECT MAX (driver_ratings) AS max_rating,
       MIN  (driver_ratings) AS min_rating
FROM bengaluru_ola_booking_analysis
WHERE vehicle_type = 'Prime Sedan ';

7. Find the average customer rating per vehicle type:

CREATE VIEW  avg_customer_rating as 
SELECT vehicle_type, avg (customer_rating) as vehicle_rating
 FROM bengaluru_ola_booking_analysis
  GROUP BY vehicle_type;

SELECT * FROM avg_customer_rating;
  
8. Calculate the total booking value of rides completed successfully:

SELECT SUM(booking_value) AS total_booking_value
FROM bengaluru_ola_booking_analysis
WHERE booking_status = 'Success';

SELECT booking_status, COUNT(*)
FROM bengaluru_ola_booking_analysis
GROUP BY booking_status;

SELECT SUM(booking_value) as booking_success
 FROM bengaluru_ola_booking_analysis
GROUP BY booking_status = 'success';

