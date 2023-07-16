#!/bin/bash
function Main()
{
    echo -e "${BOLD}University Venue Management Menu\n"

    echo "A - Register New"
    echo "B - Search Patron Details"
    echo "C - Add New Venue"
    echo "D - List Vebue"
    echo -e "E - Book Venue\n"

    echo -e "Q = Exit from Program\n"

    echo "Please select a choice: "
    read choice

    if [ $choice == "A" ]; then
        echo "A"
    elif [ $choice == "B" ]; then
        echo "B"
    elif [ $choice == "C" ]; then
        AddNewVenue
    elif [ $choice == "D" ]; then
        echo "D"
    elif [ $choice == "E" ]; then
        echo "E"
    fi
}

function AddNewVenue() {

  echo -e "\t\t\t${BOLD}Add New Venue"
  echo -e "\t\t================"

  # Get user input
  read -p "Block Name: " blockName
  read -p "Room Number: " roomNumber
  read -p "Room Type: " roomType
  read -p "Capacity: " capacity
  read -p "Remarks: " remarks

  # Set the default status to Available
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

  # Ask the user if they want to add another venue
  echo "\nAdd Another New Venue? (y)es or (q)uit :"
  read option

  # If the user enters y, then loop back to the beginning
  if [ $option == "y" ]; then
    AddNewVenue
  
  elif [ $option == "q" ]; then
    echo "\nPress (q) to return to ${BOLD}University Venue Management Menu."
  fi
}

Main
