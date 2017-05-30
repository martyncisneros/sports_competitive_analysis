########## Pre-Analysis Set Up ############

## Load Packages
library(stattleshipR)  
library(sqldf)
library(dplyr)  

## Set Stattleship API Token
set_token('a9640e5acda75c174077be6390b05769')

########## Get Data from Stattleship API ###################

## Set Query Parameters

NFLseason17 <- list(status='ended', interval_type='week',season_id='nfl-2016-2017') 
NFLseason16 <- list(status='ended', interval_type='week',season_id='nfl-2015-2016') 
NFLPlayoffs17 <- list(status='ended', interval_type='postseason',season_id='nfl-2016-2017') 
NFLPlayoffs16_wc <- list(status='ended', interval_type='wildcard',season_id='nfl-2015-2016') 
NFLPlayoffs16_dp <- list(status='ended', interval_type='divisionalplayoffs',season_id='nfl-2015-2016') 
NFLPlayoffs16_cc <- list(status='ended', interval_type='conferencechampionships',season_id='nfl-2015-2016') 
NFLPlayoffs16_s <- list(status='ended', interval_type='superbowl',season_id='nfl-2015-2016') 

#### Get Team Game Log Data

NFLteamgamelogs1 <- ss_get_result(sport='football', league='NFL', ep='team_game_logs',
                          query=NFLseason17 , version=1, walk=TRUE, verbose=TRUE)
NFLteamgamelogs2 <- ss_get_result(sport='football', league='NFL', ep='team_game_logs',
                          query=NFLseason16 , version=1, walk=TRUE, verbose=TRUE)
NFLteamgamelogs3 <- ss_get_result(sport='football', league='NFL', ep='team_game_logs',
                               query=NFLPlayoffs17 , version=1, walk=TRUE, verbose=TRUE)
NFLteamgamelogs4 <- ss_get_result(sport='football', league='NFL', ep='team_game_logs',
                                 query=NFLPlayoffs16_wc , version=1, walk=TRUE, verbose=TRUE)
NFLteamgamelogs5 <- ss_get_result(sport='football', league='NFL', ep='team_game_logs',
                                 query=NFLPlayoffs16_dp , version=1, walk=TRUE, verbose=TRUE)
NFLteamgamelogs6 <- ss_get_result(sport='football', league='NFL', ep='team_game_logs',
                                 query=NFLPlayoffs16_cc , version=1, walk=TRUE, verbose=TRUE)
NFLteamgamelogs7 <- ss_get_result(sport='football', league='NFL', ep='team_game_logs',
                                 query=NFLPlayoffs16_s , version=1, walk=TRUE, verbose=TRUE)

NFLteamgamelogs1 <- do.call('rbind',lapply(NFLteamgamelogs1, function(x) x$team_game_logs))
NFLteamgamelogs2 <- do.call('rbind',lapply(NFLteamgamelogs2, function(x) x$team_game_logs))
NFLteamgamelogs3 <- do.call('rbind',lapply(NFLteamgamelogs3, function(x) x$team_game_logs))
NFLteamgamelogs4 <- do.call('rbind',lapply(NFLteamgamelogs4, function(x) x$team_game_logs))
NFLteamgamelogs5 <- do.call('rbind',lapply(NFLteamgamelogs5, function(x) x$team_game_logs))
NFLteamgamelogs6 <- do.call('rbind',lapply(NFLteamgamelogs6, function(x) x$team_game_logs))
NFLteamgamelogs7 <- do.call('rbind',lapply(NFLteamgamelogs7, function(x) x$team_game_logs))

NFLteamgamelogs1$Season <- '2016-2017'
NFLteamgamelogs1$Type <- 'RegularSeason'
NFLteamgamelogs2$Season <- '2015-2016'
NFLteamgamelogs2$Type <- 'RegularSeason'
NFLteamgamelogs3$Season <- '2016-2017'
NFLteamgamelogs3$Type <- 'Playoffs'
NFLteamgamelogs4$Season <- '2015-2016'
NFLteamgamelogs4$Type <- 'Playoffs'
NFLteamgamelogs5$Season <- '2015-2016'
NFLteamgamelogs5$Type <- 'Playoffs'
NFLteamgamelogs6$Season <- '2015-2016'
NFLteamgamelogs6$Type <- 'Playoffs'
NFLteamgamelogs7$Season <- '2015-2016'
NFLteamgamelogs7$Type <- 'Playoffs'

