
/* DISPLAY ALL THE name of CUSTOMERS TO WHOM YOU CAN SEND TEXT MESSAGE*/
SELECT cname, phone_number FROM customer WHERE phone_number IS NOT NULL ;


/* Display all the staff who came to work on 1st nov 2021*/
SELECT staff.sname
FROM schedule
INNER JOIN staff ON schedule.staff_id=staff.staff_id WHERE schedule.schedule_date = '01-Nov-21' ;

/* Display the most ordered items and which category do they belong to*/
SELECT item_name, COUNT(*), item_type
FROM orders
GROUP BY item_name, item_type
HAVING COUNT(*) > 2;

/* Display the names of the customers who gave gratuities and used a card to do the payment*/
SELECT DISTINCT C.cname
FROM transactions T
RIGHT JOIN customer C ON  T.customer_id=C.customer_id WHERE gratuities IS NOT NULL AND pay_cash IS NULL;

/* Display the names and dob of the servers who took Bar orders and verfied the card payments done by jbc cards*/
SELECT DISTINCT S.sname, S.dob
FROM staff S, transactions T, orders O
WHERE S.staff_id=T.staff_id AND O.order_id=T.order_id AND T.card_type = 'jbc'

UNION

SELECT DISTINCT S.sname, S.dob
FROM staff S, transactions T, orders O
WHERE S.staff_id=T.staff_id AND O.order_id=T.order_id AND O.item_type = 'Bar';

/* Display the roles of the staff members who can edit the inventory*/
SELECT DISTINCT S.srole, S.sname
FROM staff S, inventory I, manages M
WHERE S.staff_id=M.staff_id AND I.inventory_item_id=M.inventory_item_id;

/* Display the names of the customers who cancled they orders*/

SELECT DISTINCT C.cname
FROM    customer C
WHERE  C.customer_id IN  (   SELECT  O.customer_id
                               FROM  orders O
                               WHERE  O.status='Cancelled');
                               
/* Display the id of the table whose table status is occupied and the order status is served*/
SELECT T.table_id, O.status, t.table_status
FROM sit_table T
INNER JOIN orders O ON T.order_id=o.order_id WHERE t.table_status LIKE 'O%' AND O.status LIKE 'S%' ;

/* Group and display the table based on their type and shape*/
SELECT table_type, table_shape, COUNT(*)
FROM sit_table
GROUP BY table_type, table_shape;