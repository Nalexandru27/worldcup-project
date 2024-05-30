#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE games, teams")

# cat is used to display the content of files, while IFS="," reads the file line by line and uses ',' as a separator
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

#Insert data into TEAMS table

  #Get name of the winning team

  #Skips the first line where are the names of the columns
  if [[ $WINNER != "winner" ]]
    then

      #Search for the current team name $WINNER into our table
      team_name=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")

      #If it was not found (string is empty '-z') we insert the new team into the table
      if [[ -z $team_name ]]
        then
          insert_team_name = $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")

          #Check if the row was inserted 
          if [[ $insert_team_name == "INSERT 0 1" ]]
            then  
              echo $WINNER team was succesfully inserted!
          fi
      fi
  fi


  #Get name of the opponent team

  #Skips the first line of the csv
    if [[ $OPPONENT != "opponent" ]]
      then

        #Search for this team in our table to see if it exists
        team2_name=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")

        #Check if it was found
        if [[ -z $team2_name ]]
          then

            #Insert the team
            insert_team2_name=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")

            #Check if the row was inserted
            if [[ $insert_team2_name == "INSERT 0 1" ]]
              then
                echo $OPPONENT team was succesfully inserted! 
            fi
        fi
    fi


# INSERT DATA INTO GAMES TABLE

    # We don't want the column names row so exclude it
    if [[ YEAR != "year" ]]
      then
        # Get the winner's team ID
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        # Get the opponent's team ID
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        # Insert a new row into the games table
        INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
          # Echo call to let us know what was added
          if [[ $INSERT_GAME == "INSERT 0 1" ]]
            then
              echo New game added: $YEAR, $ROUND, $WINNER_ID VS $OPPONENT_ID, score $WINNER_GOALS : $OPPONENT_GOALS
          fi

    fi
    
done




  




      