NFLTeamGameLogs_Full_Data <- rbind(NFLteamgamelogs1, NFLteamgamelogs2
                                   , NFLteamgamelogs3, NFLteamgamelogs4
                                   , NFLteamgamelogs5, NFLteamgamelogs6
                                   , NFLteamgamelogs7)

# Get Teams Data

NFLteams <- ss_get_result(sport='football', league='NFL', ep='teams', version=1, walk=TRUE, verbose=TRUE)
NFLteams <-do.call('rbind', lapply(NFLteams, function(x) x$teams)) 

# Get Players Data

NFL_Players <- ss_get_result(sport='football', league='NFL', ep='players', walk=TRUE)
NFL_Players <- do.call('rbind',lapply(NFL_Players, function(x) x$players))

# Get Roster Data

NFL_Rosters17 <- ss_get_result(sport='football', query=NFLseason17, league='NFL', ep='rosters', walk=TRUE)
NFL_Rosters17 <- do.call('rbind',lapply(NFL_Rosters17, function(x) x$players))
NFL_Rosters17$Season <- '2016-2017'

##### Get Games Data

NFLgames1 <- ss_get_result(sport='football', league='NFL', ep='games',
                           query=NFLseason17 , version=1, walk=TRUE, verbose=TRUE)
NFLgames2 <- ss_get_result(sport='football', league='NFL', ep='games',
                           query=NFLseason16 , version=1, walk=TRUE, verbose=TRUE)
NFLgames3 <- ss_get_result(sport='football', league='NFL', ep='games',
                           query=NFLPlayoffs17 , version=1, walk=TRUE, verbose=TRUE)
NFLgames4 <- ss_get_result(sport='football', league='NFL', ep='games',
                           query=NFLPlayoffs16_wc , version=1, walk=TRUE, verbose=TRUE)
NFLgames5 <- ss_get_result(sport='football', league='NFL', ep='games',
                           query=NFLPlayoffs16_dp , version=1, walk=TRUE, verbose=TRUE)
NFLgames6 <- ss_get_result(sport='football', league='NFL', ep='games',
                           query=NFLPlayoffs16_cc , version=1, walk=TRUE, verbose=TRUE)
NFLgames7 <- ss_get_result(sport='football', league='NFL', ep='games',
                           query=NFLPlayoffs16_s , version=1, walk=TRUE, verbose=TRUE)

NFLgames1 <- do.call('rbind',lapply(NFLgames1, function(x) x$games))
NFLgames2 <- do.call('rbind',lapply(NFLgames2, function(x) x$games))
NFLgames3 <- do.call('rbind',lapply(NFLgames3, function(x) x$games))
NFLgames4 <- do.call('rbind',lapply(NFLgames4, function(x) x$games))
NFLgames5 <- do.call('rbind',lapply(NFLgames5, function(x) x$games))
NFLgames6 <- do.call('rbind',lapply(NFLgames6, function(x) x$games))
NFLgames7 <- do.call('rbind',lapply(NFLgames7, function(x) x$games))

NFLgames1$Season <- '2016-2017'
NFLgames1$Type <- 'RegularSeason'
NFLgames2$Season <- '2015-2016'
NFLgames2$Type <- 'RegularSeason'
NFLgames3$Season <- '2016-2017'
NFLgames3$Type <- 'Playoffs'
NFLgames4$Season <- '2015-2016'
NFLgames4$Type <- 'Playoffs'
NFLgames5$Season <- '2015-2016'
NFLgames5$Type <- 'Playoffs'
NFLgames6$Season <- '2015-2016'
NFLgames6$Type <- 'Playoffs'
NFLgames7$Season <- '2015-2016'
NFLgames7$Type <- 'Playoffs'

NFLGames_Full_Data <- rbind(NFLgames1,NFLgames2,NFLgames3,NFLgames4,NFLgames5,NFLgames6,NFLgames7)

############ Quick Data Exploration ##################

## Explore the Endpoints
str(NFLTeamGameLogs_Full_Data)
colnames(NFLTeamGameLogs_Full_Data)
dim(NFLTeamGameLogs_Full_Data)

