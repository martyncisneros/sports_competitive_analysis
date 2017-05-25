########## Pre-Analysis Set Up ############

## Load Packages
library(stattleshipR)  
library(sqldf)
library(dplyr)  

## Set Stattleship API Token
set_token('a9640e5acda75c174077be6390b05769')

########## Get Data from Stattleship API ###################

## Set Query Parameters

NHLseason17 <- list(status='ended', interval_type='regularseason',season_id='nhl-2016-2017') 
NHLseason16 <- list(status='ended', interval_type='regularseason',season_id='nhl-2015-2016') 
NHLPlayoffs17 <- list(status='ended', interval_type='postseason',season_id='nhl-2016-2017') 
NHLPlayoffs16_cqf <- list(status='ended', interval_type='conferencequarterfinals',season_id='nhl-2015-2016') 
NHLPlayoffs16_csf <- list(status='ended', interval_type='conferencesemifinals',season_id='nhl-2015-2016') 
NHLPlayoffs16_cf <- list(status='ended', interval_type='conferencefinals',season_id='nhl-2015-2016') 
NHLPlayoffs16_f <- list(status='ended', interval_type='stanleycupfinals',season_id='nhl-2015-2016') 


#### Get Team Game Log Data
NHLteamgamelogs1 <- ss_get_result(sport='hockey', league='NHL', ep='team_game_logs',
                          query=NHLseason17 , version=1, walk=TRUE, verbose=TRUE)
NHLteamgamelogs2 <- ss_get_result(sport='hockey', league='NHL', ep='team_game_logs',
                          query=NHLseason16 , version=1, walk=TRUE, verbose=TRUE)
NHLteamgamelogs3 <- ss_get_result(sport='hockey', league='NHL', ep='team_game_logs',
                               query=NHLPlayoffs17 , version=1, walk=TRUE, verbose=TRUE)
NHLteamgamelogs4 <- ss_get_result(sport='hockey', league='NHL', ep='team_game_logs',
                                 query=NHLPlayoffs16_cqf , version=1, walk=TRUE, verbose=TRUE)
NHLteamgamelogs5 <- ss_get_result(sport='hockey', league='NHL', ep='team_game_logs',
                                 query=NHLPlayoffs16_csf , version=1, walk=TRUE, verbose=TRUE)
NHLteamgamelogs6 <- ss_get_result(sport='hockey', league='NHL', ep='team_game_logs',
                                 query=NHLPlayoffs16_cf , version=1, walk=TRUE, verbose=TRUE)
NHLteamgamelogs7 <- ss_get_result(sport='hockey', league='NHL', ep='team_game_logs',
                                 query=NHLPlayoffs16_f , version=1, walk=TRUE, verbose=TRUE)


NHLteamgamelogs1 <- do.call('rbind',lapply(NHLteamgamelogs1, function(x) x$team_game_logs))
NHLteamgamelogs2 <- do.call('rbind',lapply(NHLteamgamelogs2, function(x) x$team_game_logs))
NHLteamgamelogs3 <- do.call('rbind',lapply(NHLteamgamelogs3, function(x) x$team_game_logs))
NHLteamgamelogs4 <- do.call('rbind',lapply(NHLteamgamelogs4, function(x) x$team_game_logs))
NHLteamgamelogs5 <- do.call('rbind',lapply(NHLteamgamelogs5, function(x) x$team_game_logs))
NHLteamgamelogs6 <- do.call('rbind',lapply(NHLteamgamelogs6, function(x) x$team_game_logs))
NHLteamgamelogs7 <- do.call('rbind',lapply(NHLteamgamelogs7, function(x) x$team_game_logs))

NHLteamgamelogs1$Season <- '2016-2017'
NHLteamgamelogs1$Type <- 'RegularSeason'
NHLteamgamelogs2$Season <- '2015-2016'
NHLteamgamelogs2$Type <- 'RegularSeason'
NHLteamgamelogs3$Season <- '2016-2017'
NHLteamgamelogs3$Type <- 'Playoffs'
NHLteamgamelogs4$Season <- '2015-2016'
NHLteamgamelogs4$Type <- 'Playoffs'
NHLteamgamelogs5$Season <- '2015-2016'
NHLteamgamelogs5$Type <- 'Playoffs'
NHLteamgamelogs6$Season <- '2015-2016'
NHLteamgamelogs6$Type <- 'Playoffs'
NHLteamgamelogs7$Season <- '2015-2016'
NHLteamgamelogs7$Type <- 'Playoffs'

