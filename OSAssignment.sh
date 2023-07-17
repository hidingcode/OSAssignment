#!/bin/bash

function Main()
{
    echo -e "${BOLD}University Venue Management Menu\n"

    echo "A - Register New"
    echo "B - Search Patron Details"
    echo "C - Add New Venue"
    echo "D - List Venue"
    echo -e "E - Book Venue\n"

    echo -e "Q = Exit from Program\n"

    echo "Please select a choice: "
    read choice

    if [ $choice == "A" ]; then
        Registration
    elif [ $choice == "B" ]; then
        SearchPatron
    elif [ $choice == "C" ]; then
        AddNewVenue
    elif [ $choice == "D" ]; then
        ListVenue
    elif [ $choice == "E" ]; then
        BookVenue
    fi
}

function Registration()
{
  echo -e "\t\t\t${BOLD}Patron Registration"
  echo -e "\t\t\t========================"

  read -p "Patron ID (As per TARUMT format):" id 
  read -p "Patron Full Name (As per NRIC) :" name
  read -p "Contact Number:" cNumber
  read -p "Email Address (As per TAR UMT format):" email

  filename="Patron.txt"
  echo "$id:$name:$cNumber:$email" >> $filename

  echo -e "\nRegister Another Patron? (y) es or (q) uit :"
  read option

  if [ $option == "y" ]; then
    Registration
  
  elif [ $option == "q" ]; then
    echo -e "\nPress (q) to return to ${BOLD}University Venue Management Menu."
  fi
}

function SearchPatron()
{
  echo "Search Patron Details"
  echo -e "\n\nEnter Patron ID: " 
  read input

  filename="Patron.txt"
  patrons=$(cat $filename)

  for patron in $patrons; do
    id=$(echo $patron | cut -d ":" -f 1)
    if [ $id == $input ]; then
      name=$(echo $patron | cut -d ":" -f 2)
      cNumber=$(echo $patron | cut -d ":" -f 3)
      email=$(echo $patron | cut -d ":" -f 4)
    
      echo "Full Name (auto display): $name"
      echo "Contact Number (auto display): $cNum"
      echo "Email Address (auto display): $email"
      break
    fi  
  done

  echo -e "\nSearch Another Patron? (y) es or (q) uit :"
  read option

  if [ $option == "y" ]; then
    Registration
  
  elif [ $option == "q" ]; then
    echo -e "\nPress (q) to return to ${BOLD}University Venue Management Menu."
  fi
}

function AddNewVenue() 
{
  echo -e "\t\t\t${BOLD}Add New Venue"
  echo -e "\t\t================"

  # Get user input
  read -p "Block Name: " blockName
  read -p "Room Number: " roomNumber
  read -p "Room Type: " roomType
  read -p "Capacity: " capacity
  read -p "Remarks: " remarks

  status="Available"

  filename="venue.txt"
  echo "$blockName:$roomNumber:$roomType:$capacity:$remarks" >> $filename

  # Print out result
  echo "Block Name: $blockName"
  echo "Room Number: $roomNumber"
  echo "Room Type: $roomType"
  echo "Capacity: $capacity"
  echo "Remarks: $remarks"
  echo "Status: $status"

  echo "\nAdd Another New Venue? (y)es or (q)uit :"
  read option

  # If the user enters y, then loop back to the beginning
  if [ $option == "y" ]; then
    AddNewVenue
  
  elif [ $option == "q" ]; then
    echo "\nPress (q) to return to ${BOLD}University Venue Management Menu."
  fi
}

function ListVenue()
{
  echo -e "List Venue Details\n"
  echo "Enter Block Name: "
  read input

  filename="venue.txt"
  venues=$(cat $filename)

  echo -e ""Room Number"\t "Room Type"\t "Capacity"\t "Remarks"\t\t\t "Status""

  while IFS='' read -r line; do
    blockName="$(echo $line | cut -d ":" -f 1)"
    if [ $blockName == $input ]; then
        roomNumber="$(echo $line | cut -d ":" -f 2)"
        roomType=$(echo $line | cut -d ":" -f 3)
        capacity=$(echo $line | cut -d ":" -f 4)
        remarks=$(echo $line | cut -d ":" -f 5)
        echo -e "$roomNumber \t\t $roomType \t\t $capacity \t\t $remarks\t\t\t"
    fi
  done < "$filename"

  echo -e "Search Another Block Venue? (y)es or (q)uit:"
  read option

  if [ $option == "y" ]; then
    ListVenue

  elif [ $option == "q" ]; then
    Menu
  fi
}

