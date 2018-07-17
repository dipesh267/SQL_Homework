
use sakila;

#1a
select  first_name, last_name from actor;

#1b
select concat(first_name, " , " ,last_name) as  FOO from actor;

#2a
select actor_id, first_name, last_name from actor 
where first_name="Joe";

#2b
select actor_id, first_name, last_name from actor 
where last_name like "%gen%";

#2c
select actor_id, first_name, last_name from actor 
where last_name like "%li%"
order by last_name, first_name;

#2d
select country_id, country from country
where country.country in ("Afganistan","Bangladesh","China");

#3a
alter table actor
add middle_name varchar(50) after first_name;

#3b
alter table actor
modify middle_name blob;

#3c
alter table actor
drop middle_name;

#4a
select  last_name, count(last_name) 
from actor
group by last_name;

#4b
create view last_name_count as 
select  last_name, count(last_name) lcount
from actor
group by last_name;

select * from last_name_count where lcount > 1;

#4c
update actor 
set first_name = 'Harpo'
where first_name = 'Groucho' and last_name = 'WILLIAMS';

#4d 
update actor
	set first_name=if(first_name='Harpo', 'Groucho', 'Mucho Groucho') 
    where actor_id=172;
    
select * from actor where actor_id=172;
select if(first_name = 'Harpo' and actor_id = 172, 'Groucho', 'Mucho Groucho') from actor where actor_id=172;

#5a
describe address;

#6a
select s.first_name, s.last_name, a.address
from staff s
join address a using(address_id);

#6b
select s.first_name, s.last_name, p.amount, p.payment_date 
from staff s
join payment p using(staff_id)
where p.payment_date between '2005-08-01' and '2005-08-31'
order by payment_date;

#6c 
select f.title, count(fa.actor_id) as actor_count
from film f
join film_actor fa using(film_id)
group by f.title
order by actor_count desc;

#6d
select count(*) from film
join inventory using(film_id) 
where title = 'Hunchback Impossible';

#6e
 select concat(c.first_name," , ", c. last_name) as Customer, sum(p.amount) from payment p
 join customer c using(customer_id)
 group by Customer
 order by Customer;
 
 #7a
 select f.title from film f
 join language l using(language_id)
 where title like 'K%' or title like 'Q%' 
 and l.name='English';
 
#7b
select concat(first_name," , ",last_name) from actor where
actor_id in (
	select actor_id from film_actor
	where film_id = (
		select film_id from film where title ='Alone Trip')
);

#7c
select concat(c.first_name,' , ',c.last_name), c.email, ctry.country from customer c
join address a using(address_id)
join city ct on ct.city_id = a.city_id
join country ctry on ctry.country_id = ct.country_id
and ctry.country = 'Canada';

#7d
select title, ct.name from film f
join film_category fc using(film_id)
join category ct using(category_id)
where name='Family';

#7e
select inv.film_id, fl.title, count(inv.film_id) as film_count from rental rt
join inventory inv using(inventory_id)
join film fl using(film_id)
group by inv.film_id
order by film_count desc;

#7f
select sf.store_id, sum(pm.amount) as total_sale from payment pm
join staff sf using(staff_id)
group by sf.store_id
order by total_sale desc;

#7g
select store_id, city, ctry.country from store
join address ad using (address_id)
join city using(city_id)
join country ctry using(country_id);

#7h
select ctg.name, sum(pm.amount) as total_income  from payment pm
join rental rt using(rental_id)
join inventory inv using(inventory_id)
join film flm using(film_id)
join film_category fctg using(film_id)
join category ctg using(category_id)
group by ctg.name
order by total_income desc limit 5;

#8a
create view top_five_genres as
select ctg.name, sum(pm.amount) as total_income  from payment pm
join rental rt using(rental_id)
join inventory inv using(inventory_id)
join film flm using(film_id)
join film_category fctg using(film_id)
join category ctg using(category_id)
group by ctg.name
order by total_income desc limit 5;

#8b
select * from top_five_genres;

#8c
drop view top_five_genres;