NHLTeamGameLogs_Full_Data <- rbind(NHLteamgamelogs1, NHLteamgamelogs2
                                   , NHLteamgamelogs3, NHLteamgamelogs4
                                   , NHLteamgamelogs5, NHLteamgamelogs6
                                   , NHLteamgamelogs7)

# Get Teams Data

NHLteams <- ss_get_result(sport='hockey', league='NHL', ep='teams', version=1, walk=TRUE, verbose=TRUE)
NHLteams <-do.call('rbind', lapply(NHLteams, function(x) x$teams)) 


# Get Players Data

NHL_Players <- ss_get_result(sport='hockey', league='NHL', ep='players', walk=TRUE)
NHL_Players <- do.call('rbind',lapply(NHL_Players, function(x) x$players))

# Get Roster Data

NHL_Rosters17 <- ss_get_result(sport='hockey', query=NHLseason17, league='NHL', ep='rosters', walk=TRUE)
NHL_Rosters17 <- do.call('rbind',lapply(NHL_Rosters17, function(x) x$players))
NHL_Rosters17$Season <- '2016-2017'

##### Get Games Data

NHLgames1 <- ss_get_result(sport='hockey', league='NHL', ep='games',
                           query=NHLseason17 , version=1, walk=TRUE, verbose=TRUE)
NHLgames2 <- ss_get_result(sport='hockey', league='NHL', ep='games',
                           query=NHLseason16 , version=1, walk=TRUE, verbose=TRUE)
NHLgames3 <- ss_get_result(sport='hockey', league='NHL', ep='games',
                           query=NHLPlayoffs17 , version=1, walk=TRUE, verbose=TRUE)
NHLgames4 <- ss_get_result(sport='hockey', league='NHL', ep='games',
                           query=NHLPlayoffs16_cqf , version=1, walk=TRUE, verbose=TRUE)
NHLgames5 <- ss_get_result(sport='hockey', league='NHL', ep='games',
                           query=NHLPlayoffs16_csf , version=1, walk=TRUE, verbose=TRUE)
NHLgames6 <- ss_get_result(sport='hockey', league='NHL', ep='games',
                           query=NHLPlayoffs16_cf , version=1, walk=TRUE, verbose=TRUE)
NHLgames7 <- ss_get_result(sport='hockey', league='NHL', ep='games',
                           query=NHLPlayoffs16_f , version=1, walk=TRUE, verbose=TRUE)

NHLgames1 <- do.call('rbind',lapply(NHLgames1, function(x) x$games))
NHLgames2 <- do.call('rbind',lapply(NHLgames2, function(x) x$games))
NHLgames3 <- do.call('rbind',lapply(NHLgames3, function(x) x$games))
NHLgames4 <- do.call('rbind',lapply(NHLgames4, function(x) x$games))
NHLgames5 <- do.call('rbind',lapply(NHLgames5, function(x) x$games))
NHLgames6 <- do.call('rbind',lapply(NHLgames6, function(x) x$games))
NHLgames7 <- do.call('rbind',lapply(NHLgames7, function(x) x$games))

NHLgames1$Season <- '2016-2017'
NHLgames1$Type <- 'RegularSeason'
NHLgames2$Season <- '2015-2016'
NHLgames2$Type <- 'RegularSeason'
NHLgames3$Season <- '2016-2017'
NHLgames3$Type <- 'Playoffs'
NHLgames4$Season <- '2015-2016'
NHLgames4$Type <- 'Playoffs'
NHLgames5$Season <- '2015-2016'
NHLgames5$Type <- 'Playoffs'
NHLgames6$Season <- '2015-2016'
NHLgames6$Type <- 'Playoffs'
NHLgames7$Season <- '2015-2016'
NHLgames7$Type <- 'Playoffs'

NHLGames_Full_Data <- rbind(NHLgames1,NHLgames2,NHLgames3, NHLgames4,NHLgames5,NHLgames6,NHLgames7)


############ Quick Data Exploration ##################

pMiss <- function(x){sum(is.na(x))/length(x)*100}
apply(NHLTeamGameLogs_Full_Data,2,pMiss)

## Explore the Endpoints
str(NHLTeamGameLogs_Full_Data)
colnames(NHLTeamGameLogs_Full_Data)
dim(NHLTeamGameLogs_Full_Data)

str(NHLteams)
dim(NHLteams)
colnames(NHLteams)  
sapply(NHLteams, class)

