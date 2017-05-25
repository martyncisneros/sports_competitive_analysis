########## Pre-Analysis Set Up ############

## Load Packages
library(stattleshipR)  
library(sqldf)
library(dplyr)  

## Set Stattleship API Token
set_token('a9640e5acda75c174077be6390b05769')

########## Get Data from Stattleship API ###################

## Set Query Parameters

NBAseason17 <- list(status='ended', interval_type='regularseason',season_id='nba-2016-2017') 
NBAseason16 <- list(status='ended', interval_type='regularseason',season_id='nba-2015-2016') 
NBAPlayoffs17 <- list(status='ended', interval_type='postseason',season_id='nba-2016-2017') 
NBAPlayoffs16_cqf <- list(status='ended', interval_type='conferencequarterfinals',season_id='nba-2015-2016') 
NBAPlayoffs16_csf <- list(status='ended', interval_type='conferencesemifinals',season_id='nba-2015-2016') 
NBAPlayoffs16_cf <- list(status='ended', interval_type='conferencefinals',season_id='nba-2015-2016') 
NBAPlayoffs16_f <- list(status='ended', interval_type='nbachampionship',season_id='nba-2015-2016') 

#### Get Team Game Log Data

NBAteamgamelogs1 <- ss_get_result(sport='basketball', league='nba', ep='team_game_logs',
                          query=NBAseason17 , version=1, walk=TRUE, verbose=TRUE)
NBAteamgamelogs2 <- ss_get_result(sport='basketball', league='nba', ep='team_game_logs',
                          query=NBAseason16 , version=1, walk=TRUE, verbose=TRUE)
NBAteamgamelogs3 <- ss_get_result(sport='basketball', league='nba', ep='team_game_logs',
                              query=NBAPlayoffs17 , version=1, walk=TRUE, verbose=TRUE)
NBAteamgamelogs4 <- ss_get_result(sport='basketball', league='nba', ep='team_game_logs',
                              query=NBAPlayoffs16_cqf , version=1, walk=TRUE, verbose=TRUE)
NBAteamgamelogs5 <- ss_get_result(sport='basketball', league='nba', ep='team_game_logs',
                            query=NBAPlayoffs16_csf , version=1, walk=TRUE, verbose=TRUE)
NBAteamgamelogs6 <- ss_get_result(sport='basketball', league='nba', ep='team_game_logs',
                            query=NBAPlayoffs16_cf , version=1, walk=TRUE, verbose=TRUE)
NBAteamgamelogs7 <- ss_get_result(sport='basketball', league='nba', ep='team_game_logs',
                            query=NBAPlayoffs16_f , version=1, walk=TRUE, verbose=TRUE)

NBAteamgamelogs1 <- do.call('rbind',lapply(NBAteamgamelogs1, function(x) x$team_game_logs))
NBAteamgamelogs2 <- do.call('rbind',lapply(NBAteamgamelogs2, function(x) x$team_game_logs))
NBAteamgamelogs3 <- do.call('rbind',lapply(NBAteamgamelogs3, function(x) x$team_game_logs))
NBAteamgamelogs4 <- do.call('rbind',lapply(NBAteamgamelogs4, function(x) x$team_game_logs))
NBAteamgamelogs5 <- do.call('rbind',lapply(NBAteamgamelogs5, function(x) x$team_game_logs))
NBAteamgamelogs6 <- do.call('rbind',lapply(NBAteamgamelogs6, function(x) x$team_game_logs))
NBAteamgamelogs7 <- do.call('rbind',lapply(NBAteamgamelogs7, function(x) x$team_game_logs))

NBAteamgamelogs1$Season <- '2016-2017'
NBAteamgamelogs1$Type <- 'RegularSeason'
NBAteamgamelogs2$Season <- '2015-2016'
NBAteamgamelogs2$Type <- 'RegularSeason'
NBAteamgamelogs3$Season <- '2016-2017'
NBAteamgamelogs3$Type <- 'Playoffs'
NBAteamgamelogs4$Season <- '2015-2016'
NBAteamgamelogs4$Type <- 'Playoffs'
NBAteamgamelogs5$Season <- '2015-2016'
NBAteamgamelogs5$Type <- 'Playoffs'
NBAteamgamelogs6$Season <- '2015-2016'
NBAteamgamelogs6$Type <- 'Playoffs'
NBAteamgamelogs7$Season <- '2015-2016'
NBAteamgamelogs7$Type <- 'Playoffs'

NBATeamGameLogs_Full_Data <- rbind(NBAteamgamelogs1, NBAteamgamelogs2
                                   , NBAteamgamelogs3, NBAteamgamelogs4
                                   , NBAteamgamelogs5, NBAteamgamelogs6
                                   , NBAteamgamelogs7)

