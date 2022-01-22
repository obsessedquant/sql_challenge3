-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/C89fUB
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE `actor` (
    `actor_id` int  NOT NULL ,
    `first_name` VARCHAR(45)  NOT NULL ,
    `last_name` VARCHAR(45)  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    PRIMARY KEY (
        `actor_id`
    )
);

CREATE TABLE `category` (
    `category_id` int  NOT NULL ,
    `name` VARCHAR(40)  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    PRIMARY KEY (
        `category_id`
    )
);

CREATE TABLE `address` (
    `address_id` int  NOT NULL ,
    `address` VARCHAR(50)  NOT NULL ,
    `address2` VARCHAR(50)  NOT NULL ,
    `district` VARCHAR(20)  NOT NULL ,
    `city_id` smallint  NOT NULL ,
    `postal_code` VARCHAR(10)  NOT NULL ,
    `phone` VARCHAR(20)  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    PRIMARY KEY (
        `address_id`
    )
);

CREATE TABLE `city` (
    `city_id` int  NOT NULL ,
    `city` VARCHAR(50)  NOT NULL ,
    `country_id` smallint  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    PRIMARY KEY (
        `city_id`
    )
);

CREATE TABLE `country` (
    `country_id` int  NOT NULL ,
    `country` VARCHAR(50)  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    PRIMARY KEY (
        `country_id`
    )
);

CREATE TABLE `customer` (
    `customer_id` int  NOT NULL ,
    `store_id` smallint  NOT NULL ,
    `first_name` VARCHAR(45)  NOT NULL ,
    `last_name` VARCHAR(45)  NOT NULL ,
    `email` VARCHAR(50)  NOT NULL ,
    `address_id` smallint  NOT NULL ,
    `activebool` boolean  NOT NULL ,
    `create_date` date  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    `active` int  NOT NULL ,
    PRIMARY KEY (
        `customer_id`
    )
);

CREATE TABLE `customer_list` (
    `id` int  NOT NULL ,
    `name` VARCHAR(50)  NOT NULL ,
    `address` VARCHAR(50)  NOT NULL ,
    `zip_code` VARCHAR(10)  NOT NULL ,
    `phone` VARCHAR(20)  NOT NULL ,
    `city` VARCHAR(50)  NOT NULL ,
    `country` VARCHAR(50)  NOT NULL ,
    `notes` VARCHAR(50)  NOT NULL ,
    `sid` int  NOT NULL 
);

CREATE TABLE `film` (
    `film_id` int  NOT NULL ,
    `title` VARCHAR(255)  NOT NULL ,
    `description` text  NOT NULL ,
    `release_year` int  NOT NULL ,
    `language_id` smallint  NOT NULL ,
    `original_language_id` smallint  NOT NULL ,
    `rental_duration` smallint  NOT NULL ,
    `rental_rate` numeric(4,2)  NOT NULL ,
    `length` smallint  NOT NULL ,
    `replacement_cost` numeric(5,2)  NOT NULL ,
    `rating` text  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    `special_features` text  NOT NULL ,
    `fulltext` tsvector  NOT NULL ,
    PRIMARY KEY (
        `film_id`
    )
);

CREATE TABLE `inventory` (
    `inventory_id` int  NOT NULL ,
    `film_id` smallint  NOT NULL ,
    `store_id` smallint  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    PRIMARY KEY (
        `inventory_id`
    )
);

CREATE TABLE `store` (
    `store_id` int  NOT NULL ,
    `manager_staff_id` smallint  NOT NULL ,
    `address_id` smallint  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    PRIMARY KEY (
        `store_id`
    )
);

CREATE TABLE `film_actor` (
    `actor_id` smallint  NOT NULL ,
    `film_id` smallint  NOT NULL ,
    `last_update` timestamp  NOT NULL 
);

CREATE TABLE `rental` (
    `rental_id` int  NOT NULL ,
    `rental_date` timestamp  NOT NULL ,
    `inventory_id` int  NOT NULL ,
    `customer_id` smallint  NOT NULL ,
    `return_date` timestamp  NOT NULL ,
    `staff_id` smallint  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    PRIMARY KEY (
        `rental_id`
    )
);

