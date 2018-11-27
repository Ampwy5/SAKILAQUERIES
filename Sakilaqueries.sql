
-- turninng SQL safe updates off
SET SQL_SAFE_UPDATES = 0;

-- use Sakila database for queries
USE sakila;

-- 1a. Display the first and last names of all actors from the table actor.
SELECT first_name, last_name 
FROM actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. 
-- Name the column Actor Name.
ALTER TABLE actor ADD COLUMN Actor_Name VARCHAR(50);
UPDATE actor SET Actor_Name = CONCAT(first_name, ' ', last_name);
UPDATE actor SET Actor_Name = UPPER(Actor_Name);
SELECT Actor_Name 
FROM actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor WHERE first_name = 'Joe';

-- 2b. Find all actors whose last name contain the letters GEN:
SELECT first_name, last_name
FROM actor 
WHERE last_name LIKE "%Gen%";

-- 2c. Find all actors whose last names contain the letters LI.
-- This time, order the rows by last name and first name, in that order:
SELECT last_name, first_name
FROM actor 
WHERE last_name LIKE "%LI%";

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country FROM country
WHERE country IN ( "Afghanistan", "Bangladesh", "China");

-- 3a. Create a column in the table actor named description and use the data type
ALTER TABLE actor ADD COLUMN Description BLOB;

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. 
-- Delete the description column.
ALTER TABLE actor
DROP COLUMN Description; 

-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*) FROM actor GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(*) from actor group by last_name having count(*) > 1;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. 
-- Write a query to fix the record.
UPDATE actor
SET first_name = 'HARPO' , last_name = 'WILLIAMS' 
WHERE first_name = 'GROUCHO' and last_name = 'WILLIAMS';

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO.
-- It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
SELECT first_name, last_name
FROM actor; 
UPDATE actor 
SET first_name = 'GROUCHO', last_name = 'WILLIAMS' 
WHERE first_name = 'HARPO' and last_name = 'WILLIAMS';

-- 5a. You cannot locate the schema of the address table. 
-- Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. 
-- Use the tables staff and address:
SELECT staff.first_name, staff.last_name, staff.address_id, address.address
FROM staff
INNER JOIN
address ON staff.address_id = address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. 
-- Use tables staff and payment.
SELECT staff.first_name, staff.last_name, staff.staff_id, SUM(payment.amount) as Total_Amount 
FROM staff
INNER JOIN 
payment ON staff.staff_id = payment.staff_id
GROUP by payment.staff_id; 

-- 6c. List each film and the number of actors who are listed for that film. 
-- Use tables film_actor and film. Use inner join.
SELECT film.title, COUNT(film_actor.actor_id) as Total_Actors
FROM film
INNER JOIN 
film_actor ON film.film_id = film_actor.film_id
GROUP by film.title; 

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system? = 6 copies
-- find the film's id from film table then look it up in inventory table 
SELECT film.title, film.film_id, COUNT(inventory.film_id) as Total_Stock
FROM film
INNER JOIN
inventory ON film.film_id = inventory.film_id 
WHERE title = "Hunchback Impossible" 
GROUP by film.film_id;

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name:
SELECT customer.first_name, customer.last_name, SUM(payment.amount) as "Total Amount Paid"
FROM customer
INNER JOIN
payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY last_name ASC;

-- 7a. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT film.title, language.name 
FROM film
INNER JOIN
language ON film.language_Id = language.language_id 
WHERE title LIKE "Q%" or title LIKE "K%" and name = "English";

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT film.title, COUNT(film_actor.actor_id) as Total_Actors
FROM film
INNER JOIN 
film_actor ON film.film_id = film_actor.film_id
WHERE title = "Alone Trip" 
GROUP by film.title; 







