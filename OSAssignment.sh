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
    elif [ $choice == "Q" ]; then
      exit 1
    else
      clear
      echo -e "\nInvalid Input. Please try again\n"
      Main
    fi
}

function Registration()
{ 
  echo -e "\t\t\t${BOLD}Patron Registration"
  echo -e "\t\t\t========================"
  while [[ ${#id} -lt 3 || ! "$id" =~ ^[0-9]+$ ]]; do
    read -p "Patron ID (As per TARUMT format):" id 
    if [[ ${#id} -lt 3 || ! "$id" =~ ^[0-9]+$ ]]; then
      echo "Please enter at least 3 numeric characters."
    else
      while [[ -z "$name" || "$name" =~ [^a-zA-Z[:space:]] ]]; do
          read -r -p "Patron Full Name (As per NRIC) :" name
          if [[ -z "$name" || "$name" =~ [^a-zA-Z[:space:]] ]]; then
            echo "Please enter valid name."
          else
            while [[ ${#cNumber} -lt 11 || ! "$cNumber" =~ ^[0-9-]+$ ]]; do
                read -p "Contact Number:" cNumber
                if [[ ${#cNumber} -lt 11 || ! "$cNumber" =~ ^[0-9-]+$ ]]; then
                  echo "Please enter valid phone number included '-', e.g 012-3456789"
                else
                  while [[ ${#email} -lt 8 || ! "$email" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$ ]]; do
                      read -p "Email Address (As per TAR UMT format):" email
                      if [[ ${#email} -lt 8 || ! "$email" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$ ]]; then
                        echo "Please enter valid email address."
                      else
                        filename="Patron.txt"
                        echo "$id:$name:$cNumber:$email" >> $filename
                        ContinueRegistration
                      fi
                    done
                fi

              done
          fi

        done
    fi
  done

  
}

function ContinueRegistration()
{
  echo -e "\nRegister Another Patron? (y) es or (q) uit :"
  echo -e "\nPress (q) to return to ${BOLD}University Venue Management Menu."
  
  read option

  if [ $option == "y" ]; then
    clear
    Registration
  
  elif [ $option == "q" ]; then
    clear
    Main
  else
    clear
    echo -e "\nInvalid Input. Please try again\n"
    ContinueRegistration
  fi
}

function SearchPatron()
{ 
  valid=false
  echo "Search Patron Details"
  echo -e "\n\nEnter Patron ID: " 
  read input

  filename="Patron.txt"
  patrons=$(cat $filename)

  while IFS='' read -r line; do
    id="$(echo $line | cut -d ":" -f 1)"
    if [ $id == $input ]; then
        valid=true
        name="$(echo $line | cut -d ":" -f 2)"
        cNumber=$(echo $line | cut -d ":" -f 3)
        email=$(echo $line | cut -d ":" -f 4)
    fi
  done < "$filename"

  # for patron in $patrons; do
  #   id=$(echo $patron | cut -d ":" -f 1)
  #   if [ $id == $input ]; then
  #     valid=true
  #     name=$(echo $patron | cut -d ":" -f 2)
  #     cNumber=$(echo $patron | cut -d ":" -f 3)
  #     email=$(echo $patron | cut -d ":" -f 4)
  #     break
  #   fi  
  # done

  if [ $valid == true ]; then
    echo "Full Name (auto display): $name"
    echo "Contact Number (auto display): $cNumber"
    echo "Email Address (auto display): $email"
  else
    echo -e "\nPatron ID not found. Please try again\n"
    SearchPatron
  fi

  ContinueSearchPatron

}

function ContinueSearchPatron()
{
    echo -e "\nSearch Another Patron? (y) es or (q) uit :"
    echo -e "\nPress (q) to return to ${BOLD}University Venue Management Menu."
  read option

  if [ $option == "y" ]; then
    clear
    SearchPatron
  
  elif [ $option == "q" ]; then
    clear
    Main
  else
    clear
    echo -e "\nInvalid Input. Please try again\n"
    ContinueSearchPatron
  fi
}

function AddNewVenue() 
{ 
  echo -e "\t\t\t${BOLD}Add New Venue"
  echo -e "\t\t================"

  # Get user input
  while [[ -z "$blockName" || ! "$blockName" =~ ^[a-zA-Z]+$ ]]; do
    read -p "Block Name: " blockName
    if [[ ! "$blockName" =~ ^[a-zA-Z]+$ ]]; then
      echo "Please enter a valid block"
    else
      while [[ -z "$roomNumber" || ! "$roomNumber" =~ ^[a-zA-Z0-9]+$ ]]; do
        read -p "Room Number: " roomNumber
        if [[ -z "$roomNumber" || ! "$roomNumber" =~ ^[a-zA-Z0-9]+$ ]]; then
          echo "Please enter a valid room number"
        else
          while [[ -z "$roomType" || ! "$roomType" =~ ^[a-zA-Z]+$ ]]; do
            read -p "Room Type: " roomType
            if [[ -z "$roomType" || ! "$roomType" =~ ^[a-zA-Z]+$ ]]; then
              echo "Please enter a valid room type"
            else
              while [[ -z "$capacity" || ! "$capacity" =~ ^[0-9]+$ ]]; do
                read -p "Capacity: " capacity
                if [[ -z "$capacity" || ! "$capacity" =~ ^[0-9]+$ ]]; then
                  echo "Please enter the capacity"
                else
                  while [[ -z "$remarks" || ! "$remarks" =~ [^0-9[:space:]] ]]; do
                    read -p "Remarks: " remarks
                    if [[ -z "$remarks" || ! "$remarks" =~ [^0-9[:space:]] ]]; then
                      echo "Please enter proper remarks"
                    else
                      status="Available"

                      filename="venue.txt"
                      echo "$blockName:$roomNumber:$roomType:$capacity:$remarks" >> $filename

                      echo "\nNew venue added"
                      echo "\n\nBlock Name: $blockName"
                      echo "Room Number: $roomNumber"
                      echo "Room Type: $roomType"
                      echo "Capacity: $capacity"
                      echo "Remarks: $remarks"
                      echo "Status: $status"

                      ContinueAddNewVenue
                    fi
                  done
                fi
              done
            fi
          done
        fi
      done
    fi
  done
  
}

function ContinueAddNewVenue()
{
  echo "Add Another New Venue? (y)es or (q)uit :"
  echo "Press (q) to return to ${BOLD}University Venue Management Menu."
  read option

  # If the user enters y, then loop back to the beginning
  if [ $option == "y" ]; then
    clear
    AddNewVenue
  
  elif [ $option == "q" ]; then
    clear
    Main

  else
    clear
    echo -e "\nInvalid Input. Please try again\n"
    ContinueAddNewVenue
  fi
}

function ListVenue()
{ 
  valid=false
  echo -e "List Venue Details\n"
  echo "Enter Block Name: "
  read input

  filename="venue.txt"
  venues=$(cat $filename)

  while IFS='' read -r line; do
    blockName="$(echo $line | cut -d ":" -f 1)"
    if [ $blockName == $input ]; then
        valid=true
        echo -e ""Room Number"\t "Room Type"\t "Capacity"\t "Remarks"\t\t\t "Status""
        roomNumber="$(echo $line | cut -d ":" -f 2)"
        roomType=$(echo $line | cut -d ":" -f 3)
        capacity=$(echo $line | cut -d ":" -f 4)
        remarks=$(echo $line | cut -d ":" -f 5)
        echo -e "$roomNumber \t\t $roomType \t\t $capacity \t\t $remarks\t\t\t $status"
    fi
  done < "$filename"

  if [ $valid == false ]; then
    clear
    echo -e "\nBlock Name not found. Please try again\n"
    ListVenue
  fi

  ContinueListVenue

}

function ContinueListVenue()
{
  echo -e "Search Another Block Venue? (y)es or (q)uit:"
  read option

  if [ $option == "y" ]; then
    clear
    ListVenue

  elif [ $option == "q" ]; then
    clear
    Menu
  
  else
    clear
    echo "\nBlock Name not found. Please try again\n"
    ContinueListVenue
  fi
}

function BookVenue()
{ 
  PatronDetailValidation
  # ContinueBookVenue
}

function ContinueBookVenue()
{
  echo -e "\nPress (n) to proceed Book Venue or (q) to return to ${BOLD}University Venue Management Menu:"
  read option

  if [ $option == "n" ]; then
    clear
    BookVenueScreen
  elif [$option == "q"]; then
    clear
    Main
  else
    clear
    echo -e "\nInvalid Input. Please try again\n"
    ContinueBookVenue
  fi
}

function PatronDetailValidation()
{ 
  valid=false
  id=""
  echo -e "\t\t\tPatron Detail Validation"
  echo -e "\t\t\t========================"
  echo -e "Please enter the Patron's ID Number" 
  while [[ ${#id} -lt 3 || ! "$id" =~ ^[0-9]+$ ]]; do
    read id
    if [[ ${#id} -lt 3 || ! "$id" =~ ^[0-9]+$ ]]; then
      echo -e "Please enter valid Patron's ID Number"
    else
      filename="Patron.txt"
      patrons=$(cat $filename)

      while IFS='' read -r line; do
        patronID="$(echo $line | cut -d ":" -f 1)"
        if [ $patronID == $id ]; then
            valid=true
            patronName="$(echo $line | cut -d ":" -f 2)"
            phoneNumber=$(echo $line | cut -d ":" -f 3)
            email=$(echo $line | cut -d ":" -f 4)
        fi
      done < "$filename"

      if [ $valid == true ]; then
        echo -e "\nPatron Name (auto display): $patronName"
        echo -e "\nPhone Number (auto display): $phoneNumber"
        echo -e "\nEmail(auto display): $email"
        ContinueBookVenue
      else
        clear
        echo -e "\nPatron ID not found. Please try again\n"
        id=""
        BookVenue
      fi
    fi
  done
  
}

function BookVenueScreen()
{ 
    valid=false

    echo -e "\t\t\tBooking Venue"
    echo -e "\t\t\t============="

    ##############################
    echo -e "\nPlease enter the patron capacity: "
    while [[ -z "$patronCapacity" || ! "$patronCapacity" =~ ^[0-9]+$ ]]; do
      read patronCapacity
      if [[ -z "$patronCapacity" || ! "$patronCapacity" =~ ^[0-9]+$ ]]; then
        echo "Please enter valid capacity"
      fi
    done
    ################################

    exceedCapacity=true
    while [ "$exceedCapacity" = true ]; do
      echo -e "\nPlease enter the Room Number : B001A: "
      filename="venue.txt"

      roomNum=""
      exceedCapacity=false
      while [[ ${#roomNum} -lt 4 || ! "$roomNum" =~ ^[a-zA-Z0-9]+$ ]]; do
        read roomNum
        if [[ ${#roomNum} -lt 4 || ! "$roomNum" =~ ^[a-zA-Z0-9]+$ ]]; then
          echo -e "Please enter a valid room number."
        else
          while IFS='' read -r line; do
            roomCapacity="$(echo $line | cut -d ":" -f 4)"
            # find the input roomnum in the file
            # then only compare the specific room capacity
            findRoomnum="$(echo $line | cut -d ":" -f 2)"
            if [ $roomNum == $findRoomnum ]; then
                if [ $patronCapacity -gt $roomCapacity ]; then
                  # alert user
                  exceedCapacity=true;
                  echo -e $roomNum "is not available for" $patronCapacity "people"
                  echo -e $roomNum "max capacity is" $roomCapacity
                  echo -e "Please enter enough capacity room number"
                else
                  echo "TRUE TRUE TRUE"
                  exceedCapacity=false
                fi
            fi

          done < "$filename"
        fi
      done
    done
    if [ "$exceedCapacity" = false ]; then
      filename="venue.txt"
      while IFS='' read -r line; do
        roomNums="$(echo $line | cut -d ":" -f 2)"
        if [ $roomNums == $roomNum ]; then
          valid=true  
          roomType=$(echo $line | cut -d ":" -f 3)
          capacity=$(echo $line | cut -d ":" -f 4)
          remarks=$(echo $line | cut -d ":" -f 5)
        fi
      done < "$filename"
    fi
    

    if [ $valid == true ]; then
      echo -e "\nRoom Type (auto display): $roomType"
      echo -e "Capacity (auto display): $capacity"
      echo -e "Remarks (auto display): $remarks" 
      echo -e "Status:"
    else
      clear
      echo -e "\nInvalid Room Number. Please try again\n"
      BookVenueScreen
    fi

    BookingForDateTime
    if [[ durationValid==true ]]; then
      echo -e "Reasons for Booking: "

      while [[ -z "$reasonBooking" || ! "$reasonBooking" =~ ^[a-zA-Z[:space:]]*$ ]]; do
        read reasonBooking
        if [[ -z "$reasonBooking" || ! "$reasonBooking" =~ ^[a-zA-Z[:space:]]*$ ]]; then
          echo "Please enter proper reason for booking"
        else
          ConfirmBooking
        fi
      done
    fi
}

function BookingForDateTime(){
  echo -e "\nNotes: The booking hours shall be from 8am to 8pm only. The booking duration shall be at least 30 minutes per booking."
  echo -e "\nPlease ${bold}enter${normal} the following details:\n"

  echo -e "Booking Date (mm/dd/yyyy):"
  bookingDate=""
  while [[ -z "$bookingDate" || ! "$bookingDate" =~ ^[0-9]{2}/[0-9]{2}/[0-9]{4}$ ]]; do
    read bookingDate

    if [[ -z "$bookingDate" || ! "$bookingDate" =~ ^[0-9]{2}/[0-9]{2}/[0-9]{4}$ ]]; then
      clear
      echo "Please enter a valid booking date."
      BookingForDateTime
    else
      month=${bookingDate:0:2}
      day=${bookingDate:3:2}
      year=${bookingDate:6:4}

      if [[ $month > 12 || $day > 31 || $month < 01 || $day < 01 || $year < 2000 ]]; then
        clear
        echo "Please enter a valid date"
        BookingForDateTime
      else
        if [[ $month == 04 || $month = 06 || $month == 09 || $month == 11 && $day > 30 ]]; then
          clear
          echo "Month of "$month" do not have "$day" days."
          BookingForDateTime
        elif [[ $month == 02 && $day > 28 ]]; then
          clear
          echo "Month of "$month" do not have "$day" days."
          BookingForDateTime
        else
          timeFrom=""
          echo -e "Time From (hh:mm): "
          while [[ -z "$timeFrom" || ! "$timeFrom" =~ ^[0-9]{2}:[0-9]{2}$ ]]; do
            read timeFrom
            if [[ -z "$timeFrom" || ! "$timeFrom" =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
              echo "Please enter valid time"
            else
              Fromtime_hour=${timeFrom:0:2}
              Fromtime_min=${timeFrom:3:2}
              if [[ $Fromtime_hour > 23 || $Fromtime_min > 59 ]]; then
                clear
                echo "Please enter valid time"
                BookingForDateTime
              else
                if [[ (08 > $Fromtime_hour) ]]; then
                  clear
                  echo $Fromtime_hour
                  echo "The booking hours shall be from 8am to 8pm only"
                  BookingForDateTime
                elif [[ ($Fromtime_hour > 20) ]]; then
                  clear
                  echo "The booking hours shall be from 8am to 8pm only"
                  BookingForDateTime
                else
                  durationValid=false
                  while [[ $durationValid == false ]]; do
                    durationValid=true
                    timeTo=""
                    echo -e "Time To (hh:mm): "
                    while [[ -z "$timeTo" || ! "$timeTo" =~ ^[0-9]{2}:[0-9]{2}$ ]]; do
                      read timeTo
                      if [[ -z "$timeTo" || ! "$timeTo" =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
                        echo "Please enter valid time"
                      else
                        Totime_hour=${timeTo:0:2}
                        Totime_min=${timeTo:3:2}

                        if [[ $Totime_hour > 23 || $Totime_min > 59 ]]; then
                          clear
                          echo "Please enter valid time"
                          durationValid=false
                        else
                          if [ ${Fromtime_hour:0:1}==0 ]; then
                            Fromtime_hour=${Fromtime_hour:1:1}
                          fi
                          if [ ${Totime_hour:0:1}==0 ]; then
                            Totime_hour=${Totime_hour:1:1}
                          fi
                          if [[ $((Totime_hour - Fromtime_hour)) == 0 ]]; then
                            if [[ $((Totime_min - Fromtime_min)) < 30 ]]; then
                              echo "You must book at least 30 minutes"
                              durationValid=false
                            else
                              durationValid=true
                            fi
                          else
                            durationValid=true
                          fi

                        fi

                      fi
                      break
                    done
                    
                  done
                  
                fi
              fi

            fi
          done
        fi
      fi  
    fi

  done
}

function ConfirmBooking()
{
  echo -e "Press ${bold}(s)${normal} to save and generate the venue booking details or Press ${bold}(c)${normal} to cancel the Venue Booking and return to University Venue Management Menu: "
  read option

  if [ $option == "s" ]; then
    AddNewBooking
  elif [ $option == "c" ]; then
    Main
  else
    ConfirmBooking
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

function testing(){
  roomCapacity=5
  patronCapacity=6
  echo -e "Enter patron capacity:"
  while [ $patronCapacity -gt $roomCapacity ]; do
    read patronCapacity
    if [ $patronCapacity -gt $roomCapacity ]; then
      echo -e "This room is not enough fit"
      echo -e "Please try again: "
    else
      echo -e "Success"
    fi
  done
  
}

# testing