############## Data Cleaning ###################


### Handling missing data with MICE package

library(mice)

## Find all missing 

aggr_plot <- aggr(NHLTeamGameLogs_Full_Data, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE
                  , labels=names(NHLTeamGameLogs_Full_Data)
                  , cex.axis=.5, gap=1, ylab=c("Histogram of Missing MLB Data","Pattern"))

#Find all null columns: 
colnames(NHLTeamGameLogs_Full_Data)[colSums(is.na(NHLTeamGameLogs_Full_Data)) > 0]

pMiss <- function(x){sum(is.na(x))/length(x)*100}
apply(NHLTeamGameLogs_Full_Data,2,pMiss)

## Will remove all null variables, 50%+

## Rename Columns
NHLteams <- rename(NHLteams, teamname = name,
                   teamslug = slug)

colnames(NHLteams)[1] <- 'team_id' 

## Merge Team Game Logs with team info

NHLTeamGameLogs_Full_Data <- merge(NHLteams, NHLTeamGameLogs_Full_Data, by='team_id')  


################ Wins vs Salaries #####################

# Wins per Team

NHLTeamGameLogs_Full_Data$Win <- as.numeric(NHLTeamGameLogs_Full_Data$team_outcome == 'win')
Teams <- NHLTeamGameLogs_Full_Data[c('team_id','teamname','teamslug','Type','Win')]
AVG_Win_Per_Season_NHL <- sqldf("SELECT team_id AS TeamId,teamname AS TeamName, teamslug AS Abbr, sum(Win)/2 AS Wins
                                FROM Teams
                                WHERE Type = 'RegularSeason'
                                GROUP BY team_id,teamname")
AVG_Win_Per_Season_NHL

# Salaries Per Team

colnames(NHL_Players)[1] <- 'player_id' 
colnames(NHL_Rosters17)[1] <- 'player_id' 

NHL_Players_DF <- NHL_Players[which(NHL_Players$active == 'TRUE'),]
NHL_Players_DF <- NHL_Players_DF[c('name','salary','humanized_salary','salary_currency','league_id','team_id','player_id')]
Team_Salary_NHL <- sqldf("SELECT A.team_id AS TeamId, sum(A.salary) AS TeamSalary, count(*) AS NumberofPlayers
                         FROM NHL_Players_DF A
                            INNER JOIN NHL_Rosters17 B
                            ON A.player_id = B.player_id AND A.team_id = B.team_id
                            GROUP BY A.team_id")
# Merge Dataframes

Wins_vs_Salary_NHL <- sqldf("SELECT A.TeamId, TeamName, Abbr, Wins, TeamSalary, NumberofPlayers
                            FROM AVG_Win_Per_Season_NHL A
                            INNER JOIN Team_Salary_NHL B
                            ON A.TeamId = B.TeamId")

## Merge Team Game Logs with team info

NHLTeamGameLogs_Full_Data <- merge(x = NHLTeamGameLogs_Full_Data, y = Team_Salary_NHL, by.x = "team_id", by.y = "TeamId", all.x = TRUE)


##################### Data Analysis #######################

## Checkpoint

NHLTeamGameLogs <- NHLTeamGameLogs_Full_Data[c('game_id', 'team_id','Type','Season','teamname','is_home_team', 'Win'
                                               , 'TeamSalary', 'NumberofPlayers','faceoff_total_wins','goalie_assists'                      
                                               ,'goalie_hits', 'goalie_penalty_minutes','goalie_saves','goalie_shots_against'                
                                               ,'goalie_time_on_ice_power_play_secs','goalie_time_on_ice_secs','goalie_time_on_ice_short_handed_secs'
                                               ,'penalties','penalty_minutes','player_assists','player_blocked_shots'                
                                               ,'player_hits','player_plus_minus','player_time_on_ice_power_play_secs','player_time_on_ice_short_handed_secs','power_plays'
                                               ,'shots', 'goals_period_1', 'goals_period_2', 'goals_period_3','goals')]

## double check there are no more null columns
#Find all null columns: 
colnames(NHLTeamGameLogs)[colSums(is.na(NHLTeamGameLogs)) > 0]
sapply(NHLTeamGameLogs, function(x) sum(is.na(x)))

############## Data Mutations ###################

# Create new column with the points scored through all quarters
NHLTeamGameLogs$goals_period_1_to_3 <- NHLTeamGameLogs$goals_period_1 + NHLTeamGameLogs$goals_period_2 + NHLTeamGameLogs$goals_period_3
NHLTeamGameLogs$goals_period_1_to_2 <- NHLTeamGameLogs$goals_period_1 + NHLTeamGameLogs$goals_period_2 


# Make sure there are only two entries per game_id 
check <- aggregate(cbind(count = game_id) ~ game_id, 
                   data = NHLTeamGameLogs, 
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]

############## Data Analysis ###################

# Utilize data.table's grouping math
dt_NHLTeamGameLogs <- data.table(NHLTeamGameLogs)

# Create new column with point difference through 1 quarter
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaQ1:=diff(goals_period_1)*c(-1,1), by = game_id][]

# Create new column with point difference through 2 quarters
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaQ1_Q2:=diff(goals_period_1_to_2)*c(-1,1), by = game_id][]

# Create new column with point difference through 3 quarters
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaQ1_Q3:=diff(goals_period_1_to_3)*c(-1,1), by = game_id][]

