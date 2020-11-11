/*
Lab | SQL Iterations

In this lab, we will continue working on the Sakila database of movie rentals.

Instructions

Write queries to answer the following questions:

1. Write a query to find what is the total business done by each store.
2. Convert the previous query into a stored procedure.
3. Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
4. Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). Call the stored procedure and print the results.
5. In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.*/

use sakila;

-- 1. Write a query to find what is the total business done by each store.

select s.store_id, sum(p.amount) from payment p
join store s on s.manager_staff_id = p.staff_id
group by s.store_id;

-- 2. Convert the previous query into a stored procedure.

drop procedure if exists store_1;
delimiter //

create procedure store_1()

begin
	select s.store_id, sum(p.amount) from payment p
	join store s on s.manager_staff_id = p.staff_id
	group by s.store_id;
end;
//
delimiter ;

call store_1();

-- 3. Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.

drop procedure if exists store_2;

delimiter //

create procedure store_2(in store_in integer)

begin

	select s.store_id, sum(p.amount) as total from payment p
	join store s on s.manager_staff_id = p.staff_id
	where s.store_id = store_in
	group by s.store_id;

end;
//
delimiter ;

call store_2(1);

-- 4. Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). Call the stored procedure and print the results.

-- ERROR
drop procedure if exists store_3;

delimiter //

create procedure store_3(in store_in int)

begin

declare total_sales_value float default 0.0;

	select sum(p.amount) into total_sales_value from payment p
	join store s on s.manager_staff_id = p.staff_id
	where s.store_id = store_in
	group by s.store_id;
	
	select store_in, total_sales_value;
		
end;
//
delimiter ;

call store_3(1);



-- 5. In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value

drop procedure if exists store_4;

delimiter //

create procedure store_4(in store_in integer)

begin
	declare flag char(10) default '';
	declare total_sales_value float default 0.0;

	select sum(p.amount) into total_sales_value from payment p
	join store s on s.manager_staff_id = p.staff_id
	where s.store_id = store_in
	group by s.store_id;
	
	case 
		when total_sales_value > 30000 then set flag = 'green';
		else set flag = 'red';
	end case;
	
	select store_in, total_sales_value, flag;
	
end;
//
delimiter ;

call store_4(1);