function BookVenue()
{
  PatronDetailValidation
  
  echo -e "\nPress (n) to proceed Book Venue or (q) to return to ${BOLD}University Venue Management Menu:"
  read option

  if [ $option == "n" ]; then
    BookVenueScreen
  fi
}

function PatronDetailValidation()
{ 
  echo -e "\t\t\tPatron Detail Validation"
  echo -e "\t\t\t========================"

  echo -e "Please enter the Patron's ID Number"
  read id
  
  filename="Patron.txt"
  patrons=$(cat $filename)

  while IFS='' read -r line; do
    patronID="$(echo $line | cut -d ":" -f 1)"
    if [ $patronID == $id ]; then
        patronName="$(echo $line | cut -d ":" -f 2)"
        phoneNumber=$(echo $line | cut -d ":" -f 3)
        email=$(echo $line | cut -d ":" -f 4)
        echo -e "\nPatron Name (auto display): $patronName"
        echo -e "\nPhone Number (auto display): $phoneNumber"
        echo -e "\nEmail(auto display): $email"
    fi
  done < "$filename"
 
  
}

function BookVenueScreen()
{
    echo -e "\t\t\tBooking Venue"
    echo -e "\t\t\t============="
    echo -e "\nPlease enter the Room Number : B001A: "
    read roomNum

    filename="venue.txt"

    while IFS='' read -r line; do
      roomNums="$(echo $line | cut -d ":" -f 2)"
      if [ $roomNums == $roomNum ]; then
          roomType=$(echo $line | cut -d ":" -f 3)
          capacity=$(echo $line | cut -d ":" -f 4)
          remarks=$(echo $line | cut -d ":" -f 5)
          echo -e "Room Type (auto display): $roomType"
          echo -e "Capacity (auto display): $capacity"
          echo -e "Remarks (auto display): $remarks"
          echo -e "Status:"
      fi
    done < "$filename"

    echo -e "Notes: The booking hours shall be from 8am to 8pm only. The booking duration shall be at least 30 minutes per booking."
    echo -e "\nPlease ${bold}enter${normal} the following details:\n"

    echo -e "Booking Date (mm/dd/yyyy):"
    read bookingDate
    echo -e "Time From (hh:mm): "
    read timeFrom
    echo -e "Time To (hh:mm): "
    read timeTo
    echo -e "Reasons for Booking: "
    read reasonBooking

    echo -e "Press ${bold}(s)${normal} to save and generate the venue booking details or Press ${bold}(c)${normal} to cancel the Venue Booking and return to University Venue Management Menu: "
    read option

    if [ $option == "s" ]; then
      AddNewBooking
    elif [ $option == "c" ]; then
      Main
    fi
}

function AddNewBooking(){
  filename="booking.txt"
  checkEmpty=$(wc -l $filename)
  num_lines="$(echo $checkEmpty | cut -d " " -f 1)"
  if [ $num_lines -eq 0 ]; then
    echo "PatronID:PatronName:RoomNumber:DateBooking:TimeFrom:TimeTo:ReasonsForBooking" >> $filename
    echo $patronID":"$patronName":"$roomNum":"$bookingDate":"$timeFrom":"$timeTo":"$reasonBooking >> $filename
  else
    echo $id":"$patronName":"$roomNum":"$bookingDate":"$timeFrom":"$timeTo":"$reasonBooking >> $filename
  fi
  # echo "booking added" >> $filename

  DisplayReceipt
}

function DisplayReceipt(){
  echo -e "\t\t\t${bold}Venue Booking Receipt"
  echo -e "\n Patron ID:"$id"\t\t\t         Patron Name: "$patronName
  echo -e "\n Room Number:"$roomNum
  echo -e "\n Date Booking:"$bookingDate
  echo -e "\n Time From:"$timeFrom"\t\t\t\t Time To: "$timeTo
  echo -e "\n Reason for Booking:"$reasonBooking
  echo -e "\n\n\t    This is a computer generated receipt with no signature required."

  current_time=$(date +"%H:%M:%S%p")
  current_date=$(date +"%m-%d-%Y")

  echo -e "\n\n\t\t\t${bold}Printed on "$current_date" "$current_time"."

}


Main