# Create new column with point difference at the end of the game
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaTS:=diff(goals)*c(-1,1), by = game_id][]  


# Create new column with differentials of various stats for random forest / regression 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaTotalFOWins:=diff(faceoff_total_wins)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaGoalieAssists:=diff(goalie_assists)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaGoalieHits:=diff(goalie_hits)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaGoaliePenaltyMins:=diff(goalie_penalty_minutes)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaGoalieSaves:=diff(goalie_saves)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaGoalieShotsAgainst:=diff(goalie_shots_against)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaGoalieTOIPowerPlay_secs:=diff(goalie_time_on_ice_power_play_secs)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaGoalieTOI_secs:=diff(goalie_time_on_ice_secs)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaGoalieTOIShortHanded_secs:=diff(goalie_time_on_ice_short_handed_secs)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaPenalties:=diff(penalties)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaPenalty_mins:=diff(penalty_minutes)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaPlayerAssists:=diff(player_assists)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaPlayerBlockedShots:=diff(player_blocked_shots)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaPlayerHits:=diff(player_hits)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaPlayerPlusMinus:=diff(player_plus_minus)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaPlayerTOIPowerPlay_secs:=diff(player_time_on_ice_power_play_secs)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaPlayerTOIShortHanded_secs:=diff(player_time_on_ice_short_handed_secs)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaPowerPlays:=diff(power_plays)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaShots:=diff(shots)*c(-1,1), by = game_id][] 
NHLTeamGameLogs <- dt_NHLTeamGameLogs[,DeltaTeamSalary:=diff(TeamSalary)*c(-1,1), by = game_id][] 


# Convert all new fields to absolute values
NHLTeamGameLogs$DeltaTotalFOWins <- abs(NHLTeamGameLogs$DeltaTotalFOWins)
NHLTeamGameLogs$DeltaGoalieAssists <- abs(NHLTeamGameLogs$DeltaGoalieAssists)
NHLTeamGameLogs$DeltaGoalieHits <- abs(NHLTeamGameLogs$DeltaGoalieHits)
NHLTeamGameLogs$DeltaGoaliePenaltyMins <- abs(NHLTeamGameLogs$DeltaGoaliePenaltyMins)
NHLTeamGameLogs$DeltaGoalieSaves <- abs(NHLTeamGameLogs$DeltaGoalieSaves)
NHLTeamGameLogs$DeltaGoalieShotsAgainst <- abs(NHLTeamGameLogs$DeltaGoalieShotsAgainst)
NHLTeamGameLogs$DeltaGoalieTOIPowerPlay_secs <- abs(NHLTeamGameLogs$DeltaGoalieTOIPowerPlay_secs)
NHLTeamGameLogs$DeltaGoalieTOI_secs <- abs(NHLTeamGameLogs$DeltaGoalieTOI_secs)
NHLTeamGameLogs$DeltaGoalieTOIShortHanded_secs <- abs(NHLTeamGameLogs$DeltaGoalieTOIShortHanded_secs)
NHLTeamGameLogs$DeltaPenalties <- abs(NHLTeamGameLogs$DeltaPenalties)
NHLTeamGameLogs$DeltaPenalty_mins <- abs(NHLTeamGameLogs$DeltaPenalty_mins)
NHLTeamGameLogs$DeltaPlayerAssists <- abs(NHLTeamGameLogs$DeltaPlayerAssists)
NHLTeamGameLogs$DeltaPlayerBlockedShots <- abs(NHLTeamGameLogs$DeltaPlayerBlockedShots)
NHLTeamGameLogs$DeltaPlayerHits <- abs(NHLTeamGameLogs$DeltaPlayerHits)
NHLTeamGameLogs$DeltaPlayerPlusMinus <- abs(NHLTeamGameLogs$DeltaPlayerPlusMinus)
NHLTeamGameLogs$DeltaPlayerTOIPowerPlay_secs <- abs(NHLTeamGameLogs$DeltaPlayerTOIPowerPlay_secs)
NHLTeamGameLogs$DeltaPlayerTOIShortHanded_secs <- abs(NHLTeamGameLogs$DeltaPlayerTOIShortHanded_secs)
NHLTeamGameLogs$DeltaPowerPlays <- abs(NHLTeamGameLogs$DeltaPowerPlays)
NHLTeamGameLogs$DeltaShots <- abs(NHLTeamGameLogs$DeltaShots)
NHLTeamGameLogs$DeltaTeamSalary <- abs(NHLTeamGameLogs$DeltaTeamSalary)