str(NFLteams)
dim(NFLteams)
colnames(NFLteams)  
sapply(NFLteams, class)

############## Data Cleaning ###################

### Handling missing data with MICE package

library(mice)

## Find all missing 

aggr_plot <- aggr(NFLTeamGameLogs_Full_Data, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE
                  , labels=names(NFLTeamGameLogs_Full_Data)
                  , cex.axis=.5, gap=1, ylab=c("Histogram of Missing MLB Data","Pattern"))

#Find all null columns: 
colnames(NFLTeamGameLogs_Full_Data)[colSums(is.na(NFLTeamGameLogs_Full_Data)) > 0]

## Rename Columns
NFLteams <- rename(NFLteams, teamname = name,
                   teamslug = slug)

colnames(NFLteams)[1] <- 'team_id' 

NFLteams <- within(NFLteams,  Team <- paste(location, nickname, sep=" "))

## Merge Team Game Logs with team info

NFLTeamGameLogs_Full_Data <- merge(NFLteams, NFLTeamGameLogs_Full_Data, by='team_id')  

################ Wins vs Salaries #####################

# Wins per Team

NFLTeamGameLogs_Full_Data$Win <- as.numeric(NFLTeamGameLogs_Full_Data$team_outcome == 'win')
Teams3 <- NFLTeamGameLogs_Full_Data[c('team_id','teamname','teamslug','Type','Win')]
NFLteams2 <- NFLteams[c('team_id','Team')]
AVG_Win_Per_Season_NFL <- sqldf("SELECT A.team_id AS TeamId,teamname AS TeamName, B.Team, teamslug AS Abbr, sum(Win)/2 AS Wins
                                FROM Teams3 A
                                LEFT JOIN NFLteams2 B
                                ON A.team_id = B.team_id
                                WHERE Type = 'RegularSeason'
                                GROUP BY A.team_id,teamname")
AVG_Win_Per_Season_NFL

# Salaries Per Team

url <- "http://www.spotrac.com/nfl/cap/2016/"
NFL_Salary <- url %>% read_html() %>%
  html_table(fill = TRUE)
NFL_Salary <- NFL_Salary[[1]]
NFL_Salary <- NFL_Salary[c('Team','Total Cap')]
names(NFL_Salary)[2]<-"TotalCap2016_2017"
NFL_Salary$TotalCap2016_2017 <- gsub(",","",NFL_Salary$TotalCap2016_2017) 
NFL_Salary$TotalCap2016_2017 <- as.numeric(gsub("\\$", "", NFL_Salary$TotalCap2016_2017))
NFL_Salary <- NFL_Salary[NFL_Salary$Team != "League Average", ]


NFL_Salary1 = subset(NFL_Salary, !(NFL_Salary$Team %in% c("Green Bay PackersGB","Kansas City ChiefsKC"
                                                          ,"Los Angeles RamsLA","New England PatriotsNE"
                                                          ,"San Diego ChargersSD","San Francisco 49ersSF"
                                                          ,"Tampa Bay BuccaneersTB","New Orleans SaintsNO")))

NFL_Salary2 = subset(NFL_Salary, (NFL_Salary$Team %in% c("Green Bay PackersGB","Kansas City ChiefsKC"
                                                         ,"Los Angeles RamsLA","New England PatriotsNE"
                                                         ,"San Diego ChargersSD","San Francisco 49ersSF"
                                                         ,"Tampa Bay BuccaneersTB","New Orleans SaintsNO")))

NFL_Salary1$Team = substr(NFL_Salary1$Team,1,nchar(NFL_Salary1$Team)-3)
NFL_Salary2$Team = substr(NFL_Salary2$Team,1,nchar(NFL_Salary2$Team)-2)

NFL_Salary <- rbind(NFL_Salary1, NFL_Salary2)
NFL_Salary$Team[NFL_Salary$Team == "San Diego Chargers"] <- "Los Angeles Chargers"


Wins_vs_Salary_NFL <- sqldf("SELECT A.TeamId, A.Team, TeamName, Abbr, Wins, TotalCap2016_2017 AS TeamSalary
                            FROM AVG_Win_Per_Season_NFL A
                            INNER JOIN NFL_Salary B
                            ON A.Team = B.Team")


## Merge Team Game Logs with team info

NFLTeamGameLogs_Full_Data <- merge(x = NFLTeamGameLogs_Full_Data, y = Team_Salary_NFL, by.x = "team_id", by.y = "TeamId", all.x = TRUE)


##################### Data Analysis #######################

## Checkpoint

NFLTeamGameLogs <- NFLTeamGameLogs_Full_Data[c('game_id', 'team_id','Type','Season','teamname','is_home_team', 'Win', 'TeamSalary', 'NumberofPlayers'
  ,'field_goals_attempted','field_goals_blocked','fourth_downs_attempted','fourth_downs_succeeded'             
  ,'fumbles','fumbles_lost','interception_returns','passer_rating','passing_first_downs'                 
  ,'passing_net_yards','passing_plays_attempted','passing_plays_completed','passing_plays_intercepted'           
  ,'passing_plays_sacked','passing_sacked_yards','penalties','penalty_first_downs','penalty_yards','punt_blocks'
  ,'punt_returns','rushing_first_downs','rushing_net_yards','rushing_plays','safeties','third_downs_attempted'
  ,'third_downs_succeeded','time_of_possession_secs','total_first_downs' 
  ,'points_quarter_1', 'points_quarter_2', 'points_quarter_3', 'points_quarter_4','points')]


############## Data Mutations ###################

# Create new column with the points scored through all quarters
NFLTeamGameLogs$points_quarter_1_to_4 <- NFLTeamGameLogs$points_quarter_1 + NFLTeamGameLogs$points_quarter_2 + NFLTeamGameLogs$points_quarter_3 + NFLTeamGameLogs$points_quarter_4
NFLTeamGameLogs$points_quarter_1_to_3 <- NFLTeamGameLogs$points_quarter_1 + NFLTeamGameLogs$points_quarter_2 + NFLTeamGameLogs$points_quarter_3
NFLTeamGameLogs$points_quarter_1_to_2 <- NFLTeamGameLogs$points_quarter_1 + NFLTeamGameLogs$points_quarter_2 


# Make sure there are only two entries per game_id 
check <- aggregate(cbind(count = game_id) ~ game_id, 
                   data = NFLTeamGameLogs, 
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]

############## Data Analysis ###################

# Utilize data.table's grouping math
dt_NFLTeamGameLogs <- data.table(NFLTeamGameLogs)

# Create new column with point difference through 1 quarter
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaQ1:=diff(points_quarter_1)*c(-1,1), by = game_id][]

# Create new column with point difference through 2 quarters
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaQ1_Q2:=diff(points_quarter_1_to_2)*c(-1,1), by = game_id][]

