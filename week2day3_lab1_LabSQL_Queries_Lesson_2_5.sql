-- use sakila
use sakila;
-- 1. Select all the actors with the first name ‘Scarlett’.
select * from actor;
select * from sakila.actor
where first_name='Scarlett';

-- 2. How many films (movies) are available for rent and how many films have been rented?
select * from inventory;
select count(distinct(film_id)) as Unique_numb_of_movies from inventory;
select count(inventory_id) as total_films_incl_duplicates from inventory;
--- the above command is same as running count on film without distinct fucntion
select count(distinct(film_id)) as total_films_incl_duplicates from inventory;
-- rented films now it is time for unique inventory id from rental table:
select * from rental;
select count(distinct(inventory_id)) as _number_of_films_rented from rental;
-- this means all implictly that all films and film duplicates have been rented at least once.

/*3. What are the shortest and longest movie duration? 
Name the values `max_duration` and `min_duration`.*/
select * from film;
select max(length) as max_duration,min(length) as min_duration from film;

-- 4. What's the average movie duration expressed in format (hours, minutes)?
select * from film;
select avg(length)/60 as hours from film;
SELECT left(CONVERT((avg(length)*100),TIME),5) AS 'avg-film_duration' FROM film;
-- OR
 SELECT 
	LEFT(round(avg(length))/60,1) as hours,
    round(RIGHT(round(avg(length))/60,4)*60/10000) as minutes
from sakila.film;

-- 5. How many distinct (different) actors' last names are there?
select * from actor;
select count(distinct(last_name)) as number_of_unique_last_names from actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
select * FROM rental;
select (min(last_update)) from rental;
select (max(last_update)) from rental;
select datediff((max(rental_date)),(min(rental_date))) from rental;

-- 7. Show rental info with additional columns month and weekday. Get 20 results.
select * from rental;
SELECT *,EXTRACT(MONTH FROM rental_date) as 'rental_month' from rental;
SELECT *,EXTRACT(DAY FROM rental_date) as 'week_day' from rental;
SELECT *,MONTHNAME(rental_date) as 'rental_month',DAYNAME(rental_date) as 'week_day' from rental LIMIT 20;

/* 8. Add an additional column day_type with values 'weekend' and 'workday' 
depending on the rental day of the week.*/
SELECT rental_date,
CASE
WHEN DAYNAME(rental_date) = 'Monday' then 'week_day'
WHEN DAYNAME(rental_date) = 'Tuesday' then 'week_day'
WHEN DAYNAME(rental_date) = 'Wednesday' then 'week_day'
WHEN DAYNAME(rental_date) = 'Thursday' then 'week_day'
WHEN DAYNAME(rental_date) = 'Friday' then 'week_day'
ELSE 'Week_end'
END AS 'day_type'
FROM rental;

-- 9. How many rentals were in the last month of activity?
select * from rental;
SELECT *,EXTRACT(MONTH FROM rental_date) as 'rental_month' from rental;
select count(rental_id) from rental
where rental_id=5;
-- I tried other ways but could not get my head around it.

-- 10. Get release years.
select * from film;
select release_year from film;

-- 11. Get all films with ARMAGEDDON in the title.
SELECT title FROM film
WHERE title like "%ARMAGEDDON%";

-- 12. Get all films which title ends with APOLLO.
SELECT title FROM film
WHERE title like '%APOLLO';
-- 13. Get 10 the longest films.
select * from film;
SELECT * FROM film
ORDER BY length DESC   
LIMIT 10;

-- 14. How many films include **Behind the Scenes** content?
SELECT count(special_features) FROM film
WHERE special_features like '%Behind the Scenes%';