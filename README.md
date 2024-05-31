WorldCup Project

I created a database base worldcup with two tables: teams and games.
Teams has: team_id and name (primary key)
Games has: game_id, year, round, winner_id(foreign key), opponent_id(foreign key), winner_goals,opponent_goals

The insert_data.sh adds the team names into the teams table. We read the data from a csv file using cat and a while loop with a separator. First we skip the first line of the file.
Then we ckeck if the team is already in the table and if not we insert it using a sql command. We do this procedure for the winner and for the opponnet to be sure we added all the teams.
After we finish with the teams table we go to the games table to insert data into it. We get the winner_id and opponent_id to use it for the current row and add the whole line from the csv file

In the queries.sh I have multiple queries where I make joins between tables to get the name of the teams into lists
