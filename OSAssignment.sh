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

  printf "\n%-15s %-20s %-15s %-25s %-11s\n" "Room Number " "Room Type " "Capacity " "Remarks " "Status"

  for venue in $venues; do
    # Split the venue information into its parts
    blockName=$(echo $venue | cut -d ":" -f 1)
    if [ $blockName == $input ]; then
      roomNumber=$(echo $venue | cut -d ":" -f 2)
      roomType=$(echo $venue | cut -d ":" -f 3)
      capacity=$(echo $venue | cut -d ":" -f 4)
      remarks=$(echo $venue | cut -d ":" -f 5)

      printf "%-15s %-20s %-15s %-30s %-11s\n" $roomNumber $roomType $capacity $remarks 
    fi  
  done

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

  # if [ $option == "n" ]; then
  # BookVenueScreen
}

function PatronDetailValidation()
{ 
  echo -e "\t\t\tPatron Detail Validation"
  echo -e "\t\t\t========================"

  echo -e "Pleaser enter the Patron's ID Number"
  read id
  
  filename="Patron.txt"
  patrons=$(cat $filename)

  for patron in $patrons; do
      # Split the patrons information into its parts
    patronID=$(echo $patron | cut -d ":" -f 1)
    if [ $patronID == $id ]; then
      patronName="$(echo $patron | cut -d ":" -f 2)"
      # phoneNumebr=$(echo $patrons | cut -d ":" -f 3)
      # email=$(echo $patrons | cut -d ":" -f 4)
      echo -e "\nPatron Name (auto display): $patronName"
      break 
    fi   
  done
}

function BookVenueScreen()
{
    echo -e "\t\t\tBooking Venue"
    echo -e "\t\t\t============="
    echo -e "\nPlease enter the Room Number : B001A: "
    read roomNum

    filename="venue.txt"
    for venue in $venues; do
      # Split the venue information into its parts
      blockName=$(echo $venue | cut -d ":" -f 1)
      if [ $blockName == $input ]; then
        roomNumber=$(echo $venue | cut -d ":" -f 2)
        roomType=$(echo $venue | cut -d ":" -f 3)
        capacity=$(echo $venue | cut -d ":" -f 4)
        remarks=$(echo $venue | cut -d ":" -f 5)

        printf "%-15s %-20s %-15s %-30s %-11s\n" $roomNumber $roomType $capacity $remarks 
      fi  
    done
}

SearchPatron