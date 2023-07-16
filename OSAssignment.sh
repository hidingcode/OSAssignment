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
        echo "A"
    elif [ $choice == "B" ]; then
        echo "B"
    elif [ $choice == "C" ]; then
        AddNewVenue
    elif [ $choice == "D" ]; then
        ListVenue
    elif [ $choice == "E" ]; then
        echo "E"
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
  read option:

  if [ $option == "y" ]; then
    ListVenue

  elif [ $option == "q" ]; then
    Menu
  fi
}

ListVenue