# Create new column with point difference through 3 quarters
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaQ1_Q3:=diff(points_quarter_1_to_3)*c(-1,1), by = game_id][]

# Create new column with point difference through 4 quarters
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaQ1_Q4:=diff(points_quarter_1_to_4)*c(-1,1), by = game_id][]

# Create new column with point difference at the end of the game
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaTS:=diff(points)*c(-1,1), by = game_id][]  


# Create new column with differentials of various stats for random forest / regression 

NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaFGA:=diff(field_goals_attempted)*c(-1,1), by = game_id][]  
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,Delta4DownSucceeded:=diff(fourth_downs_succeeded)*c(-1,1), by = game_id][]  
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaFumbles:=diff(fumbles)*c(-1,1), by = game_id][]  
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaPassing1Downs:=diff(passing_first_downs)*c(-1,1), by = game_id][]  
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaPassingNetYards:=diff(passing_net_yards)*c(-1,1), by = game_id][]
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaPenaltyYards:=diff(penalty_yards)*c(-1,1), by = game_id][]
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaRushing1Downs:=diff(rushing_first_downs)*c(-1,1), by = game_id][]
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaRushingNetYards:=diff(rushing_net_yards)*c(-1,1), by = game_id][]
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,Delta3DownSucceeded:=diff(third_downs_succeeded)*c(-1,1), by = game_id][]  
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaTOP_secs:=diff(time_of_possession_secs)*c(-1,1), by = game_id][]  
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaTotalFirstDowns:=diff(total_first_downs)*c(-1,1), by = game_id][] 
NFLTeamGameLogs <- dt_NFLTeamGameLogs[,DeltaTeamSalary:=diff(TeamSalary)*c(-1,1), by = game_id][] 

