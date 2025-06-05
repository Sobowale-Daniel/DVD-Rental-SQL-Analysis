-- first name, last name, and email of customers who have made at least one rental.
SELECT c.first_name,c.last_name,c.email
FROM customer c
JOIN rental r
ON r.customer_id=c.customer_id;

-- film title and the name of the customer who rented it.
SELECT f.title,c.first_name,c.last_name
FROM film f
JOIN inventory iv
ON iv.film_id = f.film_id
JOIN rental r
ON r.inventory_id = iv.inventory_id
JOIN customer c
ON C.customer_id = r.customer_id;

--List all customers, including those who have never made a rental.
SELECT c.first_name,c.last_name,r.rental_id
FROM customer c
LEFT JOIN rental r
ON c.customer_id = r.customer_id;

--List all films and show the rental date if rented, otherwise return NULL for films never rented.
SELECT f.title,r.rental_date
FROM film f
LEFT JOIN inventory iv
ON iv.film_id = f.film_id
LEFT JOIN rental r
ON r.inventory_id = iv.inventory_id;

--List all customers and all rentals, showing matches where they exist.
SELECT c.first_name, r.rental_id
FROM customer c
FULL OUTER JOIN rental r 
ON c.customer_id = r.customer_id;

--film titles and rental dates 
SELECT f.title, r.rental_date
FROM film f
FULL OUTER JOIN inventory iv
ON iv.film_id = f.film_id
FULL OUTER JOIN rental r
ON r.inventory_id = iv.inventory_id;

--LIST OF CUSTOMERS FIRST AND LAST NAME
SELECT first_name,last_name
FROM customer;

--LIST OF FILM TITLE AND RELEASE YEAR
SELECT title,release_year
FROM film;

-- names and emails of customers living in the city of 'Aurora'
SELECT c.first_name,c.last_name,c.email
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
WHERE ci.city = 'Aurora'

-- titles of all films that have a rental duration of more than 5 days.
SELECT title 
FROM film
WHERE rental_duration > 5

-- staff members' first names, last names, and the address of the store they work
SELECT s.first_name,s.last_name,a.address
FROM staff s 
JOIN address a ON a.address_id = s.address_id

-- list of film along with it's language
SELECT f.title, l.name AS Film_language
FROM film f
Join language l ON l.language_id = f.language_id; 

-- 10 most rented films (by title) and how many times each was rented.
SELECT f.title,count(r.rental_id) AS Total_Times_Rented  
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY Total_Times_Rented DESC 
LIMIT 10;

--customer's full name, the number of rentals they've made, and sort the list by most rentals
SELECT CONCAT(c.first_name,'',last_name) AS Full_Name,COUNT(c.customer_id) AS Number_of_Rentals
FROM customer c 
JOIN rental r ON r.customer_id = c.customer_id
GROUP BY Full_Name
ORDER BY Number_of_Rentals DESC;

-- cities that have more than 10 customers.
SELECT ci.city, COUNT(c.customer_id) AS Number_of_Customers
FROM city ci
JOIN address a ON a.city_id = ci.city_id
JOIN customer c ON c.address_id = a.address_id
GROUP BY ci.city
HAVING  COUNT(c.customer_id) > 10;

--titles of films that were rented more than 50 times.
SELECT f.title,COUNT(r.rental_id) AS TOTAL_RENTS
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.title
HAVING COUNT(r.rental_id) > 50;
