create database if not exists wc_assignment_12;

-- pizzas --
create table if not exists pizzas (
	pizza_id int unique not null auto_increment,
    pizza_name varchar(50) not null,
    pizza_price decimal(50, 2) not null,
    primary key (pizza_id)
);
insert into pizzas (pizza_name, pizza_price)
values ('Pepperoni & Cheese', 7.99);
insert into pizzas (pizza_name, pizza_price)
values ('Vegetarian', 9.99);
insert into pizzas (pizza_name, pizza_price)
values ('Meat Lovers', 14.99);
insert into pizzas (pizza_name, pizza_price)
values ('Hawaiian', 12.99);

-- customers --
create table if not exists customers (
	customer_id int not null auto_increment,
    customer_name varchar(100) not null,
    customer_phone_number varchar(15) not null,
    primary key (customer_id)
);
insert into customers (customer_name, customer_phone_number)
values ('Trevor Page', '226-555-4982');
insert into customers (customer_name, customer_phone_number)
values ('John Doe', '555-555-9498');

-- orders --
create table if not exists orders (
	order_id int not null auto_increment,
    order_customer int not null,
    order_date_time timestamp not null,
    order_p1_quantity int null,
    order_p2_quantity int null,
	order_p3_quantity int null,
    order_p4_quantity int null,
    primary key (order_id)
);
insert into orders (order_customer, order_date_time, order_p1_quantity, order_p3_quantity)
values ( '1', '2014-09-10 09:47:00', '1', '1');
insert into orders (order_customer, order_date_time, order_p2_quantity, order_p3_quantity)
values ('2', '2014-09-10 13:20:00', '1', '2');
insert into orders (order_customer, order_date_time, order_p3_quantity, order_p4_quantity)
values ('1', '2014-09-10 09:57:00', '1', '1');
insert into orders (order_customer, order_date_time, order_p2_quantity, order_p3_quantity)
values ('2', '2014-10-10 14:20:00', '1', '2');

-- customer orders --
CREATE TABLE customer_orders (
  customer_id int not null,
  order_id int not null,
  foreign key (customer_id) references customers (customer_id),
  foreign key (order_id) references orders (order_id)
);
insert into customer_orders (customer_id, order_id)
values ('1', '1');
insert into customer_orders (customer_id, order_id)
values ('2', '2');
insert into customer_orders (customer_id, order_id)
values ('1', '3');
insert into customer_orders (customer_id, order_id)
values ('2', '4');


-- order pizzas --
CREATE TABLE order_pizzas (
  order_id int not null,
  pizza_id int not null,
  quantity int not null,
  foreign key (order_id) references orders (order_id),
  foreign key (pizza_id) references pizzas (pizza_id)
);
insert into order_pizzas (order_id, pizza_id, quantity)
values ('1', '1', '1');
insert into order_pizzas (order_id, pizza_id, quantity)
values ('1', '3', '1');
insert into order_pizzas (order_id, pizza_id, quantity)
values ('2', '2', '1');
insert into order_pizzas (order_id, pizza_id, quantity)
values ('2', '3', '2');
insert into order_pizzas (order_id, pizza_id, quantity)
values ('3', '3', '1');
insert into order_pizzas (order_id, pizza_id, quantity)
values ('3', '4', '1');
insert into order_pizzas (order_id, pizza_id, quantity)
values ('4', '2', '1');
insert into order_pizzas (order_id, pizza_id, quantity)
values ('4', '3', '2');

-- practice --
select order_id,
	sum(quantity*p.pizza_price) as order_total 
from order_pizzas op
join pizzas p on p.pizza_id = op.pizza_id
group by order_id;

-- Q4 --
select customer_id,
	sum(op.quantity*p.pizza_price) as customer_total 
from customer_orders cu
join order_pizzas op on op.order_id = cu.order_id
join pizzas p on p.pizza_id = op.pizza_id
group by customer_id;

-- Q5 --
select order_date_time, order_customer, 
	sum(op.quantity*p.pizza_price) as order_total 
from orders o
join customer_orders cu on cu.order_id = o.order_id
join order_pizzas op on op.order_id = cu.order_id
join pizzas p on p.pizza_id = op.pizza_id
group by order_date_time;