# Get Teams Data

NBAteams <- ss_get_result(sport='basketball', league='nba', ep='teams', version=1, walk=TRUE, verbose=TRUE)
NBAteams <-do.call('rbind', lapply(NBAteams, function(x) x$teams)) 

# Get Players Data

NBA_Players <- ss_get_result(sport='basketball', league='nba', ep='players', walk=TRUE)
NBA_Players <- do.call('rbind',lapply(NBA_Players, function(x) x$players))

# Get Roster Data

NBA_Rosters17 <- ss_get_result(sport='basketball', query=NBAseason17, league='nba', ep='rosters', walk=TRUE)
NBA_Rosters17 <- do.call('rbind',lapply(NBA_Rosters17, function(x) x$players))
NBA_Rosters17$Season <- '2016-2017'

##### Get Games Data

NBAgames1 <- ss_get_result(sport='basketball', league='nba', ep='games',
                           query=NBAseason17 , version=1, walk=TRUE, verbose=TRUE)
NBAgames2 <- ss_get_result(sport='basketball', league='nba', ep='games',
                           query=NBAseason16 , version=1, walk=TRUE, verbose=TRUE)
NBAgames3 <- ss_get_result(sport='basketball', league='nba', ep='games',
                           query=NBAPlayoffs17 , version=1, walk=TRUE, verbose=TRUE)
NBAgames4 <- ss_get_result(sport='basketball', league='nba', ep='games',
                           query=NBAPlayoffs16_cqf , version=1, walk=TRUE, verbose=TRUE)
NBAgames5 <- ss_get_result(sport='basketball', league='nba', ep='games',
                           query=NBAPlayoffs16_csf , version=1, walk=TRUE, verbose=TRUE)
NBAgames6 <- ss_get_result(sport='basketball', league='nba', ep='games',
                           query=NBAPlayoffs16_cf , version=1, walk=TRUE, verbose=TRUE)
NBAgames7 <- ss_get_result(sport='basketball', league='nba', ep='games',
                           query=NBAPlayoffs16_f , version=1, walk=TRUE, verbose=TRUE)

NBAgames1 <- do.call('rbind',lapply(NBAgames1, function(x) x$games))
NBAgames2 <- do.call('rbind',lapply(NBAgames2, function(x) x$games))
NBAgames3 <- do.call('rbind',lapply(NBAgames3, function(x) x$games))
NBAgames4 <- do.call('rbind',lapply(NBAgames4, function(x) x$games))
NBAgames5 <- do.call('rbind',lapply(NBAgames5, function(x) x$games))
NBAgames6 <- do.call('rbind',lapply(NBAgames6, function(x) x$games))
NBAgames7 <- do.call('rbind',lapply(NBAgames7, function(x) x$games))

NBAgames1$Season <- '2016-2017'
NBAgames1$Type <- 'RegularSeason'
NBAgames2$Season <- '2015-2016'
NBAgames2$Type <- 'RegularSeason'
NBAgames3$Season <- '2016-2017'
NBAgames3$Type <- 'Playoffs'
NBAgames4$Season <- '2015-2016'
NBAgames4$Type <- 'Playoffs'
NBAgames5$Season <- '2015-2016'
NBAgames5$Type <- 'Playoffs'
NBAgames6$Season <- '2015-2016'
NBAgames6$Type <- 'Playoffs'
NBAgames7$Season <- '2015-2016'
NBAgames7$Type <- 'Playoffs'

NBAGames_Full_Data <- rbind(NBAgames1,NBAgames2,NBAgames3, NBAgames4,NBAgames5,NBAgames6,NBAgames7)

############ Quick Data Exploration ##################

## Explore the Endpoints
str(NBATeamGameLogs_Full_Data)
colnames(NBATeamGameLogs_Full_Data)
dim(NBATeamGameLogs_Full_Data)

str(NBAteams)
dim(NBAteams)
colnames(NBAteams)  
sapply(NBAteams, class)


############## Data Cleaning ###################

### Handling missing data with MICE package

library(mice)

## Find all missing 

aggr_plot <- aggr(NBATeamGameLogs_Full_Data, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE
                  , labels=names(NBATeamGameLogs_Full_Data)
                  , cex.axis=.5, gap=1, ylab=c("Histogram of Missing MLB Data","Pattern"))

#Find all null columns: 
colnames(NBATeamGameLogs_Full_Data)[colSums(is.na(NBATeamGameLogs_Full_Data)) > 0]

## Rename Columns
NBAteams <- rename(NBAteams, teamname = name,
                   teamslug = slug)

colnames(NBAteams)[1] <- 'team_id' 

## Merge Team Game Logs with team info

NBATeamGameLogs_Full_Data <- merge(NBAteams, NBATeamGameLogs_Full_Data, by='team_id')  