# Threshold for comeback games

Losers <- NHLTeamGameLogs[which(NHLTeamGameLogs$DeltaTS < 1),]
Losers <- Losers$DeltaQ1_Q2

NHL_Threshold <- round(mean(Losers),0)


# Create a new boolean column if the game went to overtime
NHLTeamGameLogs$Overtime <- as.numeric(NHLTeamGameLogs$DeltaQ1_Q3 == 0)

# Create a new boolean column if the game meets 'Comeback' criteria
NHLTeamGameLogs$IsComeback <- as.numeric(NHLTeamGameLogs$DeltaQ1_Q2 <= NHL_Threshold & NHLTeamGameLogs$DeltaTS > 1)

# Create a new boolean column if the game meets 'Comeback' criteria (2)
NHLTeamGameLogs$IsComeback2 <- as.numeric(NHLTeamGameLogs$DeltaQ1 <= NHL_Threshold & NHLTeamGameLogs$DeltaTS > 1)

# Create a new boolean column if the game meets 'Close Game' criteria (1)
NHLTeamGameLogs$IsCloseGame <- as.numeric(abs(NHLTeamGameLogs$DeltaQ1) <= 1 & abs(NHLTeamGameLogs$DeltaQ1_Q2) <= 1
                                     & (abs(NHLTeamGameLogs$DeltaTS) <= 1 | NHLTeamGameLogs$Overtime == 1))

# Create a new boolean column if the game meets 'Close Game' criteria (2)
NHLTeamGameLogs$IsCloseGame2 <- as.numeric(abs(NHLTeamGameLogs$DeltaQ1_Q2) <= 1 & (abs(NHLTeamGameLogs$DeltaTS) <= 1 | NHLTeamGameLogs$Overtime == 1))

# Create a new boolean column if the game meets 'Close Game' criteria (3)
NHLTeamGameLogs$IsCloseGame3 <- as.numeric(abs(NHLTeamGameLogs$DeltaTS) <= 1 | NHLTeamGameLogs$Overtime == 1)

# Create a new boolean column if the game meets 'Blow Outs' criteria (1)
NHLTeamGameLogs$IsBlowOut <- as.numeric(abs(NHLTeamGameLogs$DeltaQ1) > 3 & abs(NHLTeamGameLogs$DeltaQ1_Q2) > 3
                                     & abs(NHLTeamGameLogs$DeltaTS) > 3 )

# Create a new boolean column if the game meets 'Blow Outs' criteria (2)
NHLTeamGameLogs$IsBlowOut2 <- as.numeric(abs(NHLTeamGameLogs$DeltaQ1_Q2) > 3 & abs(NHLTeamGameLogs$DeltaTS) > 3)

# Create a new boolean column if the game meets 'Blow Outs' criteria (3)
NHLTeamGameLogs$IsBlowOut3 <- as.numeric(abs(NHLTeamGameLogs$DeltaTS) > 3)

colnames(NHLTeamGameLogs)
setDF(NHLTeamGameLogs)


# Check mutations
NHLTeamGameLogs[which(NHLTeamGameLogs$Overtime== 1),]
NHLTeamGameLogs[which(NHLTeamGameLogs$game_id == 'eeaf310f-c3a0-453f-9759-4e1aefc42215'),]

