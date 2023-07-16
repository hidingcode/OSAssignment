#!/bin/bash

function AddVenue() {

  echo -e "\t\t\tAdd New Venue"
  echo -e "\t\t\t================"

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
  echo "Add Another New Venue? (y)es or (q)uit :"
  read option

  # If the user enters y, then loop back to the beginning
  if [ $option == "y" ]; then
    AddVenue
  
  elif [ $option == "q" ]; then
    echo "Press (q) to return to University Venue Management Menu."
  fi
}

AddVenue