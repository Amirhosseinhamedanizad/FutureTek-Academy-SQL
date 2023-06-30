select category_id, count(*) as Category_count
from film_category
group by category_id

/*---------------------------------*/
/*---------------------------------*/

select c.category_id, c.name as category_name, count(*) as film_count
from category c
join film_category fc on c.category_id = fc.category_id
group by c.category_id, c.name
order by film_count desc

/*---------------------------------*/
/*---------------------------------*/
select rating, count(*) as film_count
from film
group by rating

/*---------------------------------*/
/*---------------------------------*/

select c.category_id, c.name as category_name, count(f.film_id) as film_count, sum(p.amount) as Total_amount
from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by c.category_id, c.name
order by total_amount desc

/*---------------------------------*/
/*---------------------------------*/

select f.rating, sum(p.amount) as total_revenue
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by f.rating
order by total_revenue desc

/*---------------------------------*/
/*---------------------------------*/
select c.customer_id, c.first_name, c.last_name, count(*) as rental_count
from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
having count(*) > 30;

/*---------------------------------*/
/*---------------------------------*/

select f.rating, sum(p.amount) as Total_revenue
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by f.rating
having sum(p.amount) > 13000
order by total_revenue desc

/*---------------------------------*/
/*---------------------------------*/

select film_id, title
from film
except
select f.film_id, f.title
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id


/*---------------------------------*/
/*---------------------------------*/