# Convert all new fields to absolute values

NFLTeamGameLogs$DeltaFGA <- abs(NFLTeamGameLogs$DeltaFGA)
NFLTeamGameLogs$Delta4DownSucceeded <- abs(NFLTeamGameLogs$Delta4DownSucceeded)
NFLTeamGameLogs$DeltaFumbles <- abs(NFLTeamGameLogs$DeltaFumbles)
NFLTeamGameLogs$DeltaPassing1Downs <- abs(NFLTeamGameLogs$DeltaPassing1Downs)
NFLTeamGameLogs$DeltaPassingNetYards <- abs(NFLTeamGameLogs$DeltaPassingNetYards)
NFLTeamGameLogs$DeltaPenaltyYards <- abs(NFLTeamGameLogs$DeltaPenaltyYards)
NFLTeamGameLogs$DeltaRushing1Downs <- abs(NFLTeamGameLogs$DeltaRushing1Downs)
NFLTeamGameLogs$DeltaRushingNetYards <- abs(NFLTeamGameLogs$DeltaRushingNetYards)
NFLTeamGameLogs$Delta3DownSucceeded <- abs(NFLTeamGameLogs$Delta3DownSucceeded)
NFLTeamGameLogs$DeltaTOP_secs <- abs(NFLTeamGameLogs$DeltaTOP_secs)
NFLTeamGameLogs$DeltaTotalFirstDowns <- abs(NFLTeamGameLogs$DeltaTotalFirstDowns)
NFLTeamGameLogs$DeltaTeamSalary <- abs(NFLTeamGameLogs$DeltaTeamSalary)

# Threshold for comeback games

Losers <- NFLTeamGameLogs[which(NFLTeamGameLogs$DeltaTS < 1),]
Losers <- Losers$DeltaQ1_Q3

NFL_Threshold <- round(mean(Losers),0)


# Create a new boolean column if the game went to overtime
NFLTeamGameLogs$Overtime <- as.numeric(NFLTeamGameLogs$DeltaQ1_Q4 == 0)

# Create a new boolean column if the game meets 'Comeback' criteria
NFLTeamGameLogs$IsComeback <- as.numeric(NFLTeamGameLogs$DeltaQ1_Q3 <= NFL_Threshold & NFLTeamGameLogs$DeltaTS > 1)

# Create a new boolean column if the game meets 'Comeback' criteria (2)
NFLTeamGameLogs$IsComeback2 <- as.numeric(NFLTeamGameLogs$DeltaQ1_Q2 <= NFL_Threshold & NFLTeamGameLogs$DeltaTS > 1)

# Create a new boolean column if the game meets 'Close Game' criteria (1)
NFLTeamGameLogs$IsCloseGame <- as.numeric(abs(NFLTeamGameLogs$DeltaQ1) <= 8 & abs(NFLTeamGameLogs$DeltaQ1_Q2) <= 8 
                                     & abs(NFLTeamGameLogs$DeltaQ1_Q3) <= 8 & (abs(NFLTeamGameLogs$DeltaTS) <= 8 | NFLTeamGameLogs$Overtime == 1))

# Create a new boolean column if the game meets 'Close Game' criteria (2)
NFLTeamGameLogs$IsCloseGame2 <- as.numeric(abs(NFLTeamGameLogs$DeltaQ1_Q3) <= 8 & (abs(NFLTeamGameLogs$DeltaTS) <= 8 | NFLTeamGameLogs$Overtime == 1))
NFL_Playoffs$IsCloseGame2 <- as.numeric(abs(NFL_Playoffs$DeltaQ1_Q3) <= 8 & (abs(NFL_Playoffs$DeltaTS) <= 8 | NFL_Playoffs$Overtime == 1))

# Create a new boolean column if the game meets 'Close Game' criteria (3)
NFLTeamGameLogs$IsCloseGame3 <- as.numeric(abs(NFLTeamGameLogs$DeltaTS) <= 8 | NFLTeamGameLogs$Overtime == 1)

# Create a new boolean column if the game meets 'Blow Out' criteria (1)
NFLTeamGameLogs$IsBlowOut <- as.numeric(abs(NFLTeamGameLogs$DeltaQ1) > 24 & abs(NFLTeamGameLogs$DeltaQ1_Q2) > 24 
                                     & abs(NFLTeamGameLogs$DeltaQ1_Q3) > 24 & abs(NFLTeamGameLogs$DeltaTS) > 24)