#Sub set by season
NHL_RegularSeason <- NHLTeamGameLogs[which(NHLTeamGameLogs$Type == 'RegularSeason'),]
NHL_Playoffs <- NHLTeamGameLogs[which(NHLTeamGameLogs$Type == 'Playoffs'),]

############## Results ###################

# Comebacks - Case 1
ComebacksInNHL_RegularSeason <- (sum(NHL_RegularSeason$IsComeback)/sum(as.numeric(NHL_RegularSeason$DeltaQ1_Q2 <= NHL_Threshold)))*100
ComebacksInNHL_Playoffs<- (sum(NHL_Playoffs$IsComeback)/sum(as.numeric(NHL_Playoffs$DeltaQ1_Q2 <= NHL_Threshold)))*100
# Results
ComebacksInNHL_RegularSeason
ComebacksInNHL_Playoffs

# Comebacks - Case 2
ComebacksInNHL_RegularSeason_2 <- (sum(NHL_RegularSeason$IsComeback2)/sum(as.numeric(NHL_RegularSeason$DeltaQ1 <= NHL_Threshold)))*100
ComebacksInNHL_Playoffs_2 <- (sum(NHL_Playoffs$IsComeback2)/sum(as.numeric(NHL_Playoffs$DeltaQ1 <= NHL_Threshold)))*100
# Results
ComebacksInNHL_RegularSeason_2
ComebacksInNHL_Playoffs_2

AVGComebackNHL <- (ComebacksInNHL_RegularSeason+ComebacksInNHL_Playoffs
                   +ComebacksInNHL_RegularSeason_2+ComebacksInNHL_Playoffs_2)/4

# Close Games - Case 1
CloseGamesInNHL_RegularSeason <- ((sum(NHL_RegularSeason$IsCloseGame)/2)/length(unique(NHL_RegularSeason$game_id)))*100
CloseGamesInNHL_Playoffs <- ((sum(NHL_Playoffs$IsCloseGame)/2)/length(unique(NHL_Playoffs$game_id)))*100
# Results
CloseGamesInNHL_RegularSeason
CloseGamesInNHL_Playoffs

# Close Games - Case 2
CloseGamesInNHL_RegularSeason_2 <- ((sum(NHL_RegularSeason$IsCloseGame2)/2)/length(unique(NHL_RegularSeason$game_id)))*100
CloseGamesInNHL_Playoffs_2 <- ((sum(NHL_Playoffs$IsCloseGame2)/2)/length(unique(NHL_Playoffs$game_id)))*100
# Results
CloseGamesInNHL_RegularSeason_2
CloseGamesInNHL_Playoffs_2

# Close Games - Case 3
CloseGamesInNHL_RegularSeason_3 <- ((sum(NHL_RegularSeason$IsCloseGame3)/2)/length(unique(NHL_RegularSeason$game_id)))*100
CloseGamesInNHL_Playoffs_3 <- ((sum(NHL_Playoffs$IsCloseGame3)/2)/length(unique(NHL_Playoffs$game_id)))*100
# Results
CloseGamesInNHL_RegularSeason_3
CloseGamesInNHL_Playoffs_3

AVGCloseGameNHL <- (CloseGamesInNHL_RegularSeason+CloseGamesInNHL_Playoffs
                    +CloseGamesInNHL_RegularSeason_2+CloseGamesInNHL_Playoffs_2
                    +CloseGamesInNHL_RegularSeason_3+CloseGamesInNHL_Playoffs_3)/6

# Blow Outs - Case 1
BlowOutsInNHL_RegularSeason <- ((sum(NHL_RegularSeason$IsBlowOut)/2)/length(unique(NHL_RegularSeason$game_id)))*100
BlowOutsInNHL_Playoffs <- ((sum(NHL_Playoffs$IsBlowOut)/2)/length(unique(NHL_Playoffs$game_id)))*100
# Results
BlowOutsInNHL_RegularSeason
BlowOutsInNHL_Playoffs

# Blow Outs - Case 2
BlowOutsInNHL_RegularSeason_2 <- ((sum(NHL_RegularSeason$IsBlowOut2)/2)/length(unique(NHL_RegularSeason$game_id)))*100
BlowOutsInNHL_Playoffs_2 <- ((sum(NHL_Playoffs$IsBlowOut2)/2)/length(unique(NHL_Playoffs$game_id)))*100
# Results
BlowOutsInNHL_RegularSeason_2
BlowOutsInNHL_Playoffs_2

