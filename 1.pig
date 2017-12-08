 
REGISTER '/home/acadgild/airline_usecase/piggybank.jar';

Load_Data = LOAD '/home/acadgild/pokeman/Pokemon.csv' USING PigStorage(',') AS(Sno:int,Name:chararray,Type1:chararray,Type2:chararray,Total:int,HP:int,Attack:int,Defense:int,SpAtk:int,SpDef:int,Speed:int);


dump Load_Data;

/*

Question:

Find the list of players that have been selected in the qualifying round (DEFENCE>55).

*/



 selected_list = FILTER Load_Data BY Defense>55;

 dump selected_list;

/*

Ques 2: State the number of players taking part in the competition after getting selected in the qualifying round.
Explanation:
Command

*/

gourp_selcted_list = Group selected_list All;
count_selcted_list = foreach gourp_selcted_list GENERATE COUNT(selected_list);

dump count_selcted_list;


/*

Ques 3: Using random() generate random numbers for each Pokémon on the selected list.
Explanation:
Command

*/

random_include1 = foreach selected_list GENERATE RANDOM(),Name,Type1,Type2,Total,HP,Attack,Defense,SpAtk,SpDef,Speed;

dump random_include1;


/*

Ques 4: Arrange the new list in a descending order according to a column randomly.
Explanation: This will give us consequently a layer arranged to pick the random list which 1st player will choose.
Command

*/

random1_desending = ORDER random_include1 BY $0 DESC;

-- dump random1_desending;

/*

/*
Ques 5: Now on a new relation again associate random numbers for each Pokémon and arrange in descending order according to column random.
Explanation: We will be repeating above two steps again to form the 2nd list.
Command

*/
random_include2 = foreach selected_list GENERATE RANDOM(),Name,Type1,Type2,Total,HP,Attack,Defense,SpAtk,SpDef,Speed;
random2_desending = ORDER random_include2 BY $0 DESC;

-- dump random2_desending;


/*

Ques: From the two different descending lists of random Pokémons, select the top 5 Pokémons for 2 different players.
Explanation:
Commands
*/
limit_data_random1_desending = LIMIT random1_desending 5 ;
limit_data_random2_desending = LIMIT random2_desending 5 ;

-- dump limit_data_random2_desending;

/*

filter_only_name1 = foreach limit_data_random1_desending Generate ($1,HP);

filter_only_name2 = foreach limit_data_random2_desending Generate ($1,HP);

*/

-- STORE limit_data_random1_desending INTO '/home/acadgild/pokeman/player1.txt';

