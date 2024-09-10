USE restaurant_db;

-- 1.View the menu_items table.

select * from menu_items;

-- 2.Find the number of items on the menu.

select count(*) from menu_items;

-- 3.What are the least and most expensive items on the menu?

select * from menu_items 
ORDER by Price;

select * from menu_items
ORDER by Price DESC;

-- 4.How many Italian dishes are on the menu?
select * from menu_items
WHERE category='Italian';

-- 5.What are the least and most expensive Italian dishes on the menu?
select * from menu_items
WHERE category='Italian'
ORDER by price;

select * from menu_items
WHERE category='Italian'
ORDER by price DESC;

-- 6.How many dishes are in each category?
select category,count(menu_item_id) AS num_dishes from menu_items
GROUP BY category;

-- 7.What is the average dish price within each category?
select category,AVG(price) AS avg_dishes from menu_items
GROUP BY category;

#order_details table

-- 8. View the order_details table.
select * from order_details;

-- 9.What is the date range of the table?
select MIN(order_date), MAX(order_date) from order_details;

-- 10.How many orders were made within this date range?

select COUNT(DISTINCT order_id) from order_details;

-- 11.How many items were ordered within this data range?
select COUNT(*) from order_details;

-- 12.Which orders had the most number of items?
select order_id, COUNT(item_id) AS num_items
from order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- 13.How many orders had more than 12 items?
select COUNT(*) from
(select order_id, COUNT(item_id) AS num_items
from order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders;


-- 14.Combine the menu_items and order_details tables into a single table.

select * from menu_items;
select * from order_details;

select * 
from order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.menu_item_id;
   
   
   -- 15.What were the least and most ordered items?what catagories were they in?
   
select item_name, category, COUNT(order_details_id) AS num_purchases
from order_details od LEFT JOIN menu_items mi
     ON od.item_id = mi.menu_item_id
  GROUP BY item_name,category
  ORDER BY num_purchases;


-- 16.What were the top 5 orders that spent the most money?


select order_id, SUM(price) AS total_spend
from order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.menu_item_id
   GROUP BY order_id
   ORDER BY total_spend DESC
   LIMIT 5;

-- 17.view the details of the highest spend category order.

select category, COUNT(item_id) AS num_items
from order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.menu_item_id
   WHERE order_id = 440
   GROUP BY category;
   
   
   -- 18.View the details of the top 5 highest spend orders.
   
select order_id, category, COUNT(item_id) AS num_items
from order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.menu_item_id
   WHERE order_id IN (440,2070,1957,330,2675)
   GROUP BY order_id, category;

   
 