# Create a new boolean column if the game meets 'Blow Out' criteria (2)
NFLTeamGameLogs$IsBlowOut2 <- as.numeric(abs(NFLTeamGameLogs$DeltaQ1_Q3) > 24 & abs(NFLTeamGameLogs$DeltaTS) > 24)

# Create a new boolean column if the game meets 'Blow Out' criteria (3)
NFLTeamGameLogs$IsBlowOut3 <- as.numeric(abs(NFLTeamGameLogs$DeltaTS) > 24)


colnames(NFLTeamGameLogs)
setDF(NFLTeamGameLogs)


# Check mutations
NFLTeamGameLogs[which(NFLTeamGameLogs$IsComeback== 1),]
NFLTeamGameLogs[which(NFLTeamGameLogs$game_id == 'd5e466ea-e901-46b9-a87b-86f196cf7f5d'),]
NFLTeamGameLogs[which(NFLTeamGameLogs$IsCloseGame== 1),]
NFLTeamGameLogs[which(NFLTeamGameLogs$game_id == 'd3fc9bef-0e98-4745-81d3-4ca7aed6df7a'),]

#Sub set by season
NFL_RegularSeason <- NFLTeamGameLogs[which(NFLTeamGameLogs$Type == 'RegularSeason'),]
NFL_Playoffs <- NFLTeamGameLogs[which(NFLTeamGameLogs$Type == 'Playoffs'),]

############## Results ###################

# Comebacks - Case 1
ComebacksInNFL_RegularSeason <- (sum(NFL_RegularSeason$IsComeback)/sum(as.numeric(NFL_RegularSeason$DeltaQ1_Q3 <= NFL_Threshold)))*100
ComebacksInNFL_Playoffs<- (sum(NFL_Playoffs$IsComeback)/sum(as.numeric(NFL_Playoffs$DeltaQ1_Q3 <= NFL_Threshold)))*100
# Results
ComebacksInNFL_RegularSeason
ComebacksInNFL_Playoffs

# Comebacks - Case 2
ComebacksInNFL_RegularSeason_2 <- (sum(NFL_RegularSeason$IsComeback2)/sum(as.numeric(NFL_RegularSeason$DeltaQ1_Q2 <= NFL_Threshold)))*100
ComebacksInNFL_Playoffs_2 <- (sum(NFL_Playoffs$IsComeback2)/sum(as.numeric(NFL_Playoffs$DeltaQ1_Q2 <= NFL_Threshold)))*100
# Results
ComebacksInNFL_RegularSeason_2
ComebacksInNFL_Playoffs_2

AVGComebackNFL <- (ComebacksInNFL_RegularSeason+ComebacksInNFL_Playoffs
                   +ComebacksInNFL_RegularSeason_2+ComebacksInNFL_Playoffs_2)/4

# Close Games - Case 1
CloseGamesInNFL_RegularSeason <- ((sum(NFL_RegularSeason$IsCloseGame)/2)/length(unique(NFL_RegularSeason$game_id)))*100
CloseGamesInNFL_Playoffs <- ((sum(NFL_Playoffs$IsCloseGame)/2)/length(unique(NFL_Playoffs$game_id)))*100
# Results
CloseGamesInNFL_RegularSeason
CloseGamesInNFL_Playoffs

# Close Games - Case 2
CloseGamesInNFL_RegularSeason_2 <- ((sum(NFL_RegularSeason$IsCloseGame2)/2)/length(unique(NFL_RegularSeason$game_id)))*100
CloseGamesInNFL_Playoffs_2 <- ((sum(NFL_Playoffs$IsCloseGame2)/2)/length(unique(NFL_Playoffs$game_id)))*100
# Results
CloseGamesInNFL_RegularSeason_2
CloseGamesInNFL_Playoffs_2

# Close Games - Case 3
CloseGamesInNFL_RegularSeason_3 <- ((sum(NFL_RegularSeason$IsCloseGame3)/2)/length(unique(NFL_RegularSeason$game_id)))*100
CloseGamesInNFL_Playoffs_3 <- ((sum(NFL_Playoffs$IsCloseGame3)/2)/length(unique(NFL_Playoffs$game_id)))*100
# Results
CloseGamesInNFL_RegularSeason_3
CloseGamesInNFL_Playoffs_3