################ Wins vs Salaries #####################

# Wins per Team

NBATeamGameLogs_Full_Data$Win <- as.numeric(NBATeamGameLogs_Full_Data$team_outcome == 'win')
Teams <- NBATeamGameLogs_Full_Data[c('team_id','teamname','teamslug','Type','Win')]
AVG_Win_Per_Season_NBA <- sqldf("SELECT team_id AS TeamId,teamname AS TeamName, teamslug AS Abbr, sum(Win)/2 AS Wins
                                FROM Teams
                                WHERE Type = 'RegularSeason'
                                GROUP BY team_id,teamname")
AVG_Win_Per_Season_NBA

# Salaries Per Team

colnames(NBA_Players)[1] <- 'player_id' 
colnames(NBA_Rosters17)[1] <- 'player_id' 

NBA_Players_DF <- NBA_Players[which(NBA_Players$active == 'TRUE'),]
NBA_Players_DF <- NBA_Players_DF[c('name','salary','humanized_salary','salary_currency','league_id','team_id','player_id')]
Team_Salary_NBA <- sqldf("SELECT A.team_id AS TeamId, sum(A.salary) AS TeamSalary, count(*) AS NumberofPlayers
                         FROM NBA_Players_DF A
                         INNER JOIN NBA_Rosters17 B
                            ON A.player_id = B.player_id AND A.team_id = B.team_id
                         GROUP BY A.team_id")

# Merge Dataframes

Wins_vs_Salary_NBA <- sqldf("SELECT A.TeamId, TeamName, Abbr, Wins, TeamSalary, NumberofPlayers
                            FROM AVG_Win_Per_Season_NBA A
                            INNER JOIN Team_Salary_NBA B
                            ON A.TeamId = B.TeamId")


## Merge Team Game Logs with team info

NBATeamGameLogs_Full_Data <- merge(x = NBATeamGameLogs_Full_Data, y = Team_Salary_NBA, by.x = "team_id", by.y = "TeamId", all.x = TRUE)

##################### Data Analysis #######################

## Checkpoint

NBATeamGameLogs <- NBATeamGameLogs_Full_Data[c(
        'game_id', 'team_id','Type','Season','teamname','is_home_team', 'Win', 'TeamSalary', 'NumberofPlayers'
        , 'assists_total', 'turnovers_total', 'assists_turnover_ratio', 'blocked_total', 'blocks_total'
        , 'personal_fouls', 'points_fast_break', 'points_in_paint', 'points_scored_off_turnovers'          
        , 'rebounds_defensive', 'rebounds_offensive', 'rebounds_total', 'steals_total'
        , 'field_goals_attempted', 'field_goals_made', 'field_goals_percentage' 
        , 'three_pointers_attempted', 'three_pointers_made', 'three_pointers_percentage'   
        , 'two_points_attempts', 'two_points_made','two_points_percentage'
        , 'free_throws_attempted', 'free_throws_made', 'free_throws_percentage'
        ,'points_quarter_1', 'points_quarter_2', 'points_quarter_3', 'points_quarter_4','points_scored_total')]


############## Data Mutations ###################

# Create new column with the points scored through all quarters
NBATeamGameLogs$points_quarter_1_to_4 <- NBATeamGameLogs$points_quarter_1 + NBATeamGameLogs$points_quarter_2 + NBATeamGameLogs$points_quarter_3 + NBATeamGameLogs$points_quarter_4
NBATeamGameLogs$points_quarter_1_to_3 <- NBATeamGameLogs$points_quarter_1 + NBATeamGameLogs$points_quarter_2 + NBATeamGameLogs$points_quarter_3
NBATeamGameLogs$points_quarter_1_to_2 <- NBATeamGameLogs$points_quarter_1 + NBATeamGameLogs$points_quarter_2 


# Make sure there are only two entries per game_id 
check <- aggregate(cbind(count = game_id) ~ game_id, 
                   data = NBATeamGameLogs, 
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]

############## Data Analysis ###################

# Utilize data.table's grouping math
dt_NBATeamGameLogs <- data.table(NBATeamGameLogs)

# Create new column with point difference through 1 quarter
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaQ1:=diff(points_quarter_1)*c(-1,1), by = game_id][]

# Create new column with point difference through 2 quarters
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaQ1_Q2:=diff(points_quarter_1_to_2)*c(-1,1), by = game_id][]

# Create new column with point difference through 3 quarters
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaQ1_Q3:=diff(points_quarter_1_to_3)*c(-1,1), by = game_id][]

# Create new column with point difference through 4 quarters
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaQ1_Q4:=diff(points_quarter_1_to_4)*c(-1,1), by = game_id][]

