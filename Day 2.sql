select count(distinct first_name || last_name)
from actor

select distinct a1.first_name, a2.last_name
from actor a1 join actor a2
on a1.actor_id <> a2.actor_id and a1.first_name = a2.first_name and a1.last_name = a2.last_name

/*---------------------------------*/
/*---------------------------------*/

select c1.first_name, c1.last_name, c2.first_name, c2.last_name
from customer c1 join customer c2
on c1.customer_id <> c2.customer_id and c1.address_id = c2.address_id

/*---------------------------------*/
/*---------------------------------*/
--Display the total amount payed by all customers in the payment table.
select sum(amount)
from payment

/*---------------------------------*/
/*---------------------------------*/
--Display the total amount payed by each customer in the payment table.
select customer_id, sum(amount)
from payment
group by customer_id
order by customer_id

/*---------------------------------*/
/*---------------------------------*/
--The highest total_payment done.

select sum(amount) as Total_payments
from payment
group by customer_id
order by sum(amount) desc limit 1
/*---------------------------------*/
/*---------------------------------*/
--The name of the customer who made the highest total payments.

select first_name, last_name
from customer
where customer_id in 
	(select customer_id
	 from payment
	 group by customer_id
	 order by sum(amount) desc limit 1)

/*---------------------------------*/
/*---------------------------------*/
--Show the number of movies each actor acted in.

select actor_id, count(film_id)
from film_actor
group by actor_id
order by actor_id

select first_name, last_name, count(film_actor.film_id)
from film_actor join actor
on film_actor.actor_id = actor.actor_id
group by (first_name, last_name)

/*---------------------------------*/
/*---------------------------------*/