# Blow Outs - Case 3
BlowOutsInNHL_RegularSeason_3 <- ((sum(NHL_RegularSeason$IsBlowOut3)/2)/length(unique(NHL_RegularSeason$game_id)))*100
BlowOutsInNHL_Playoffs_3 <- ((sum(NHL_Playoffs$IsBlowOut3)/2)/length(unique(NHL_Playoffs$game_id)))*100
# Results
BlowOutsInNHL_RegularSeason_3
BlowOutsInNHL_Playoffs_3

AVGBlowoutNHL <- (BlowOutsInNHL_RegularSeason+BlowOutsInNHL_Playoffs
                  +BlowOutsInNHL_RegularSeason_2+BlowOutsInNHL_Playoffs_2
                  +BlowOutsInNHL_RegularSeason_3+BlowOutsInNHL_Playoffs_3)/6

AVGComebackNHL
AVGCloseGameNHL
AVGBlowoutNHL

######################## Random Forest / Log Regression ################

## Rename Columns
colnames(NHLGames_Full_Data)[1] <- 'game_id' 

check <- aggregate(cbind(count = game_id) ~ game_id, 
                   data = NHLGames_Full_Data, 
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]

NHLGames <- NHLGames_Full_Data[c('game_id','attendance','away_team_outcome','home_team_outcome'
                                 ,'score_differential','scoreline','Season','Type')]

NHLTeamGameLogs_RF <- NHLTeamGameLogs[c('game_id','Type','Season','DeltaTotalFOWins','DeltaGoalieAssists','DeltaGoalieHits'                      
                                        , 'DeltaGoaliePenaltyMins','DeltaGoalieSaves','DeltaGoalieShotsAgainst','DeltaGoalieTOIPowerPlay_secs'        
                                        ,'DeltaGoalieTOI_secs','DeltaGoalieTOIShortHanded_secs','DeltaPenalties'                      
                                        ,'DeltaPenalty_mins','DeltaPlayerAssists' ,'DeltaPlayerBlockedShots'             
                                        ,'DeltaPlayerHits','DeltaPlayerPlusMinus','DeltaPlayerTOIPowerPlay_secs'        
                                        ,'DeltaPlayerTOIShortHanded_secs','DeltaPowerPlays','DeltaShots'                          
                                        ,'DeltaTeamSalary','IsCloseGame','IsCloseGame2','IsCloseGame3'
                                        , 'IsBlowOut', 'IsBlowOut2','IsBlowOut3')]