# Create new column with point difference at the end of the game
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaTS:=diff(points_scored_total)*c(-1,1), by = game_id][]  

# Create new column with differentials of various stats for random forest / regression 

NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaAssistTotal:=diff(assists_total)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaAssistTORatio:=diff(assists_turnover_ratio)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaBlockedTotal:=diff(blocked_total)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaBlocksTotal:=diff(blocks_total)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaFastBreakPts:=diff(points_fast_break)*c(-1,1), by = game_id][]
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaFGA:=diff(field_goals_attempted)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaFGM:=diff(field_goals_made)*c(-1,1), by = game_id][] 
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaFGPercent:=diff(field_goals_percentage)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaFTA:=diff(free_throws_attempted)*c(-1,1), by = game_id][] 
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaFTM:=diff(free_throws_made)*c(-1,1), by = game_id][]
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaFTPercent:=diff(free_throws_percentage)*c(-1,1), by = game_id][] 
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaPersFouls:=diff(personal_fouls)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaPaintPts:=diff(points_in_paint)*c(-1,1), by = game_id][] 
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaPtsOffTO:=diff(points_scored_off_turnovers)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaDrebs:=diff(rebounds_defensive)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaOrebs:=diff(rebounds_offensive)*c(-1,1), by = game_id][] 
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaTOTrebs:=diff(rebounds_total)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaTotalSteals:=diff(steals_total)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaTotalTO:=diff(turnovers_total)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaTotalTO:=diff(turnovers_total)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,Delta3PtA:=diff(three_pointers_attempted)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,Delta3PtM:=diff(three_pointers_made)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,Delta3PtPercent:=diff(three_pointers_percentage)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,Delta2PtA:=diff(two_points_attempts)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,Delta2PtM:=diff(two_points_made)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,Delta2PtPercent:=diff(two_points_percentage)*c(-1,1), by = game_id][]  
NBATeamGameLogs <- dt_NBATeamGameLogs[,DeltaTeamSalary:=diff(TeamSalary)*c(-1,1), by = game_id][]  

# Convert all new fields to absolute values

NBATeamGameLogs$DeltaAssistTotal <- abs(NBATeamGameLogs$DeltaAssistTotal)
NBATeamGameLogs$DeltaAssistTORatio <- abs(NBATeamGameLogs$DeltaAssistTORatio)
NBATeamGameLogs$DeltaBlockedTotal <- abs(NBATeamGameLogs$DeltaBlockedTotal)
NBATeamGameLogs$DeltaBlocksTotal <- abs(NBATeamGameLogs$DeltaBlocksTotal)
NBATeamGameLogs$DeltaFastBreakPts <- abs(NBATeamGameLogs$DeltaFastBreakPts)
NBATeamGameLogs$DeltaFGA <- abs(NBATeamGameLogs$DeltaFGA)
NBATeamGameLogs$DeltaFGM <- abs(NBATeamGameLogs$DeltaFGM)
NBATeamGameLogs$DeltaFGPercent <- abs(NBATeamGameLogs$DeltaFGPercent)
NBATeamGameLogs$DeltaFTA <- abs(NBATeamGameLogs$DeltaFTA)
NBATeamGameLogs$DeltaFTM <- abs(NBATeamGameLogs$DeltaFTM)
NBATeamGameLogs$DeltaFTPercent <- abs(NBATeamGameLogs$DeltaFTPercent)
NBATeamGameLogs$DeltaPersFouls <- abs(NBATeamGameLogs$DeltaPersFouls)
NBATeamGameLogs$DeltaPaintPts <- abs(NBATeamGameLogs$DeltaPaintPts)
NBATeamGameLogs$DeltaPtsOffTO <- abs(NBATeamGameLogs$DeltaPtsOffTO)
NBATeamGameLogs$DeltaDrebs <- abs(NBATeamGameLogs$DeltaDrebs)
NBATeamGameLogs$DeltaOrebs <- abs(NBATeamGameLogs$DeltaOrebs)
NBATeamGameLogs$DeltaTOTrebs <- abs(NBATeamGameLogs$DeltaTOTrebs)
NBATeamGameLogs$DeltaTotalSteals <- abs(NBATeamGameLogs$DeltaTotalSteals)
NBATeamGameLogs$DeltaTotalTO <- abs(NBATeamGameLogs$DeltaTotalTO)
NBATeamGameLogs$DeltaTotalTO <- abs(NBATeamGameLogs$DeltaTotalTO)
NBATeamGameLogs$Delta3PtA <- abs(NBATeamGameLogs$Delta3PtA)
NBATeamGameLogs$Delta3PtM <- abs(NBATeamGameLogs$Delta3PtM)
NBATeamGameLogs$Delta3PtPercent <- abs(NBATeamGameLogs$Delta3PtPercent)
NBATeamGameLogs$Delta2PtA <- abs(NBATeamGameLogs$Delta2PtA)
NBATeamGameLogs$Delta2PtM <- abs(NBATeamGameLogs$Delta2PtM)
NBATeamGameLogs$Delta2PtPercent <- abs(NBATeamGameLogs$Delta2PtPercent)
NBATeamGameLogs$DeltaTeamSalary <- abs(NBATeamGameLogs$DeltaTeamSalary)


