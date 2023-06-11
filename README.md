# Salon-Appointment-Scheduler

This project is one of the required projects within the relational database course at freecodecamp. The main task is to create a bash program for salon's customers to view the services and book thier appointments. :


## **1. Building a database for the salon's services, apponintments, and customers using PostgreSQL.**

**Files:** _salon.sql_

In this task, the database was built using PostgreSQL. It has three tables:

1. **SERVICES** table: This table holds the salon's services with their ids.

2. **CUSTOMERS** table: This table holds the salon's registered customer with their info including name and phone nnumber.

3. **APPOINTMENTS** table: This table holds the appointments booked by the customer, and it has two foreign keys that reference the ids of the previously mentioned tables.


## **2. Preparing a bash program that acts as a salon appointment scheduler.**

**Files:** _salon.sh_

In this task, a bash script was prepared to help new customer and registered ones to view the services offered by the salon and book their appointments accordingly. 
- The services list presented to the customers at the begining of the program are fetched from the above mentioned database.
- The program will detect if a customer is registered or not using the phone number that is inputted and check in the databse if he is registered or not. If he is not registered, the program will register him into the database with the help of INSERT INTO query.
- Output messages are taken into consideration for better user experience.