NHLTeamGameLogs_RF <- sqldf("SELECT DISTINCT * 
                            FROM NHLTeamGameLogs_RF")

NHLGameData_Models <- sqldf("SELECT A.game_id AS Game_Id,A.Type,A.Season, attendance AS Attendance, score_differential AS ScoreDifferential
                            , scoreline AS Scoreline,DeltaTotalFOWins,DeltaGoalieAssists,DeltaGoalieHits                      
                            , DeltaGoaliePenaltyMins,DeltaGoalieSaves,DeltaGoalieShotsAgainst
                            ,DeltaGoalieTOIPowerPlay_secs,DeltaGoalieTOI_secs,DeltaGoalieTOIShortHanded_secs,DeltaPenalties                      
                            ,DeltaPenalty_mins,DeltaPlayerAssists ,DeltaPlayerBlockedShots             
                            ,DeltaPlayerHits,DeltaPlayerPlusMinus,DeltaPlayerTOIPowerPlay_secs        
                            ,DeltaPlayerTOIShortHanded_secs,DeltaPowerPlays,DeltaShots                          
                            ,DeltaTeamSalary,IsCloseGame,IsCloseGame2,IsCloseGame3
                            , IsBlowOut, IsBlowOut2,IsBlowOut3
                            FROM NHLTeamGameLogs_RF A 
                            INNER JOIN NHLGames B
                            ON A.game_id = B.game_id")


################# CART model ###################
# Split the data
library(caTools)

# Install rpart library
library(rpart)
library(rpart.plot)

# ROC curve
library(ROCR)

### Close Games 

# Split Data
set.seed(3000)
spl = sample.split(NHLGameData_Models$IsCloseGame3, SplitRatio = 0.7)
Train = subset(NHLGameData_Models, spl==TRUE)
Test = subset(NHLGameData_Models, spl==FALSE)


NHL_Close_Games_Tree = rpart(IsCloseGame3 ~ DeltaTotalFOWins+DeltaGoalieAssists+DeltaGoalieHits                      
                             + DeltaGoaliePenaltyMins+DeltaGoalieSaves+DeltaGoalieShotsAgainst
                             +DeltaGoalieTOIPowerPlay_secs+DeltaGoalieTOI_secs+DeltaGoalieTOIShortHanded_secs+DeltaPenalties                      
                             +DeltaPenalty_mins +DeltaPlayerBlockedShots             
                             +DeltaPlayerHits+DeltaPlayerTOIPowerPlay_secs     
                             +DeltaPlayerTOIShortHanded_secs+DeltaPowerPlays+DeltaShots                          
                             +DeltaTeamSalary
                             , data = Train, method="class", minbucket=25)

prp(NHL_Close_Games_Tree)

png(
  "NHL_closegames_tree.png",
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
rpart.plot(NHL_Close_Games_Tree
           , uniform=TRUE, compress=TRUE
           , fallen=T, branch=1, round=0, cex.main=1
           , split.round=0
           , branch.lwd=.5, split.lwd=.5, nn.lwd=.5
           , main = "Classification Tree for Close Games in the NHL")
dev.off()

# Make predictions
PredictCART = predict(NHL_Close_Games_Tree, newdata = Test, type = "class")
table(Test$IsCloseGame3, PredictCART)
(264+136)/(264+136+234+155)

PredictROC = predict(NHL_Close_Games_Tree, newdata = Test)
PredictROC

pred = prediction(PredictROC[,2], Test$IsCloseGame3)
perf = performance(pred, "tpr", "fpr")
plot(perf)



################# Random Forests #########################

# Install randomForest package
library(randomForest)

# Close Games 

# Convert outcome to factor for classification model
Train$IsCloseGame3 = as.factor(Train$IsCloseGame3)
Test$IsCloseGame3 = as.factor(Test$IsCloseGame3)

# Try again
NHL_CloseGame_Forest = randomForest(IsCloseGame3 ~ DeltaTotalFOWins+DeltaGoalieAssists+DeltaGoalieHits                      
                                    + DeltaGoaliePenaltyMins+DeltaGoalieSaves+DeltaGoalieShotsAgainst
                                    +DeltaGoalieTOIPowerPlay_secs+DeltaGoalieTOI_secs+DeltaGoalieTOIShortHanded_secs+DeltaPenalties                      
                                    +DeltaPenalty_mins +DeltaPlayerBlockedShots             
                                    +DeltaPlayerHits+DeltaPlayerTOIPowerPlay_secs      
                                    +DeltaPlayerTOIShortHanded_secs+DeltaPowerPlays+DeltaShots                          
                                    +DeltaTeamSalary
                                    , data = Train, ntree=200, nodesize=25 )

# Make predictions
PredictForest = predict(NHL_CloseGame_Forest, newdata = Test)
table(Test$IsCloseGame3, PredictForest)
(301+176)/(301+176+194+118)



############## Logistic Regression Model #################

NHL_CloseGame_Log = glm(IsCloseGame3 ~ DeltaTotalFOWins+DeltaGoalieAssists+DeltaGoalieHits                      
                      + DeltaGoaliePenaltyMins+DeltaGoalieSaves+DeltaGoalieShotsAgainst
                      +DeltaGoalieTOIPowerPlay_secs+DeltaGoalieTOI_secs+DeltaGoalieTOIShortHanded_secs+DeltaPenalties                      
                      +DeltaPenalty_mins +DeltaPlayerBlockedShots             
                      +DeltaPlayerHits+DeltaPlayerTOIPowerPlay_secs     
                      +DeltaPlayerTOIShortHanded_secs+DeltaPowerPlays+DeltaShots                          
                      +DeltaTeamSalary
                      , data = Train, family=binomial)
summary(NHL_CloseGame_Log)

# Predictions on the test set
predictTest = predict(NHL_CloseGame_Log, type="response", newdata=Test)

# Confusion matrix with threshold of 0.5
table(Test$IsCloseGame3, predictTest > 0.5)

# Accuracy
(283+124)/(283+124+246+136)

# Baseline 
(269+150)/(269+127+243+150)

#Model is just barely worse than baseline. 


# Test set AUC 
library(ROCR)
ROCRpred = prediction(predictTest, Test$IsCloseGame3)
as.numeric(performance(ROCRpred, "auc")@y.values)

# And not good at differentiating. 

############## Feature Importance #############

# estimate variable importance
importance <- varImp(NHL_CloseGame_Forest, scale=FALSE)
# summarize importance
print(importance)











