# Threshold for comeback games

Losers <- NBATeamGameLogs[which(NBATeamGameLogs$DeltaTS < 1),]
Losers <- Losers$DeltaQ1_Q3

NBA_Threshold <- round(mean(Losers),0)

# Create a new boolean column if the game went to overtime
NBATeamGameLogs$Overtime <- as.numeric(NBATeamGameLogs$DeltaQ1_Q4 == 0)

# Create a new boolean column if the game meets 'Comeback' criteria
NBATeamGameLogs$IsComeback <- as.numeric(NBATeamGameLogs$DeltaQ1_Q3 <= NBA_Threshold & NBATeamGameLogs$DeltaTS > 1)

# Create a new boolean column if the game meets 'Comeback' criteria (2)
NBATeamGameLogs$IsComeback2 <- as.numeric(NBATeamGameLogs$DeltaQ1_Q2 <= NBA_Threshold & NBATeamGameLogs$DeltaTS > 1)

# Create a new boolean column if the game meets 'Close Game' criteria (1)
NBATeamGameLogs$IsCloseGame <- as.numeric(abs(NBATeamGameLogs$DeltaQ1) <= 4 & abs(NBATeamGameLogs$DeltaQ1_Q2) <= 4 
                                 & abs(NBATeamGameLogs$DeltaQ1_Q3) <= 4 & (abs(NBATeamGameLogs$DeltaTS) <= 4 | NBATeamGameLogs$Overtime == 1))

# Create a new boolean column if the game meets 'Close Game' criteria (2)
NBATeamGameLogs$IsCloseGame2 <- as.numeric(abs(NBATeamGameLogs$DeltaQ1_Q3) <= 4 & (abs(NBATeamGameLogs$DeltaTS) <= 4 | NBATeamGameLogs$Overtime == 1))

# Create a new boolean column if the game meets 'Close Game' criteria (3)
NBATeamGameLogs$IsCloseGame3 <- as.numeric(abs(NBATeamGameLogs$DeltaTS) <= 4 | NBATeamGameLogs$Overtime == 1)

# Create a new boolean column if the game meets 'Blowout' criteria (1)
NBATeamGameLogs$IsBlowOut <- as.numeric(abs(NBATeamGameLogs$DeltaQ1) > 12 & abs(NBATeamGameLogs$DeltaQ1_Q2) > 12 
                                     & abs(NBATeamGameLogs$DeltaQ1_Q3) > 12 & abs(NBATeamGameLogs$DeltaTS) > 12)

# Create a new boolean column if the game meets 'Blowout' criteria (2)
NBATeamGameLogs$IsBlowOut2 <- as.numeric(abs(NBATeamGameLogs$DeltaQ1_Q3) > 12 & abs(NBATeamGameLogs$DeltaTS) > 12)

# Create a new boolean column if the game meets 'Blowout' criteria (3)
NBATeamGameLogs$IsBlowOut3 <- as.numeric(abs(NBATeamGameLogs$DeltaTS) > 12)


colnames(NBATeamGameLogs)
setDF(NBATeamGameLogs)


# Check mutations
NBATeamGameLogs[which(NBATeamGameLogs$Overtime== 1),]
NBATeamGameLogs[which(NBATeamGameLogs$game_id == 'd5e466ea-e901-46b9-a87b-86f196cf7f5d'),]
NBATeamGameLogs[which(NBATeamGameLogs$IsCloseGame== 1),]
NBATeamGameLogs[which(NBATeamGameLogs$game_id == 'd3fc9bef-0e98-4745-81d3-4ca7aed6df7a'),]


#Sub set by season
NBA_RegularSeason <- NBATeamGameLogs[which(NBATeamGameLogs$Type == 'RegularSeason'),]
NBA_Playoffs <- NBATeamGameLogs[which(NBATeamGameLogs$Type == 'Playoffs'),]


############## Results ###################

# Comebacks - Case 1
ComebacksInNBA_RegularSeason <- (sum(NBA_RegularSeason$IsComeback)/sum(as.numeric(NBA_RegularSeason$DeltaQ1_Q3 <= NBA_Threshold)))*100
ComebacksInNBA_Playoffs<- (sum(NBA_Playoffs$IsComeback)/sum(as.numeric(NBA_Playoffs$DeltaQ1_Q3 <= NBA_Threshold)))*100
# Results
ComebacksInNBA_RegularSeason
ComebacksInNBA_Playoffs