AVGCloseGameNFL <- (CloseGamesInNFL_RegularSeason+CloseGamesInNFL_Playoffs
                    +CloseGamesInNFL_RegularSeason_2+CloseGamesInNFL_Playoffs_2
                    +CloseGamesInNFL_RegularSeason_3+CloseGamesInNFL_Playoffs_3)/6

# Blow Outs - Case 1
BlowOutsInNFL_RegularSeason <- ((sum(NFL_RegularSeason$IsBlowOut)/2)/length(unique(NFL_RegularSeason$game_id)))*100
BlowOutsInNFL_Playoffs <- ((sum(NFL_Playoffs$IsBlowOut)/2)/length(unique(NFL_Playoffs$game_id)))*100
# Results
BlowOutsInNFL_RegularSeason
BlowOutsInNFL_Playoffs

# Blow Outs - Case 2
BlowOutsInNFL_RegularSeason_2 <- ((sum(NFL_RegularSeason$IsBlowOut2)/2)/length(unique(NFL_RegularSeason$game_id)))*100
BlowOutsInNFL_Playoffs_2 <- ((sum(NFL_Playoffs$IsBlowOut2)/2)/length(unique(NFL_Playoffs$game_id)))*100
# Results
BlowOutsInNFL_RegularSeason_2
BlowOutsInNFL_Playoffs_2

# Blow Outs - Case 3
BlowOutsInNFL_RegularSeason_3 <- ((sum(NFL_RegularSeason$IsBlowOut3)/2)/length(unique(NFL_RegularSeason$game_id)))*100
BlowOutsInNFL_Playoffs_3 <- ((sum(NFL_Playoffs$IsBlowOut3)/2)/length(unique(NFL_Playoffs$game_id)))*100
# Results
BlowOutsInNFL_RegularSeason_3
BlowOutsInNFL_Playoffs_3

AVGBlowoutNFL <- (BlowOutsInNFL_RegularSeason+BlowOutsInNFL_Playoffs
                  +BlowOutsInNFL_RegularSeason_2+BlowOutsInNFL_Playoffs_2
                  +BlowOutsInNFL_RegularSeason_3+BlowOutsInNFL_Playoffs_3)/6

AVGComebackNFL
AVGCloseGameNFL
AVGBlowoutNFL

######################## Random Forest / Log Regression ################

## Rename Columns
colnames(NFLGames_Full_Data)[1] <- 'game_id' 

check <- aggregate(cbind(count = game_id) ~ game_id, 
                   data = NFLGames_Full_Data, 
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]

NFLGames <- NFLGames_Full_Data[c('game_id','attendance','away_team_outcome','home_team_outcome'
                                 ,'score_differential','scoreline','Season','Type')]

NFLTeamGameLogs_RF <- NFLTeamGameLogs[c('game_id','Type','Season'
                                        ,'DeltaFGA','Delta4DownSucceeded','DeltaFumbles','DeltaPassing1Downs','DeltaPassingNetYards'      
                                        ,'DeltaPenaltyYards','DeltaRushing1Downs','DeltaRushingNetYards'
                                        ,'Delta3DownSucceeded','DeltaTOP_secs','DeltaTotalFirstDowns', 'DeltaTeamSalary'
                                        ,'IsCloseGame','IsCloseGame2','IsCloseGame3', 'IsBlowOut', 'IsBlowOut2','IsBlowOut3')]