CREATE TABLE `staff` (
    `staff_id` int  NOT NULL ,
    `first_name` varchar(45)  NOT NULL ,
    `last_name` varchar(45)  NOT NULL ,
    `address_id` smallint  NOT NULL ,
    `email` varchar(50)  NOT NULL ,
    `store_id` smallint  NOT NULL ,
    `active` boolean  NOT NULL ,
    `username` varchar(16)  NOT NULL ,
    `password` varchar(40)  NOT NULL ,
    `last_update` timestamp  NOT NULL ,
    `picture` bytea  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    )
);

CREATE TABLE `payment` (
    `payment_id` int  NOT NULL ,
    `customer_id` smallint  NOT NULL ,
    `staff_id` smallint  NOT NULL ,
    `rental_id` int  NOT NULL ,
    `amount` numeric(5,2)  NOT NULL ,
    `payment_date` timestamp  NOT NULL ,
    PRIMARY KEY (
        `payment_id`
    )
);

ALTER TABLE `address` ADD CONSTRAINT `fk_address_city_id` FOREIGN KEY(`city_id`)
REFERENCES `city` (`city_id`);

ALTER TABLE `city` ADD CONSTRAINT `fk_city_country_id` FOREIGN KEY(`country_id`)
REFERENCES `country` (`country_id`);

ALTER TABLE `customer` ADD CONSTRAINT `fk_customer_store_id` FOREIGN KEY(`store_id`)
REFERENCES `store` (`store_id`);

ALTER TABLE `customer` ADD CONSTRAINT `fk_customer_address_id` FOREIGN KEY(`address_id`)
REFERENCES `address` (`address_id`);

ALTER TABLE `customer_list` ADD CONSTRAINT `fk_customer_list_id` FOREIGN KEY(`id`)
REFERENCES `customer` (`customer_id`);

ALTER TABLE `inventory` ADD CONSTRAINT `fk_inventory_film_id` FOREIGN KEY(`film_id`)
REFERENCES `film` (`film_id`);

ALTER TABLE `inventory` ADD CONSTRAINT `fk_inventory_store_id` FOREIGN KEY(`store_id`)
REFERENCES `store` (`store_id`);

ALTER TABLE `store` ADD CONSTRAINT `fk_store_address_id` FOREIGN KEY(`address_id`)
REFERENCES `address` (`address_id`);

ALTER TABLE `film_actor` ADD CONSTRAINT `fk_film_actor_actor_id` FOREIGN KEY(`actor_id`)
REFERENCES `actor` (`actor_id`);

ALTER TABLE `film_actor` ADD CONSTRAINT `fk_film_actor_film_id` FOREIGN KEY(`film_id`)
REFERENCES `film` (`film_id`);

ALTER TABLE `rental` ADD CONSTRAINT `fk_rental_inventory_id` FOREIGN KEY(`inventory_id`)
REFERENCES `inventory` (`inventory_id`);

ALTER TABLE `rental` ADD CONSTRAINT `fk_rental_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `customer` (`customer_id`);

ALTER TABLE `rental` ADD CONSTRAINT `fk_rental_staff_id` FOREIGN KEY(`staff_id`)
REFERENCES `staff` (`staff_id`);

ALTER TABLE `staff` ADD CONSTRAINT `fk_staff_address_id` FOREIGN KEY(`address_id`)
REFERENCES `address` (`address_id`);

ALTER TABLE `staff` ADD CONSTRAINT `fk_staff_store_id` FOREIGN KEY(`store_id`)
REFERENCES `store` (`store_id`);

ALTER TABLE `payment` ADD CONSTRAINT `fk_payment_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `customer` (`customer_id`);

ALTER TABLE `payment` ADD CONSTRAINT `fk_payment_staff_id` FOREIGN KEY(`staff_id`)
REFERENCES `staff` (`staff_id`);

ALTER TABLE `payment` ADD CONSTRAINT `fk_payment_rental_id` FOREIGN KEY(`rental_id`)
REFERENCES `rental` (`rental_id`);