# Comebacks - Case 2
ComebacksInNBA_RegularSeason_2 <- (sum(NBA_RegularSeason$IsComeback2)/sum(as.numeric(NBA_RegularSeason$DeltaQ1_Q2 <= NBA_Threshold)))*100
ComebacksInNBA_Playoffs_2 <- (sum(NBA_Playoffs$IsComeback2)/sum(as.numeric(NBA_Playoffs$DeltaQ1_Q2 <= NBA_Threshold)))*100
# Results
ComebacksInNBA_RegularSeason_2
ComebacksInNBA_Playoffs_2

AVGComebackNBA <- (ComebacksInNBA_RegularSeason+ComebacksInNBA_Playoffs
                    +ComebacksInNBA_RegularSeason_2+ComebacksInNBA_Playoffs_2)/4

# Close Games - Case 1
CloseGamesInNBA_RegularSeason <- ((sum(NBA_RegularSeason$IsCloseGame)/2)/length(unique(NBA_RegularSeason$game_id)))*100
CloseGamesInNBA_Playoffs <- ((sum(NBA_Playoffs$IsCloseGame)/2)/length(unique(NBA_Playoffs$game_id)))*100
# Results
CloseGamesInNBA_RegularSeason
CloseGamesInNBA_Playoffs

# Close Games - Case 2
CloseGamesInNBA_RegularSeason_2 <- ((sum(NBA_RegularSeason$IsCloseGame2)/2)/length(unique(NBA_RegularSeason$game_id)))*100
CloseGamesInNBA_Playoffs_2 <- ((sum(NBA_Playoffs$IsCloseGame2)/2)/length(unique(NBA_Playoffs$game_id)))*100
# Results
CloseGamesInNBA_RegularSeason_2
CloseGamesInNBA_Playoffs_2

# Close Games - Case 3
CloseGamesInNBA_RegularSeason_3 <- ((sum(NBA_RegularSeason$IsCloseGame3)/2)/length(unique(NBA_RegularSeason$game_id)))*100
CloseGamesInNBA_Playoffs_3 <- ((sum(NBA_Playoffs$IsCloseGame3)/2)/length(unique(NBA_Playoffs$game_id)))*100
# Results
CloseGamesInNBA_RegularSeason_3
CloseGamesInNBA_Playoffs_3


AVGCloseGameNBA <- (CloseGamesInNBA_RegularSeason+CloseGamesInNBA_Playoffs
                  +CloseGamesInNBA_RegularSeason_2+CloseGamesInNBA_Playoffs_2
                  +CloseGamesInNBA_RegularSeason_3+CloseGamesInNBA_Playoffs_3)/6


# Blow Outs - Case 1
BlowOutsInNBA_RegularSeason <- ((sum(NBA_RegularSeason$IsBlowOut)/2)/length(unique(NBA_RegularSeason$game_id)))*100
BlowOutsInNBA_Playoffs <- ((sum(NBA_Playoffs$IsBlowOut)/2)/length(unique(NBA_Playoffs$game_id)))*100
# Results
BlowOutsInNBA_RegularSeason
BlowOutsInNBA_Playoffs

# Blow Outs - Case 2
BlowOutsInNBA_RegularSeason_2 <- ((sum(NBA_RegularSeason$IsBlowOut2)/2)/length(unique(NBA_RegularSeason$game_id)))*100
BlowOutsInNBA_Playoffs_2 <- ((sum(NBA_Playoffs$IsBlowOut2)/2)/length(unique(NBA_Playoffs$game_id)))*100
# Results
BlowOutsInNBA_RegularSeason_2
BlowOutsInNBA_Playoffs_2

# Blow Outs - Case 3
BlowOutsInNBA_RegularSeason_3 <- ((sum(NBA_RegularSeason$IsBlowOut3)/2)/length(unique(NBA_RegularSeason$game_id)))*100
BlowOutsInNBA_Playoffs_3 <- ((sum(NBA_Playoffs$IsBlowOut3)/2)/length(unique(NBA_Playoffs$game_id)))*100
# Results
BlowOutsInNBA_RegularSeason_3
BlowOutsInNBA_Playoffs_3

AVGBlowoutNBA <- (BlowOutsInNBA_RegularSeason+BlowOutsInNBA_Playoffs
     +BlowOutsInNBA_RegularSeason_2+BlowOutsInNBA_Playoffs_2
     +BlowOutsInNBA_RegularSeason_3+BlowOutsInNBA_Playoffs_3)/6

AVGComebackNBA
AVGCloseGameNBA
AVGBlowoutNBA

######################## Random Forest / Log Regression ################