NFLTeamGameLogs_RF <- sqldf("SELECT DISTINCT * 
                            FROM NFLTeamGameLogs_RF")


NFLGameData_Models <- sqldf("SELECT A.game_id AS Game_Id,A.Type,A.Season, attendance AS Attendance, score_differential AS ScoreDifferential
                            , scoreline AS Scoreline,DeltaFGA,Delta4DownSucceeded,DeltaFumbles,DeltaPassing1Downs
                            , DeltaPassingNetYards,DeltaPenaltyYards,DeltaRushing1Downs,DeltaRushingNetYards
                            ,Delta3DownSucceeded,DeltaTOP_secs,DeltaTotalFirstDowns, DeltaTeamSalary
                            ,IsCloseGame,IsCloseGame2,IsCloseGame3, IsBlowOut, IsBlowOut2,IsBlowOut3
                            FROM NFLTeamGameLogs_RF A 
                            INNER JOIN NFLGames B
                            ON A.game_id = B.game_id")


################# CART model ###################

# Split the data
library(caTools)

# Install rpart library
library(rpart)
library(rpart.plot)

# ROC curve
library(ROCR)

# randomForest 
library(randomForest)

# feature importance 
library(caret)

## Cross validation

library(caret)
library(e1071)

### Close Games 

# Split Data
set.seed(3000)
spl = sample.split(NFLGameData_Models$IsCloseGame3, SplitRatio = 0.7)
Train = subset(NFLGameData_Models, spl==TRUE)
Test = subset(NFLGameData_Models, spl==FALSE)


NFL_Close_Games_Tree = rpart(IsCloseGame3 ~ DeltaFGA+Delta4DownSucceeded
                             +DeltaFumbles+DeltaPassing1Downs+DeltaPassingNetYards
                             +DeltaPenaltyYards+DeltaRushing1Downs+DeltaRushingNetYards
                             +Delta3DownSucceeded+DeltaTOP_secs
                             +DeltaTotalFirstDowns+ DeltaTeamSalary
                             , data = Train, method="class", minbucket=25)

png(
  "NFL_closegames_tree.png",
  width     = 2.13,
  height    = 1.42,
  units     = "in",
  res       = 600,
  pointsize = 4
)
par(
  mar      = c(5, 5, 2, 2),
  xaxs     = "i",
  yaxs     = "i",
  cex.axis = 2,
  cex.lab  = 2
)
rpart.plot(NFL_Close_Games_Tree
           , uniform=TRUE, compress=TRUE
           , fallen=T, branch=1, round=0, cex.main=1
           , split.round=0
           , branch.lwd=.5, split.lwd=.5, nn.lwd=.5
           , main = "Classification Tree for Close Games in the NFL")
dev.off()

# Make predictions
PredictCART = predict(NFL_Close_Games_Tree, newdata = Test, type = "class")
table(Test$IsCloseGame3, PredictCART)


#Measure accuracy with confusion matrix
NFL_Model_Accuracy <- (36+58)/(36+58+31+35)
NFL_Model_Accuracy

#Baseline 
NFL_Baseline <- (36+38)/(36+58+31+35)
NFL_Baseline

PredictROC = predict(NFL_Close_Games_Tree, newdata = Test)
PredictROC

pred = prediction(PredictROC[,2], Test$IsCloseGame3)
perf = performance(pred, "tpr", "fpr")

## ROC curve

png(
  "NFL_roc_curve.png",
  width     = 2.13,
  height    = 1.42,
  units     = "in",
  res       = 600,
  pointsize = 3
)
par(
  mar      = c(5, 5, 2, 2),
  xaxs     = "i",
  yaxs     = "i",
  cex.axis = 2,
  cex.lab  = 2
)
plot(perf)
title('ROC Curve for NFL Tree')
text(0.6, 0.4, labels=("AUC = 0.57"), col="red")
dev.off()

NFL_AUC <- as.numeric(performance(pred, "auc")@y.values)


################# Random Forests #########################

# Close Games 

# Convert outcome to factor for classification model
Train$IsCloseGame3 = as.factor(Train$IsCloseGame3)
Test$IsCloseGame3 = as.factor(Test$IsCloseGame3)

NFL_CloseGame_Forest = randomForest(IsCloseGame3 ~ DeltaFGA+Delta4DownSucceeded
                                    +DeltaFumbles+DeltaPassing1Downs+DeltaPassingNetYards
                                    +DeltaPenaltyYards+DeltaRushing1Downs+DeltaRushingNetYards
                                    +Delta3DownSucceeded+DeltaTOP_secs
                                    +DeltaTotalFirstDowns+ DeltaTeamSalary
                                    , data = Train, ntree=200, nodesize=25 )

# Make predictions
PredictForest = predict(NFL_CloseGame_Forest, newdata = Test)
table(Test$IsCloseGame3, PredictForest)
NFL_Random_Forest_Model_Accuracy <- (22+74)/(22+74+15+49)
NFL_Random_Forest_Model_Accuracy
























































