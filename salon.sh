#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~ Salon Appointment Scheduler ~~~~\n"
echo -e "Greetings!\n\nHere are our services for today. Which of the following services you would like to get?\n"

# This function will list the available services that are fetched from the database
SHOW_SERVICES_LIST() {
  
  # Fching services from database
  SERVICES_LIST=$($PSQL "SELECT * FROM services ORDER BY service_id;")
  
  # A while to loop over them and format them
  echo "$SERVICES_LIST" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  
  read SERVICE_ID_SELECTED

  # Check validity of user input. If this variable is 1, it means the input is valid while 0 means not valid
  CHECK_SERVICE_ID_SELECTED=$($PSQL "SELECT COUNT(*) FROM services WHERE service_id= $SERVICE_ID_SELECTED;")

  # This if statement will check if the input is a number and if entered id exists
  if [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ && $CHECK_SERVICE_ID_SELECTED -ge 1 ]]
  then

    # A call to the booking function passing the selected id
    BOOK_APPOINTMENT $SERVICE_ID_SELECTED

  else

    # A call to the function to show the list of services again
    echo -e "\nYour input is not valid. Please make sure to enter the number of service shown below.\n"
    SHOW_SERVICES_LIST 
    
  fi
}

  

  

BOOK_APPOINTMENT() {
    
  # ask for phone
  echo -e "\nWhat's you phone number?"
  read CUSTOMER_PHONE

  # get customer name 
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")

  # if customer name doesn't exist (not registered)
  if [[ -z $CUSTOMER_NAME ]]
  then

    # get customer name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME

    # Register this customer with his name and phone number
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers (phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
    echo $INSERT_CUSTOMER_RESULT
   
  fi
      
  # get customer id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # get appointment time from the customer 
  echo -e "\nWhen would you like your appointment to be booked? (Please enter time)"
  read SERVICE_TIME

  # Insert the appointment into database
  INSERT_APPONITMENT_RESULT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $1, '$SERVICE_TIME');")
    
  # If appointment is inserted successfullyy into the database
  if [[ "$INSERT_APPONITMENT_RESULT" = "INSERT 0 1" ]]
  then

    # get service name
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $1;")

    # A message to the user with appointment info
    echo -e "\nI have put you down for a $( echo $SERVICE_NAME  | sed -E 's/^ *| *$//g') at $SERVICE_TIME, $( echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g').\n"
  fi
 
  }

# A call to the function
SHOW_SERVICES_LIST