## Rename Columns
colnames(NBAGames_Full_Data)[1] <- 'game_id' 

check <- aggregate(cbind(count = game_id) ~ game_id, 
                   data = NBAGames_Full_Data, 
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]

NBAGames <- NBAGames_Full_Data[c('game_id','attendance','away_team_outcome','home_team_outcome'
                                 ,'score_differential','scoreline','Season','Type')]

NBATeamGameLogs_RF <- NBATeamGameLogs[c('game_id','Type','Season'
                                        , 'DeltaAssistTotal', 'DeltaAssistTORatio','DeltaBlockedTotal', 'DeltaBlocksTotal'
                                        ,'DeltaFastBreakPts', 'DeltaFGA', 'DeltaFGM', 'DeltaFGPercent', 'DeltaFTA', 'DeltaFTM'
                                        ,'DeltaFTPercent', 'DeltaPersFouls', 'DeltaPaintPts','DeltaPtsOffTO', 'DeltaDrebs'
                                        , 'DeltaOrebs','DeltaTOTrebs','DeltaTotalSteals','DeltaTotalTO','Delta3PtA','Delta3PtM'
                                        , 'Delta3PtPercent','Delta2PtA','Delta2PtM','Delta2PtPercent','DeltaTeamSalary'
                                        ,'IsCloseGame','IsCloseGame2','IsCloseGame3', 'IsBlowOut', 'IsBlowOut2','IsBlowOut3')]

