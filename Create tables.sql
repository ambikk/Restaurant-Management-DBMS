CREATE TABLE customer (
    customer_id VARCHAR2(20)NOT NULL,
    cname VARCHAR2(40) NOT NULL,
    phone_number INTEGER,
    cpassword VARCHAR2(40),
    address VARCHAR2(40),
    dob DATE,
    PRIMARY KEY(customer_id)
);

CREATE TABLE staff (
    staff_id VARCHAR2(20) NOT NULL,
    sname VARCHAR2(40) NOT NULL,
    srole VARCHAR2(40) NOT NULL,
    email_id VARCHAR2(40),
    phone_number INTEGER NOT NULL,
    spassword VARCHAR2(40) NOT NULL,
    address VARCHAR2(40)NOT NULL,
    dob DATE NOT NULL,
    PRIMARY KEY(staff_id)
);



CREATE TABLE orders (
    order_id VARCHAR2(40) PRIMARY KEY,
    status VARCHAR2(40)  ,
    item_name VARCHAR2(40),
    quantity INTEGER,
    arrival_time TIMESTAMP,
    reservation_time TIMESTAMP NOT NULL,
    item_type VARCHAR2(40),
    customer_id VARCHAR2(40) NOT NULL,
    CONSTRAINT FK_customerorders FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE sit_table (
    table_id VARCHAR2(40) NOT NULL,
    table_type VARCHAR2(40) NOT NULL,
    table_capacity INTEGER NOT NULL,
    table_shape VARCHAR2(40) NOT NULL,
    table_status  VARCHAR2(40) NOT NULL,
    order_id  VARCHAR2(40),
    PRIMARY KEY (table_id),
    CONSTRAINT FK_orderstable FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE transactions (
    transaction_id VARCHAR2(40) NOT NULL,
    gratuities INTEGER,
    total_amount INTEGER NOT NULL,
    pay_cash VARCHAR(40),
    card_number INTEGER,
    card_type VARCHAR(40),
    customer_id VARCHAR2(40) NOT NULL,
    order_id VARCHAR2(40) NOT NULL,
    staff_id VARCHAR2(40) NOT NULL,
    PRIMARY KEY (transaction_id),
    CONSTRAINT FK_customertransaction FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT FK_orderstransaction FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT FK_stafftransaction FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE schedule (
    staff_id VARCHAR2(40) NOT NULL,
    schedule_date DATE NOT NULL,
    start_time TIMESTAMP NOT NULL,
    out_time TIMESTAMP NOT NULL,
    PRIMARY KEY (staff_id, schedule_date),
    CONSTRAINT FK_staffschedule FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE menu_item (
    menu_item_id VARCHAR2(40) NOT NULL,
    menu_item_name VARCHAR2(40) NOT NULL,
    menu_item_category VARCHAR2(40) NOT NULL,
    menu_item_price INTEGER NOT NULL,
    PRIMARY KEY(menu_item_id)
);

CREATE TABLE inventory (
    inventory_item_id VARCHAR2(40) NOT NULL,
    iname VARCHAR2(20) NOT NULL,
    quantity INTEGER,
    PRIMARY KEY(inventory_item_id)
);

CREATE TABLE takes (
    staff_id VARCHAR2(40) NOT NULL,
    order_id VARCHAR2(40) NOT NULL,
    PRIMARY KEY(staff_id, order_id),
    CONSTRAINT FK_stafftakes FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT FK_ordertakes FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE depends (
    menu_item_id VARCHAR2(40) NOT NULL,
    order_id VARCHAR2(40) NOT NULL,
    PRIMARY KEY(menu_item_id, order_id),
    CONSTRAINT FK_menuitemdepends FOREIGN KEY (menu_item_id) REFERENCES menu_item(menu_item_id),
    CONSTRAINT FK_ordersdepends FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE manages (
    inventory_item_id VARCHAR2(40) NOT NULL,
    staff_id VARCHAR2(40) NOT NULL,
    PRIMARY KEY(inventory_item_id, staff_id),
    CONSTRAINT FK_inventorymanages FOREIGN KEY (inventory_item_id) REFERENCES inventory(inventory_item_id),
    CONSTRAINT FK_staffmanages FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);




