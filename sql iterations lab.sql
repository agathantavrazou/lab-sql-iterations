-- Write a query to find what is the total business done by each store.
select i.store_id, sum(p.amount) from payment p
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
group by i.store_id;

-- Convert the previous query into a stored procedure
drop procedure if exists total_sum;


DELIMITER //
create procedure total_sum (in param1 int)
begin
declare total_sales_value float default 0.0;
declare flag varchar(20) default "";

select i.store_id, sum(p.amount) as total_sales_value, flag from payment p
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
group by i.store_id
having i.store_id COLLATE utf8mb4_general_ci = param1;

case
    when total_sales_value > 30000 then
	set flag = 'green_flag';
	else
	set flag = 'green_flag';
  end case;

end //
DELIMITER ;

drop procedure if exists total_sum2;

DELIMITER //
create procedure total_sum2 (in param1 int)
begin
declare total_sales_value float default 0.0;
declare flag varchar(20) default "";

select total_sales into total_sales_value from (
select i.store_id as store, sum(p.amount) as total_sales, flag from payment p
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
group by i.store_id
having i.store_id COLLATE utf8mb4_general_ci = param1) sub1;

select total_sales_value, flag;

if total_sales_value > 30000 then
	set flag = 'green_flag';
else
	set flag = 'green_flag';
  end if;
select total_sales_value, flag;
end //
DELIMITER ;

call total_sum2(1);
call total_sum2(2);