NBATeamGameLogs_RF <- sqldf("SELECT DISTINCT * 
                            FROM NBATeamGameLogs_RF")

NBAGameData_Models <- sqldf("SELECT A.game_id AS Game_Id,A.Type,A.Season, attendance AS Attendance, score_differential AS ScoreDifferential
                              , scoreline AS Scoreline, DeltaAssistTotal, DeltaAssistTORatio,DeltaBlockedTotal, DeltaBlocksTotal
                                        ,DeltaFastBreakPts, DeltaFGA, DeltaFGM, DeltaFGPercent, DeltaFTA, DeltaFTM
                                        ,DeltaFTPercent, DeltaPersFouls, DeltaPaintPts,DeltaPtsOffTO, DeltaDrebs
                                        , DeltaOrebs,DeltaTOTrebs,DeltaTotalSteals,DeltaTotalTO,Delta3PtA,Delta3PtM
                                        , Delta3PtPercent,Delta2PtA,Delta2PtM,Delta2PtPercent,DeltaTeamSalary
                                        ,IsCloseGame,IsCloseGame2,IsCloseGame3, IsBlowOut, IsBlowOut2,IsBlowOut3
                            FROM NBATeamGameLogs_RF A 
                            INNER JOIN NBAGames B
                              ON A.game_id = B.game_id")


################# CART model ###################
# Split the data
library(caTools)

# Install rpart library
library(rpart)
library(rpart.plot)

# ROC curve
library(ROCR)

### Blow Outs

# Split Data
set.seed(3000)
spl = sample.split(NBAGameData_Models$IsBlowOut3, SplitRatio = 0.7)
Train = subset(NBAGameData_Models, spl==TRUE)
Test = subset(NBAGameData_Models, spl==FALSE)

NBA_Blow_Outs_Tree = rpart(IsBlowOut3 ~ DeltaAssistTotal+DeltaAssistTORatio+DeltaBlockedTotal+DeltaBlocksTotal
                           +DeltaFastBreakPts+DeltaFGA+DeltaFTA+DeltaPersFouls+DeltaPaintPts+DeltaPtsOffTO+DeltaDrebs
                           + DeltaOrebs+DeltaTOTrebs+DeltaTotalSteals+DeltaTotalTO+Delta3PtA
                           +Delta2PtA+DeltaTeamSalary
                           +Delta2PtPercent+Delta3PtPercent+DeltaFGPercent+DeltaFTPercent
                           , data = Train, method="class", minbucket=25)

prp(NBA_Blow_Outs_Tree)

png(
  "NBA_blowouts_tree.png",
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
rpart.plot(NBA_Blow_Outs_Tree
           , uniform=TRUE, compress=TRUE
           , fallen=T, branch=1, round=0, cex.main=1
           , split.round=0
           , branch.lwd=.5, split.lwd=.5, nn.lwd=.5
           , main = "Classification Tree for Blowouts in the NBA")
dev.off()


# Make predictions
PredictCART = predict(NBA_Blow_Outs_Tree, newdata = Test, type = "class")
table(Test$IsBlowOut3, PredictCART)
(454+134)/(454+147+50+134)

PredictROC = predict(NBA_Blow_Outs_Tree, newdata = Test)
PredictROC

pred = prediction(PredictROC[,2], Test$IsBlowOut3)
perf = performance(pred, "tpr", "fpr")
plot(perf)

#cross validation

library(caret)
install.packages("e1071")
library(e1071)

numFolds = trainControl(method="cv",number=10)
cpGrid = expand.grid(.cp=seq(0.01,0.5,0.01))
train(IsBlowOut3 ~ DeltaAssistTotal+DeltaAssistTORatio+DeltaBlockedTotal+DeltaBlocksTotal
      +DeltaFastBreakPts+DeltaFGA+DeltaFTA+DeltaPersFouls+DeltaPaintPts+DeltaPtsOffTO+DeltaDrebs
      + DeltaOrebs+DeltaTOTrebs+DeltaTotalSteals+DeltaTotalTO+Delta3PtA
      +Delta2PtA+DeltaTeamSalary
      +Delta2PtPercent+Delta3PtPercent+DeltaFGPercent+DeltaFTPercent
      , data = Train, method="rpart", trControl=numFolds, tuneGrid=cpGrid)

NBA_Blow_Outs_Tree_V2 = rpart(IsBlowOut3 ~ DeltaAssistTotal+DeltaAssistTORatio+DeltaBlockedTotal+DeltaBlocksTotal
                           +DeltaFastBreakPts+DeltaFGA+DeltaFTA+DeltaPersFouls+DeltaPaintPts+DeltaPtsOffTO+DeltaDrebs
                           + DeltaOrebs+DeltaTOTrebs+DeltaTotalSteals+DeltaTotalTO+Delta3PtA
                           +Delta2PtA+DeltaTeamSalary
                           +Delta2PtPercent+Delta3PtPercent+DeltaFGPercent+DeltaFTPercent
                           , data = Train, method="class", cp=0.01)

Predict_V2 = predict(NBA_Blow_Outs_Tree_V2, newdata = Test, type = "class")
table(Test$IsBlowOut3, Predict_V2)
(454+135)/(454+135+146+50)

################# Random Forests #########################

# Install randomForest package
library(randomForest)

# Blow Outs

# Convert outcome to factor for classification model
Train$IsBlowOut3 = as.factor(Train$IsBlowOut3)
Test$IsBlowOut3 = as.factor(Test$IsBlowOut3)

# Try again
NBA_Blowout_Forest = randomForest(IsBlowOut3 ~ DeltaAssistTotal+DeltaAssistTORatio+DeltaBlockedTotal+DeltaBlocksTotal
                                  +DeltaFastBreakPts+DeltaFGA+DeltaFTA+DeltaPersFouls+DeltaPaintPts+DeltaPtsOffTO+DeltaDrebs
                                  + DeltaOrebs+DeltaTOTrebs+DeltaTotalSteals+DeltaTotalTO+Delta3PtA
                                  +Delta2PtA+DeltaTeamSalary
                                  +Delta2PtPercent+Delta3PtPercent+DeltaFGPercent+DeltaFTPercent
                                  , data = Train, ntree=200, nodesize=25 )

# Make predictions
PredictForest = predict(NBA_Blowout_Forest, newdata = Test)
table(Test$IsBlowOut3, PredictForest)
(465+143)/(465+143+138+39)



############## Logistic Regression Model #################

NBA_BlowOut_Log = glm(IsBlowOut3 ~ DeltaAssistTotal+DeltaAssistTORatio+DeltaBlockedTotal+DeltaBlocksTotal
                      +DeltaFastBreakPts+DeltaFGA+DeltaFTA+DeltaPersFouls+DeltaPaintPts+DeltaPtsOffTO+DeltaDrebs
                      + DeltaOrebs+DeltaTOTrebs+DeltaTotalSteals+DeltaTotalTO+Delta3PtA
                      +Delta2PtA+DeltaTeamSalary
                      +Delta2PtPercent+Delta3PtPercent+DeltaFGPercent+DeltaFTPercent
                      , data = Train, family=binomial)
summary(NBA_BlowOut_Log)

# Predictions on the test set
predictTest = predict(NBA_BlowOut_Log, type="response", newdata=Test)

# Confusion matrix with threshold of 0.5
table(Test$IsBlowOut3, predictTest > 0.5)

# Model Accuracy
(452+154)/(452+154+127+52)

# Baseline Accuracy 
(452+52)/(452+154+127+52)

#So the accuracy of the model was better than baseline. 

# Test set AUC 
library(ROCR)
ROCRpred = prediction(predictTest, Test$IsBlowOut3)
as.numeric(performance(ROCRpred, "auc")@y.values)

# The model could differentiate between blowouts and non-blowouts pretty well 
# with an out-of-sample AUC of 0.80.


############## Feature Importance #############
library(caret)

# estimate variable importance
importance <- varImp(NBA_Blowout_Forest, scale=FALSE)
# summarize importance
print(importance)






