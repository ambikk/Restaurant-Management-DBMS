insert into manages (inventory_item_id, staff_id) values ('I06-148-4801', 'S96-650-2040');
insert into manages (inventory_item_id, staff_id) values ('I19-632-1004', 'S86-281-7740');
insert into manages (inventory_item_id, staff_id) values ('I95-730-1833', 'S94-828-3547');
insert into manages (inventory_item_id, staff_id) values ('I27-581-8026', 'S99-178-4669');
insert into manages (inventory_item_id, staff_id) values ('I18-523-1712', 'S49-116-0132');
insert into manages (inventory_item_id, staff_id) values ('I30-892-1696', 'S92-680-8722');
insert into manages (inventory_item_id, staff_id) values ('I59-091-5050', 'S71-931-4657');
insert into manages (inventory_item_id, staff_id) values ('I89-063-9771', 'S96-650-2040');
insert into manages (inventory_item_id, staff_id) values ('I82-669-5608', 'S86-281-7740');
insert into manages (inventory_item_id, staff_id) values ('I19-119-2311', 'S94-828-3547');
insert into manages (inventory_item_id, staff_id) values ('I40-560-2319', 'S99-178-4669');
insert into manages (inventory_item_id, staff_id) values ('I98-543-6026', 'S49-116-0132');
insert into manages (inventory_item_id, staff_id) values ('I80-559-5778', 'S92-680-8722');
insert into manages (inventory_item_id, staff_id) values ('I77-203-3728', 'S71-931-4657');
insert into manages (inventory_item_id, staff_id) values ('I87-704-9996', 'S96-650-2040');
insert into manages (inventory_item_id, staff_id) values ('I59-258-4699', 'S86-281-7740');
insert into manages (inventory_item_id, staff_id) values ('I22-724-0414', 'S94-828-3547');
insert into manages (inventory_item_id, staff_id) values ('I26-140-4088', 'S99-178-4669');
insert into manages (inventory_item_id, staff_id) values ('I75-059-7784', 'S49-116-0132');
insert into manages (inventory_item_id, staff_id) values ('I05-215-6356', 'S92-680-8722');
insert into manages (inventory_item_id, staff_id) values ('I08-675-1159', 'S71-931-4657');
insert into manages (inventory_item_id, staff_id) values ('I84-718-3746', 'S96-650-2040');
insert into manages (inventory_item_id, staff_id) values ('I42-079-7968', 'S86-281-7740');
insert into manages (inventory_item_id, staff_id) values ('I60-831-3424', 'S94-828-3547');
insert into manages (inventory_item_id, staff_id) values ('I77-668-0398', 'S99-178-4669');
insert into manages (inventory_item_id, staff_id) values ('I83-705-0986', 'S49-116-0132');
insert into manages (inventory_item_id, staff_id) values ('I39-219-4883', 'S92-680-8722');
insert into manages (inventory_item_id, staff_id) values ('I08-296-1106', 'S71-931-4657');
insert into manages (inventory_item_id, staff_id) values ('I43-933-2597', 'S96-650-2040');
insert into manages (inventory_item_id, staff_id) values ('I97-158-6819', 'S86-281-7740');


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

CREATE TABLE Faculty(
ssn VARCHAR2(20) PRIMARY KEY,
fname VARCHAR2(20), 
frank VARCHAR2(20), 
salary integer, 
phone VARCHAR2(20), 
specialties VARCHAR2(20)
);
drop table faculty;

INSERT INTO Faculty (ssn, fname, frank, salary, phone, specialties) values ('suiGQDIUQD21782', ' AMBIKA CHUDNRU', 'full proffesor', 500000, '8749812498', 'art');
INSERT INTO Faculty (ssn, fname, frank, salary, phone, specialties) values ('suiGQDIUQsd21782', ' AMBIKA fundru', 'proffesor', 800000, '8749def12498', 'sprots');
INSERT INTO faculty (ssn, fname, frank, salary, phone, specialties) values ('suiGQderUQD21782', ' AMBI CHUD', 'full proffesor', 700000, '8749812498', 'geo');


SELECT specialties

FROM Faculty

WHERE frank='full proffesor'AND salary =(select Max(salary) from Faculty);


select specialties, Max(salary) from Faculty
where frank='full proffesor';



SELECT specialties
FROM Faculty 
WHERE frank='full proffesor' AND salary IN
(SELECT salary FROM Faculty MINUS SELECT MAX(salary) 
FROM Faculty); 




SELECT specialties

FROM Faculty

WHERE salary = (SELECT MAX (salary) FROM Faculty WHERE frank='full proffesor');