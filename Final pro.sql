select * from film
-- film_id / title /description / 
select * from film_category
-- film_id / category_id / last_update
 
-- actor_id / first_name / last_name / last_update
select * from film_actor

--Let's initiate the process by establishing a table that presents
--the subsequent particulars: the complete name of the actor formed
--by combining their first and last names as 'full_name', the title of the film,
--a concise depiction of the film, and distinctive attributes or elements of the movie(special_features).
--What is the total count of rows contained within the table?

select CONCAT(a.first_name, ' ', a.last_name) as Full_Name,
f.title , f.description , f.special_features
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on f.film_id = fa.film_id

/*---------------------------------*/
/*---------------------------------*/
--Show the movies available for rental at store ID 1 but unavailable at store ID 2.

select count(film_id)
from inventory
where store_id = 1 and film_id not in
	(select film_id
	 from inventory
	 where store_id = 2)



/*---------------------------------*/
/*---------------------------------*/

/*Compose a query that generates a table comprising of four columns: 
the complete name of the actor, the title of the film, the movie's duration, 
and an additional column labeled 'film_groups' that categorizes films according 
to their length.The 'film_groups' column should encompass four categories: movies 
lasting one hour or less, movies lasting between one to two hours, movies lasting between 
two to three hours,and movies lasting more than three hours.*/


select concat(a.first_name,' ',a.last_name) as actor_Name, f.title, f.length,
case
	when f.length <60  then 'Group I'
    when f.length >60  and f.length<120 then 'Group II'
    when f.length >120 and f.length<180 then 'Group III'
    when f.length >180 then 'Group IV'
end as Film_Groups
FROM actor a
join film_actor fa on a.actor_id=fa.actor_id
join film f on f.film_id=fa.film_id

/*---------------------------------*/
/*---------------------------------*/

--The movie(s) that was rented the most.

select film_id, count(film_id)
from rental r join inventory i
on r.inventory_id = i.inventory_id
group by film_id
order by count(film_id) desc

select count(film_id)
from rental r join inventory i
on r.inventory_id = i.inventory_id
group by film_id
order by count(film_id) desc limit 1

select title 
from film 
where film_id in
	(select film_id
	 from rental r join inventory i
	 on r.inventory_id = i.inventory_id
     group by film_id
	 having count(film_id)=
		 (select count(film_id)
		  from rental r join inventory i
	 	  on r.inventory_id = i.inventory_id
          group by film_id
		  order by count(film_id) desc limit 1))
		  
/*---------------------------------*/
/*---------------------------------*/
--Which movies have not been rented so far.

select title
from film 
where film_id not in
		(select distinct film_id
		 from rental join inventory
		 on rental.inventory_id = inventory.inventory_id)

-- or 

select count(title)
from film 
where film_id not in
		(select distinct film_id
		 from rental join inventory
		 on rental.inventory_id = inventory.inventory_id)





/*---------------------------------*/
/*---------------------------------*/

/*Construct a query that generates a compilation of actors and movies 
where the duration of the movie exceeded 60 minutes. Determine the total
number of rows in the resulting query output.*/

select concat(a.first_name,' ',a.last_name) as actor_Name, 
f.title movie_name
from actor a
join film_actor fa on a.actor_id=fa.actor_id
join film f on f.film_id=fa.film_id
where f.length> 60;

/*---------------------------------*/
/*---------------------------------*/
--Show the names of actors who have appeared in over 30 movies.
select first_name, last_name, count(film_actor.film_id)
from film_actor join actor
on film_actor.actor_id = actor.actor_id
group by (first_name, last_name)
having count(film_actor.film_id) > 30

/*---------------------------------*/
/*---------------------------------*/


/*Compose a query that retrieves the actor ID, full name of the actor, 
and calculates the count of movies made by each actor. Consider whether 
to group the results by actor ID or the full name of the actor. Determine 
the actor who has produced the highest number of movies. Identify the actor 
with the maximum number of movies made, if any, in the context of Gina Degeneres.*/

select a.actor_id, concat(a.first_name,' ',a.last_name) as actor_Name,
count(*) Movie_count
from actor a
join film_actor fa ON a.actor_id=fa.actor_id
join film f ON f.film_id=fa.film_id
group by 1,2
order by count(*)desc;

/*---------------------------------*/
/*---------------------------------*/

--Which movies have been rented so far.

select title
from film 
where film_id in
		(select distinct film_id
		 from rental join inventory
		 on rental.inventory_id = inventory.inventory_id)

-- or 

select count(title)
from film 
where film_id in
		(select distinct film_id
		 from rental join inventory
		 on rental.inventory_id = inventory.inventory_id)



/*---------------------------------*/
/*---------------------------------*/


/*"Construct a query that generates a count of movies within each of the four 
film length groups: movies lasting one hour or less, movies lasting between one 
to two hours, movies lasting between twoto three hours, and movies lasting more than
three hours.*/

select distinct(Film_groups),
      count(title) over (partition by  film_groups) as Filmcount_bylencat
from  
     (select title,length,
      case when length <= 60 then '1 hour or less'
      when length > 60 and length <= 120 then 'Between 1-2 hours'
      when length > 120 and length <= 180 then 'Between 2-3 hours'
      else 'More than 3 hours' end as  Film_groups
      from film ) t1
order by  Film_groups