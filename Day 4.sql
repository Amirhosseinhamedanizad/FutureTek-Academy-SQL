select * from film

/*---------------------------------*/
/*---------------------------------*/

select customer_id, first_name, last_name,
    (select count(*) from rental where rental.customer_id = customer.customer_id) as Rental_count
from customer;
/*---------------------------------*/
/*---------------------------------*/

select
	title,
	rental_duration,
	avg(rental_duration) over () as Overall_Average
from film

select * from film
/*---------------------------------*/
/*---------------------------------*/
select
	title,
	rental_duration, rating,
	avg(rental_duration) over (partition by rating) as Overall_Average
from film
/*---------------------------------*/
/*---------------------------------*/

select customer_id, rental_count
from (
    select customer_id, count(*) as rental_count
    from rental
    group by customer_id
) as rental_counts;

/*---------------------------------*/
/*---------------------------------*/
select customer_id, first_name, last_name
from customer
where customer_id in (
    select customer_id
    from rental
    where return_date IS NULL
)
/*---------------------------------*/
/*---------------------------------*/
select amount, customer_id,
avg(amount) over (partition by extract(month from payment_date)) as Month_average,
extract(month from payment_date) as month, avg(amount) over()
from payment
order by month desc
/*---------------------------------*/
/*---------------------------------*/
select amount, customer_id,
avg(amount) over (partition by extract(month from payment_date)) as Month_average,
extract(month from payment_date) as month,
stddev(amount) over (partition by extract(month from payment_date)) as Month_SD
from payment
order by month desc

/*---------------------------------*/
/*---------------------------------*/

select ct.city, extract(month from p.payment_date) as month, sum(p.amount) as total_payment
from payment p
join customer c on p.customer_id = c.customer_id
join address a on c.address_id = a.address_id
join city ct on a.city_id = ct.city_id
group by ct.city, extract(month from p.payment_date)
having sum (p.amount) > 31
order by total_payment desc;

/*---------------------------------*/
/*---------------------------------*/

with revenue_vs_month as (

select distinct avg(amount) over(partition by extract(month from payment_date)) as month_average,
extract(month from payment_date) as month
from payment
)

select corr(month_average, month)
from revenue_vs_month
/*---------------------------------*/
/*---------------------------------*/

with film_rentals as (
	select inventory.film_id, count(*) as rental_count
	from rental
	join inventory on rental.inventory_id = inventory.inventory_id
	group by inventory.film_id
)
select f.title, fr.rental_count
from film f
join film_rentals fr on f.film_id = fr.film_id
where fr.rental_count > 1




