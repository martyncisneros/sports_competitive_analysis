########## Pre-Analysis Set Up ############

## Load Packages
library(stattleshipR)  
library(sqldf)
library(dplyr)  

## Set Stattleship API Token
set_token('a9640e5acda75c174077be6390b05769')

########## Get Data from Stattleship API ###################

## Set Query Parameters

MLBseason16 <- list(status='ended', interval_type='regularseason',season_id='mlb-2016') 
MLBseason15 <- list(status='ended', interval_type='regularseason',season_id='mlb-2015') 
MLBPlayoffs16_1 <- list(status='ended', interval_type='postseason',season_id='mlb-2016') 
MLBPlayoffs15_wcs <- list(status='ended', interval_type='wildcardshowdown',season_id='mlb-2015') 
MLBPlayoffs15_dp <- list(status='ended', interval_type='divisionalplayoff',season_id='mlb-2015') 
MLBPlayoffs15_lc <- list(status='ended', interval_type='leaguechampionship',season_id='mlb-2015') 
MLBPlayoffs15_ws <- list(status='ended', interval_type='worldseries',season_id='mlb-2015') 


MLBteamgamelogs1 <- ss_get_result(sport='baseball', league='MLB', ep='team_game_logs',
                          query=MLBseason16 , version=1, walk=TRUE, verbose=TRUE)
MLBteamgamelogs2 <- ss_get_result(sport='baseball', league='MLB', ep='team_game_logs',
                          query=MLBseason15 , version=1, walk=TRUE, verbose=TRUE)
MLBteamgamelogs3 <- ss_get_result(sport='baseball', league='MLB', ep='team_game_logs',
                               query=MLBPlayoffs16_1 , version=1, walk=TRUE, verbose=TRUE)
MLBteamgamelogs4 <- ss_get_result(sport='baseball', league='MLB', ep='team_game_logs',
                                 query=MLBPlayoffs15_wcs , version=1, walk=TRUE, verbose=TRUE)
MLBteamgamelogs5 <- ss_get_result(sport='baseball', league='MLB', ep='team_game_logs',
                                 query=MLBPlayoffs15_dp , version=1, walk=TRUE, verbose=TRUE)
MLBteamgamelogs6 <- ss_get_result(sport='baseball', league='MLB', ep='team_game_logs',
                                 query=MLBPlayoffs15_lc , version=1, walk=TRUE, verbose=TRUE)
MLBteamgamelogs7 <- ss_get_result(sport='baseball', league='MLB', ep='team_game_logs',
                                 query=MLBPlayoffs15_ws , version=1, walk=TRUE, verbose=TRUE)


MLBteamgamelogs1 <- do.call('rbind',lapply(MLBteamgamelogs1, function(x) x$team_game_logs))
MLBteamgamelogs2 <- do.call('rbind',lapply(MLBteamgamelogs2, function(x) x$team_game_logs))
MLBteamgamelogs3 <- do.call('rbind',lapply(MLBteamgamelogs3, function(x) x$team_game_logs))
MLBteamgamelogs4 <- do.call('rbind',lapply(MLBteamgamelogs4, function(x) x$team_game_logs))
MLBteamgamelogs5 <- do.call('rbind',lapply(MLBteamgamelogs5, function(x) x$team_game_logs))
MLBteamgamelogs6 <- do.call('rbind',lapply(MLBteamgamelogs6, function(x) x$team_game_logs))
MLBteamgamelogs7 <- do.call('rbind',lapply(MLBteamgamelogs7, function(x) x$team_game_logs))

MLBteamgamelogs1$Season <- '2016'
MLBteamgamelogs1$Type <- 'RegularSeason'
MLBteamgamelogs2$Season <- '2015'
MLBteamgamelogs2$Type <- 'RegularSeason'
MLBteamgamelogs3$Season <- '2016'
MLBteamgamelogs3$Type <- 'Playoffs'
MLBteamgamelogs4$Season <- '2015'
MLBteamgamelogs4$Type <- 'Playoffs'
MLBteamgamelogs5$Season <- '2015'
MLBteamgamelogs5$Type <- 'Playoffs'
MLBteamgamelogs6$Season <- '2015'
MLBteamgamelogs6$Type <- 'Playoffs'
MLBteamgamelogs7$Season <- '2015'
MLBteamgamelogs7$Type <- 'Playoffs'

MLBTeamGameLogs_Full_Data <- rbind(MLBteamgamelogs1, MLBteamgamelogs2
                                   , MLBteamgamelogs3, MLBteamgamelogs4
                                   , MLBteamgamelogs5, MLBteamgamelogs6
                                   , MLBteamgamelogs7)

# Get Teams Data

MLBteams <- ss_get_result(sport='baseball', league='MLB', ep='teams', version=1, walk=TRUE, verbose=TRUE)
MLBteams <-do.call('rbind', lapply(MLBteams, function(x) x$teams)) 

# Get Players Data

MLB_Players <- ss_get_result(sport='baseball', league='MLB', ep='players', walk=TRUE)
MLB_Players <- do.call('rbind',lapply(MLB_Players, function(x) x$players))

# Get Roster Data

MLB_Rosters16 <- ss_get_result(sport='baseball', query=MLBseason16, league='MLB', ep='rosters', walk=TRUE)
MLB_Rosters16 <- do.call('rbind',lapply(MLB_Rosters16, function(x) x$players))
MLB_Rosters16$Season <- '2016'

# MLB Games

MLBgames1 <- ss_get_result(sport='baseball', league='MLB', ep='games',query=MLBseason16, walk=TRUE)
MLBgames2 <- ss_get_result(sport='baseball', league='MLB', ep='games',query=MLBseason15, walk=TRUE)
MLBgames3 <- ss_get_result(sport='baseball', league='MLB', ep='games',query=MLBPlayoffs16_1, walk=TRUE)
MLBgames4 <- ss_get_result(sport='baseball', league='MLB', ep='games',query=MLBPlayoffs15_wcs, walk=TRUE)
MLBgames5 <- ss_get_result(sport='baseball', league='MLB', ep='games',query=MLBPlayoffs15_dp, walk=TRUE)
MLBgames6 <- ss_get_result(sport='baseball', league='MLB', ep='games',query=MLBPlayoffs15_lc, walk=TRUE)
MLBgames7 <- ss_get_result(sport='baseball', league='MLB', ep='games',query=MLBPlayoffs15_ws, walk=TRUE)

MLBgames1 <- do.call('rbind',lapply(MLBgames1, function(x) x$games))
MLBgames2 <- do.call('rbind',lapply(MLBgames2, function(x) x$games))
MLBgames3 <- do.call('rbind',lapply(MLBgames3, function(x) x$games))
MLBgames4 <- do.call('rbind',lapply(MLBgames4, function(x) x$games))
MLBgames5 <- do.call('rbind',lapply(MLBgames5, function(x) x$games))
MLBgames6 <- do.call('rbind',lapply(MLBgames6, function(x) x$games))
MLBgames7 <- do.call('rbind',lapply(MLBgames7, function(x) x$games))

MLBgames1$Season <- '2016'
MLBgames1$Type <- 'RegularSeason'
MLBgames2$Season <- '2015'
MLBgames2$Type <- 'RegularSeason'
MLBgames3$Season <- '2016'
MLBgames3$Type <- 'Playoffs'
MLBgames4$Season <- '2015'
MLBgames4$Type <- 'Playoffs'
MLBgames5$Season <- '2015'
MLBgames5$Type <- 'Playoffs'
MLBgames6$Season <- '2015'
MLBgames6$Type <- 'Playoffs'
MLBgames7$Season <- '2015'
MLBgames7$Type <- 'Playoffs'

MLBGames_Full_Data <- rbind(MLBgames1,MLBgames2,MLBgames3,MLBgames4,MLBgames5,MLBgames6,MLBgames7)

############ Quick Data Exploration ##################

## Explore the Endpoints
str(MLBTeamGameLogs_Full_Data)
colnames(MLBTeamGameLogs_Full_Data)
dim(MLBTeamGameLogs_Full_Data)

str(MLBteams)
dim(MLBteams)
colnames(MLBteams)  
sapply(MLBteams, class)

############## Data Cleaning ###################

### Handling missing data with MICE package

library(mice)

## Find all missing 

aggr_plot <- aggr(MLBTeamGameLogs_Full_Data, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE
                  , labels=names(MLBTeamGameLogs_Full_Data)
                  , cex.axis=.5, gap=1, ylab=c("Histogram of Missing MLB Data","Pattern"))

#Find all null columns: 
colnames(MLBTeamGameLogs_Full_Data)[colSums(is.na(MLBTeamGameLogs_Full_Data)) == 0]

pMiss <- function(x){sum(is.na(x))/length(x)*100}
apply(MLBTeamGameLogs_Full_Data,2,pMiss)

summary(MLBTeamGameLogs_Full_Data)
str(MLBTeamGameLogs_Full_Data)

## Null Value imputing via MICE

init = mice(MLBTeamGameLogs_Full_Data, maxit=0) 
meth = init$method
predM = init$predictorMatrix

## Removing these variables from predictors
predM[, c("id", "created_at", "updated_at", "game_id", "home_team_outcome", "home_team_score", "team_outcome"
          , "opponent_id", "team_id", "Season", "Type", "away_team_outcome", "away_team_score", "team_score"
              , "opponent_outcome", "is_home_team", "is_away_team" )]=0

## Removing these variables from imputation (greater than 7%)
meth[c("team_left_on_base","two_out_left_on_base","balks")]=""

## To be imputed via normal method for nummerical variables
meth[c("at_bats","batting_average","caught_stealing","complete_games","double_plays","doubles"
       , "earned_run_average","earned_runs_against","games_lost","games_won","grounded_into_double_plays"
       , "hit_batters","hit_by_pitch","hits","home_runs","intentional_walks","intentional_walks_against"  
       , "left_on_base","on_base_percentage","on_base_plus_slugging","outs_pitched","passed_balls"
       ,"runs_batted_in","sacrifice_flys", "sacrifice_hits","saves","shutouts","slugging_percentage"
       ,"stolen_bases","total_bases","triple_plays","triples","walks","whip","wild_pitches")]="norm" 

set.seed(103)
imputed = mice(MLBTeamGameLogs_Full_Data, method=meth, predictorMatrix=predM, m=5)
MLBTeamGameLogs_Full_Data_imputed <- complete(imputed)

# Check results 
sapply(MLBTeamGameLogs_Full_Data_imputed, function(x) sum(is.na(x)))

## Rename Columns
MLBteams <- rename(MLBteams, teamname = name,
                   teamslug = slug)

colnames(MLBteams)[1] <- 'team_id' 

## Merge Team Game Logs with team info

MLBTeamGameLogs_Full_Data_imputed <- merge(MLBteams, MLBTeamGameLogs_Full_Data_imputed, by='team_id')  

################ Wins vs Salaries #####################

# Wins per Team

MLBTeamGameLogs_Full_Data_imputed$Win <- as.numeric(MLBTeamGameLogs_Full_Data_imputed$team_outcome == 'win')
Teams <- MLBTeamGameLogs_Full_Data_imputed[c('team_id','teamname','teamslug','Type','Win')]
AVG_Win_Per_Season_MLB <- sqldf("SELECT team_id AS TeamId,teamname AS TeamName, teamslug AS Abbr, sum(Win)/2 AS Wins
                                FROM Teams
                                WHERE Type = 'RegularSeason'
                                GROUP BY team_id,teamname")
AVG_Win_Per_Season_MLB

# Salaries Per Team

colnames(MLB_Players)[1] <- 'player_id' 
colnames(MLB_Rosters16)[1] <- 'player_id' 


MLB_Players_DF <- MLB_Players[which(MLB_Players$active == 'TRUE'),]
MLB_Players_DF <- MLB_Players_DF[c('name','salary','humanized_salary','salary_currency','league_id','team_id','player_id')]
Team_Salary_MLB <- sqldf("SELECT A.team_id AS TeamId, sum(A.salary) AS TeamSalary, count(*) AS NumberofPlayers
                         FROM MLB_Players_DF A
                         INNER JOIN MLB_Rosters16 B
                         ON A.player_id = B.player_id AND A.team_id = B.team_id
                         GROUP BY A.team_id")

# Merge Dataframes

Wins_vs_Salary_MLB <- sqldf("SELECT A.TeamId, TeamName, Abbr, Wins, TeamSalary, NumberofPlayers
                            FROM AVG_Win_Per_Season_MLB A
                            INNER JOIN Team_Salary_MLB B
                            ON A.TeamId = B.TeamId")

## Merge Team Game Logs with team info

MLBTeamGameLogs_Full_Data_imputed <- merge(x = MLBTeamGameLogs_Full_Data_imputed, y = Team_Salary_MLB, by.x = "team_id", by.y = "TeamId", all.x = TRUE)

##################### Data Analysis #######################

## Checkpoint

MLBTeamGameLogs <- MLBTeamGameLogs_Full_Data_imputed[c('game_id','team_id','Type','Season','teamname','is_home_team','is_away_team', 'Win', 'TeamSalary', 'NumberofPlayers'
                                               ,'at_bats', 'batting_average','caught_stealing','double_plays','doubles'                       
                                               ,'errors_made','grounded_into_double_plays' ,'hits','intentional_walks','intentional_walks_against' 
                                               ,'left_on_base','on_base_percentage','on_base_plus_slugging','outs_pitched','passed_balls','pickoffs'                   
                                               ,'rlisp_two_out','sacrifice_flys','sacrifice_hits','slugging_percentage','stolen_bases','strikeouts'                 
                                               ,'total_bases','triple_plays','triples'                    
                                               ,'walks','whip','wild_pitches'            
                                               ,'runs_inning_1', 'runs_inning_2', 'runs_inning_3', 'runs_inning_4'
                                               ,'runs_inning_5', 'runs_inning_6','runs_inning_7','runs_inning_8','runs_inning_9','runs')]
  

## double check there are no more null columns
#Find all null columns: 
colnames(MLBTeamGameLogs)[colSums(is.na(MLBTeamGameLogs)) > 0]
sapply(MLBTeamGameLogs, function(x) sum(is.na(x)))
  
# Make sure there are only two entries per game_id 
check <- aggregate(cbind(count = game_id) ~ game_id, 
                   data = MLBTeamGameLogs, 
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]

# There appear to be several incorrect entries for game_ids
# Clean-up will entail merging to games endpoint and also joining on home and away team ids
# Removing duplicate entries
# And Removing null entries of 0 values

MLBTeamGameLogs$home_team_id <- ifelse(MLBTeamGameLogs$is_home_team == "TRUE", MLBTeamGameLogs$team_id, "NULL")
MLBTeamGameLogs$away_team_id <- ifelse(MLBTeamGameLogs$is_away_team == "TRUE", MLBTeamGameLogs$team_id, "NULL")

## Rename Columns
colnames(MLBGames_Full_Data)[1] <- 'game_id' 

## Merge Team Game Logs with Games Data using a Two-Point Match on Home / Away Team Ids

MLBGames <- MLBGames_Full_Data[c('game_id', 'home_team_id', 'away_team_id'
                                 ,'season_id', 'title')]

MLBTeamGameLogs <- sqldf("SELECT DISTINCT A.*
                    FROM MLBTeamGameLogs as A
                    INNER JOIN MLBGames as B
                        ON A.game_id = B.game_id AND 
                    (A.home_team_id = B.home_team_id OR A.away_team_id = B.away_team_id)")

# Make sure there are only two entries per game_id
check <- aggregate(cbind(count = game_id) ~ game_id,
                   data = MLBTeamGameLogs,
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]

#Manually clean those with discrepancy (erroenous null entries)

# Clean up final discrpancies
MLBTeamGameLogs <-MLBTeamGameLogs[!(MLBTeamGameLogs$runs=="0" &
                            (MLBTeamGameLogs$game_id == '2dea514b-4da7-4880-8bce-e49fb9e3bda8'
                             | MLBTeamGameLogs$game_id == '79a9566e-78ad-4ab4-9ed4-48f3c370b8cc'
                             | MLBTeamGameLogs$game_id == '8b3cbf53-db1b-46c2-8236-b0b4e10169b2'
                             | MLBTeamGameLogs$game_id == '8e9eb718-e285-4af9-9b5f-37e6e7507bca'
                             | MLBTeamGameLogs$game_id == '96e1850e-55f0-4b5d-839a-6dbb38ff775c'
                             | MLBTeamGameLogs$game_id == 'b051205d-fa1a-4fcf-9636-28edcbc68c6a'
                             | MLBTeamGameLogs$game_id == 'b3951e09-1799-4749-8319-11e57c1b49c3'
                             | MLBTeamGameLogs$game_id == 'f16633d2-0d27-4b03-a56a-43dc197fbaf5'
                             | MLBTeamGameLogs$game_id == 'f7a1e1b0-7ae8-4f2b-a12c-662bbff3c2b6'
                            )),]

check <- aggregate(cbind(count = game_id) ~ game_id,
                   data = MLBTeamGameLogs,
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]

# Clean up final discrpancies
MLBTeamGameLogs <-MLBTeamGameLogs[!(MLBTeamGameLogs$game_id == '1498fae4-98d7-403c-b230-f2fcd875cd86'
                                       | MLBTeamGameLogs$game_id == 'b8b86a04-ce3c-4466-aa08-8382ebffa56c'
                                       | MLBTeamGameLogs$game_id == 'd476c691-ebe3-4264-9a74-47a17947db42'
                                      ),]

check <- aggregate(cbind(count = game_id) ~ game_id,
                   data = MLBTeamGameLogs,
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]


############## Data Mutations ###################

# Create new column with the points scored through all innings
MLBTeamGameLogs$runs_inning_1_to_9 <- MLBTeamGameLogs$runs_inning_1 + MLBTeamGameLogs$runs_inning_2 + MLBTeamGameLogs$runs_inning_3 + 
  MLBTeamGameLogs$runs_inning_4 + MLBTeamGameLogs$runs_inning_5 + MLBTeamGameLogs$runs_inning_6 + MLBTeamGameLogs$runs_inning_7 + MLBTeamGameLogs$runs_inning_8 + MLBTeamGameLogs$runs_inning_9
MLBTeamGameLogs$runs_inning_1_to_8 <- MLBTeamGameLogs$runs_inning_1 + MLBTeamGameLogs$runs_inning_2 + MLBTeamGameLogs$runs_inning_3 + 
  MLBTeamGameLogs$runs_inning_4 + MLBTeamGameLogs$runs_inning_5 + MLBTeamGameLogs$runs_inning_6 + MLBTeamGameLogs$runs_inning_7 + MLBTeamGameLogs$runs_inning_8
MLBTeamGameLogs$runs_inning_1_to_7 <- MLBTeamGameLogs$runs_inning_1 + MLBTeamGameLogs$runs_inning_2 + MLBTeamGameLogs$runs_inning_3 + 
  MLBTeamGameLogs$runs_inning_4 + MLBTeamGameLogs$runs_inning_5 + MLBTeamGameLogs$runs_inning_6 + MLBTeamGameLogs$runs_inning_7
MLBTeamGameLogs$runs_inning_1_to_6 <- MLBTeamGameLogs$runs_inning_1 + MLBTeamGameLogs$runs_inning_2 + MLBTeamGameLogs$runs_inning_3 + 
  MLBTeamGameLogs$runs_inning_4 + MLBTeamGameLogs$runs_inning_5 + MLBTeamGameLogs$runs_inning_6
MLBTeamGameLogs$runs_inning_1_to_5 <- MLBTeamGameLogs$runs_inning_1 + MLBTeamGameLogs$runs_inning_2 + MLBTeamGameLogs$runs_inning_3 + 
  MLBTeamGameLogs$runs_inning_4 + MLBTeamGameLogs$runs_inning_5
MLBTeamGameLogs$runs_inning_1_to_4 <- MLBTeamGameLogs$runs_inning_1 + MLBTeamGameLogs$runs_inning_2 + MLBTeamGameLogs$runs_inning_3 + 
  MLBTeamGameLogs$runs_inning_4 
MLBTeamGameLogs$runs_inning_1_to_3 <- MLBTeamGameLogs$runs_inning_1 + MLBTeamGameLogs$runs_inning_2 + MLBTeamGameLogs$runs_inning_3
MLBTeamGameLogs$runs_inning_1_to_2 <- MLBTeamGameLogs$runs_inning_1 + MLBTeamGameLogs$runs_inning_2 


############## Data Analysis ###################

# Utilize data.table's grouping math
dt_MLBTeamGameLogs <- data.table(MLBTeamGameLogs)

# Create new column with runs difference through 1 inning
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaI1:=diff(runs_inning_1)*c(-1,1), by = game_id][]

# Create new column with runs difference through 2 innings
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaI1_I2:=diff(runs_inning_1_to_2)*c(-1,1), by = game_id][]

# Create new column with runs difference through 3 innings
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaI1_I3:=diff(runs_inning_1_to_3)*c(-1,1), by = game_id][]

# Create new column with runs difference through 4 innings
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaI1_I4:=diff(runs_inning_1_to_4)*c(-1,1), by = game_id][]

# Create new column with runs difference through 5 innings
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaI1_I5:=diff(runs_inning_1_to_5)*c(-1,1), by = game_id][]

# Create new column with runs difference through 6 innings
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaI1_I6:=diff(runs_inning_1_to_6)*c(-1,1), by = game_id][]

# Create new column with runs difference through 7 innings
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaI1_I7:=diff(runs_inning_1_to_7)*c(-1,1), by = game_id][]

# Create new column with runs difference through 8 innings
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaI1_I8:=diff(runs_inning_1_to_8)*c(-1,1), by = game_id][]

# Create new column with runs difference through 9 innings
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaI1_I9:=diff(runs_inning_1_to_9)*c(-1,1), by = game_id][]

# Create new column with runs difference at the end of the game
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaTS:=diff(runs)*c(-1,1), by = game_id][]  


# Create new column with differentials of various stats for random forest / regression 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaTeamSalary:=diff(TeamSalary)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaAtBats:=diff(at_bats)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaBattingAVG:=diff(batting_average)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaDoublePlays:=diff(double_plays)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaDoubles:=diff(doubles)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaErrorsMade:=diff(errors_made)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaHits:=diff(hits)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaLeftOnBase:=diff(left_on_base)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaOnBasePercent:=diff(on_base_percentage)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaSluggingPercent:=diff(slugging_percentage)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaStrikeouts:=diff(strikeouts)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaTotalBases:=diff(total_bases)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaTriplePlays:=diff(triple_plays)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaTriples:=diff(triples)*c(-1,1), by = game_id][] 
MLBTeamGameLogs <- dt_MLBTeamGameLogs[,DeltaWhip:=diff(whip)*c(-1,1), by = game_id][] 

# Convert all new fields to absolute values
MLBTeamGameLogs$DeltaTeamSalary <- abs(MLBTeamGameLogs$DeltaTeamSalary)
MLBTeamGameLogs$DeltaAtBats <- abs(MLBTeamGameLogs$DeltaAtBats)
MLBTeamGameLogs$DeltaBattingAVG <- abs(MLBTeamGameLogs$DeltaBattingAVG)
MLBTeamGameLogs$DeltaDoublePlays <- abs(MLBTeamGameLogs$DeltaDoublePlays)
MLBTeamGameLogs$DeltaDoubles <- abs(MLBTeamGameLogs$DeltaDoubles)
MLBTeamGameLogs$DeltaErrorsMade <- abs(MLBTeamGameLogs$DeltaErrorsMade)
MLBTeamGameLogs$DeltaHits <- abs(MLBTeamGameLogs$DeltaHits)
MLBTeamGameLogs$DeltaLeftOnBase <- abs(MLBTeamGameLogs$DeltaLeftOnBase)
MLBTeamGameLogs$DeltaOnBasePercent <- abs(MLBTeamGameLogs$DeltaOnBasePercent)
MLBTeamGameLogs$DeltaSluggingPercent <- abs(MLBTeamGameLogs$DeltaSluggingPercent)
MLBTeamGameLogs$DeltaStrikeouts <- abs(MLBTeamGameLogs$DeltaStrikeouts)
MLBTeamGameLogs$DeltaTotalBases <- abs(MLBTeamGameLogs$DeltaTotalBases)
MLBTeamGameLogs$DeltaTriplePlays <- abs(MLBTeamGameLogs$DeltaTriplePlays)
MLBTeamGameLogs$DeltaTriples <- abs(MLBTeamGameLogs$DeltaTriples)
MLBTeamGameLogs$DeltaWhip <- abs(MLBTeamGameLogs$DeltaWhip)


Losers <- MLBTeamGameLogs[which(MLBTeamGameLogs$DeltaTS < 1),]
Losers <- Losers$DeltaI1_I6

MLB_Threshold <- round(mean(Losers),0)

# Create a new boolean column if the game went to overtime
MLBTeamGameLogs$Overtime <- as.numeric(MLBTeamGameLogs$DeltaI1_I9 == 0)

# Create a new boolean column if the game meets 'Comeback' criteria
MLBTeamGameLogs$IsComeback <- as.numeric(MLBTeamGameLogs$DeltaI1_I6 <= MLB_Threshold & MLBTeamGameLogs$DeltaTS > 1)

# Create a new boolean column if the game meets 'Comeback' criteria (2)
MLBTeamGameLogs$IsComeback2 <- as.numeric(MLBTeamGameLogs$DeltaI1_I3 <= MLB_Threshold & MLBTeamGameLogs$DeltaTS > 1)

# Create a new boolean column if the game meets 'Close Game' criteria (1)
MLBTeamGameLogs$IsCloseGame <- as.numeric(abs(MLBTeamGameLogs$DeltaI1) <= 1 & abs(MLBTeamGameLogs$DeltaI1_I2) <= 1 & abs(MLBTeamGameLogs$DeltaI1_I3) <= 1 
                                 & abs(MLBTeamGameLogs$DeltaI1_I4) <= 1 & abs(MLBTeamGameLogs$DeltaI1_I5) <= 1 & abs(MLBTeamGameLogs$DeltaI1_I6) <= 1 
                                 & abs(MLBTeamGameLogs$DeltaI1_I7) <= 1 & abs(MLBTeamGameLogs$DeltaI1_I8) <= 1 
                                 & (abs(MLBTeamGameLogs$DeltaTS) <= 1 | MLBTeamGameLogs$Overtime==1))

# Create a new boolean column if the game meets 'Close Game' criteria (2)
MLBTeamGameLogs$IsCloseGame2 <- as.numeric(abs(MLBTeamGameLogs$DeltaI1_I7) <= 1 & abs(MLBTeamGameLogs$DeltaI1_I8) <= 1 
                                  & (abs(MLBTeamGameLogs$DeltaTS) <= 1 | MLBTeamGameLogs$Overtime==1))

# Create a new boolean column if the game meets 'Close Game' criteria (3)
MLBTeamGameLogs$IsCloseGame3 <- as.numeric(abs(MLBTeamGameLogs$DeltaTS) <= 1 | MLBTeamGameLogs$Overtime==1)

# Create a new boolean column if the game meets 'Blow Out' criteria (1)
MLBTeamGameLogs$IsBlowOut <- as.numeric(abs(MLBTeamGameLogs$DeltaI1) > 3 & abs(MLBTeamGameLogs$DeltaI1_I2) > 3 & abs(MLBTeamGameLogs$DeltaI1_I3) > 3 
                                     & abs(MLBTeamGameLogs$DeltaI1_I4) > 3 & abs(MLBTeamGameLogs$DeltaI1_I5) > 3 & abs(MLBTeamGameLogs$DeltaI1_I6) > 3 
                                     & abs(MLBTeamGameLogs$DeltaI1_I7) > 3 & abs(MLBTeamGameLogs$DeltaI1_I8) > 3
                                     & abs(MLBTeamGameLogs$DeltaTS) > 3)

# Create a new boolean column if the game meets 'Blow Out' criteria (2)
MLBTeamGameLogs$IsBlowOut2 <- as.numeric(abs(MLBTeamGameLogs$DeltaI1_I7) > 3 & abs(MLBTeamGameLogs$DeltaI1_I8) > 3 
                                      & abs(MLBTeamGameLogs$DeltaTS) > 3)

# Create a new boolean column if the game meets 'Blow Out' criteria (3)
MLBTeamGameLogs$IsBlowOut3 <- as.numeric(abs(MLBTeamGameLogs$DeltaTS) > 3)

colnames(MLBTeamGameLogs)
setDF(MLBTeamGameLogs)

# Check mutations
MLBTeamGameLogs[which(MLBTeamGameLogs$Overtime== 1),]
MLBTeamGameLogs[which(MLBTeamGameLogs$game_id == 'd5e466ea-e901-46b9-a87b-86f196cf7f5d'),]
MLBTeamGameLogs[which(MLBTeamGameLogs$IsCloseGame== 1),]
MLBTeamGameLogs[which(MLBTeamGameLogs$game_id == 'd3fc9bef-0e98-4745-81d3-4ca7aed6df7a'),]

#Sub set by season
MLB_RegularSeason <- MLBTeamGameLogs[which(MLBTeamGameLogs$Type == 'RegularSeason'),]
MLB_Playoffs <- MLBTeamGameLogs[which(MLBTeamGameLogs$Type == 'Playoffs'),]


############## Results ###################

# Comebacks - Case 1
ComebacksInMLB_RegularSeason <- (sum(MLB_RegularSeason$IsComeback)/sum(as.numeric(MLB_RegularSeason$DeltaI1_I6 <= MLB_Threshold)))*100
ComebacksInMLB_Playoffs<- (sum(MLB_Playoffs$IsComeback)/sum(as.numeric(MLB_Playoffs$DeltaI1_I6 <= MLB_Threshold)))*100
# Results
ComebacksInMLB_RegularSeason
ComebacksInMLB_Playoffs

# Comebacks - Case 2
ComebacksInMLB_RegularSeason_2 <- (sum(MLB_RegularSeason$IsComeback2)/sum(as.numeric(MLB_RegularSeason$DeltaI1_I3 <= MLB_Threshold)))*100
ComebacksInMLB_Playoffs_2 <- (sum(MLB_Playoffs$IsComeback2)/sum(as.numeric(MLB_Playoffs$DeltaI1_I3 <= MLB_Threshold)))*100
# Results
ComebacksInMLB_RegularSeason_2
ComebacksInMLB_Playoffs_2

AVGComebackMLB <- (ComebacksInMLB_RegularSeason+ComebacksInMLB_Playoffs
                   +ComebacksInMLB_RegularSeason_2+ComebacksInMLB_Playoffs_2)/4

# Close Games - Case 1
CloseGamesInMLB_RegularSeason <- ((sum(MLB_RegularSeason$IsCloseGame)/2)/length(unique(MLB_RegularSeason$game_id)))*100
CloseGamesInMLB_Playoffs <- ((sum(MLB_Playoffs$IsCloseGame)/2)/length(unique(MLB_Playoffs$game_id)))*100
# Results
CloseGamesInMLB_RegularSeason
CloseGamesInMLB_Playoffs

# Close Games - Case 2
CloseGamesInMLB_RegularSeason_2 <- ((sum(MLB_RegularSeason$IsCloseGame2)/2)/length(unique(MLB_RegularSeason$game_id)))*100
CloseGamesInMLB_Playoffs_2 <- ((sum(MLB_Playoffs$IsCloseGame2)/2)/length(unique(MLB_Playoffs$game_id)))*100
# Results
CloseGamesInMLB_RegularSeason_2
CloseGamesInMLB_Playoffs_2

# Close Games - Case 3
CloseGamesInMLB_RegularSeason_3 <- ((sum(MLB_RegularSeason$IsCloseGame3)/2)/length(unique(MLB_RegularSeason$game_id)))*100
CloseGamesInMLB_Playoffs_3 <- ((sum(MLB_Playoffs$IsCloseGame3)/2)/length(unique(MLB_Playoffs$game_id)))*100
# Results
CloseGamesInMLB_RegularSeason_3
CloseGamesInMLB_Playoffs_3

AVGCloseGameMLB <- (CloseGamesInMLB_RegularSeason+CloseGamesInMLB_Playoffs
                    +CloseGamesInMLB_RegularSeason_2+CloseGamesInMLB_Playoffs_2
                    +CloseGamesInMLB_RegularSeason_3+CloseGamesInMLB_Playoffs_3)/6

# Blow Outs - Case 1
BlowOutsInMLB_RegularSeason <- ((sum(MLB_RegularSeason$IsBlowOut)/2)/length(unique(MLB_RegularSeason$game_id)))*100
BlowOutsInMLB_Playoffs <- ((sum(MLB_Playoffs$IsBlowOut)/2)/length(unique(MLB_Playoffs$game_id)))*100
# Results
BlowOutsInMLB_RegularSeason
BlowOutsInMLB_Playoffs

# Blow Outs - Case 2
BlowOutsInMLB_RegularSeason_2 <- ((sum(MLB_RegularSeason$IsBlowOut2)/2)/length(unique(MLB_RegularSeason$game_id)))*100
BlowOutsInMLB_Playoffs_2 <- ((sum(MLB_Playoffs$IsBlowOut2)/2)/length(unique(MLB_Playoffs$game_id)))*100
# Results
BlowOutsInMLB_RegularSeason_2
BlowOutsInMLB_Playoffs_2

# Blow Outs - Case 3
BlowOutsInMLB_RegularSeason_3 <- ((sum(MLB_RegularSeason$IsBlowOut3)/2)/length(unique(MLB_RegularSeason$game_id)))*100
BlowOutsInMLB_Playoffs_3 <- ((sum(MLB_Playoffs$IsBlowOut3)/2)/length(unique(MLB_Playoffs$game_id)))*100
# Results
BlowOutsInMLB_RegularSeason_3
BlowOutsInMLB_Playoffs_3

AVGBlowoutMLB <- (BlowOutsInMLB_RegularSeason+BlowOutsInMLB_Playoffs
                  +BlowOutsInMLB_RegularSeason_2+BlowOutsInMLB_Playoffs_2
                  +BlowOutsInMLB_RegularSeason_3+BlowOutsInMLB_Playoffs_3)/6

AVGComebackMLB
AVGCloseGameMLB
AVGBlowoutMLB

######################## Random Forest / Log Regression ################

## Rename Columns
check <- aggregate(cbind(count = game_id) ~ game_id, 
                   data = MLBTeamGameLogs, 
                   FUN = function(x){NROW(x)})

check[which(check$count > 2),]

MLBGames <- MLBGames_Full_Data[c('game_id','attendance','away_team_outcome','home_team_outcome'
                                 ,'score_differential','scoreline','Season','Type')]

MLBTeamGameLogs_RF <- MLBTeamGameLogs[c('game_id','Type','Season'
                                        ,'DeltaTeamSalary','DeltaAtBats','DeltaBattingAVG','DeltaDoublePlays'          
                                        ,'DeltaDoubles','DeltaErrorsMade','DeltaHits','DeltaLeftOnBase'           
                                        ,'DeltaOnBasePercent','DeltaSluggingPercent','DeltaStrikeouts','DeltaTotalBases'           
                                        ,'DeltaTriplePlays','DeltaTriples','DeltaWhip'
                                        ,'IsCloseGame','IsCloseGame2','IsCloseGame3', 'IsBlowOut', 'IsBlowOut2','IsBlowOut3')]

MLBTeamGameLogs_RF <- sqldf("SELECT DISTINCT * 
                            FROM MLBTeamGameLogs_RF")


MLBGameData_Models <- sqldf("SELECT A.game_id AS Game_Id,A.Type,A.Season, attendance AS Attendance, score_differential AS ScoreDifferential
                            , scoreline AS Scoreline,DeltaTeamSalary,DeltaAtBats,DeltaBattingAVG
                              ,DeltaDoublePlays,DeltaDoubles,DeltaErrorsMade,DeltaHits,DeltaLeftOnBase           
                            ,DeltaOnBasePercent,DeltaSluggingPercent,DeltaStrikeouts,DeltaTotalBases           
                            ,DeltaTriplePlays,DeltaTriples,DeltaWhip
                            ,IsCloseGame,IsCloseGame2,IsCloseGame3, IsBlowOut, IsBlowOut2,IsBlowOut3
                            FROM MLBTeamGameLogs_RF A 
                            INNER JOIN MLBGames B
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
spl1 = sample.split(MLBGameData_Models$IsCloseGame3, SplitRatio = 0.7)
Train1 = subset(MLBGameData_Models, spl1==TRUE)
Test1 = subset(MLBGameData_Models, spl1==FALSE)

MLB_Close_Games_Tree = rpart(IsCloseGame3 ~ DeltaTeamSalary+DeltaAtBats+DeltaBattingAVG+DeltaDoublePlays          
                             +DeltaDoubles+DeltaErrorsMade+DeltaHits+DeltaLeftOnBase           
                             +DeltaOnBasePercent+DeltaSluggingPercent+DeltaStrikeouts+DeltaTotalBases           
                             +DeltaTriplePlays+DeltaTriples+DeltaWhip
                             , data = Train1, method="class", minbucket=25)

prp(MLB_Close_Games_Tree)

# Make predictions
PredictCART = predict(MLB_Close_Games_Tree, newdata = Test1, type = "class")
table(Test1$IsCloseGame3, PredictCART)
(1024+121)/(1024+121+372+102)

PredictROC = predict(MLB_Close_Games_Tree, newdata = Test1)
PredictROC

pred = prediction(PredictROC[,2], Test1$IsCloseGame3)
perf = performance(pred, "tpr", "fpr")
plot(perf)


### Blow Outs

# Split Data
set.seed(3000)
spl2 = sample.split(MLBGameData_Models$IsBlowOut3, SplitRatio = 0.7)
Train2 = subset(MLBGameData_Models, spl2==TRUE)
Test2 = subset(MLBGameData_Models, spl2==FALSE)

MLB_Blow_Outs_Tree = rpart(IsBlowOut3 ~ DeltaTeamSalary+DeltaAtBats+DeltaBattingAVG+DeltaDoublePlays          
                           +DeltaDoubles+DeltaErrorsMade+DeltaHits+DeltaLeftOnBase           
                           +DeltaOnBasePercent+DeltaSluggingPercent+DeltaStrikeouts+DeltaTotalBases           
                           +DeltaTriplePlays+DeltaTriples+DeltaWhip
                           , data = Train2, method="class", minbucket=25)


prp(MLB_Blow_Outs_Tree)

png(
  "MLB_blowouts_tree.png",
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
rpart.plot(MLB_Blow_Outs_Tree
           , uniform=TRUE, compress=TRUE
           , fallen=T, branch=1, round=0, cex.main=1
           , split.round=0
           , branch.lwd=.5, split.lwd=.5, nn.lwd=.5
           , main = "Classification Tree for Blowouts in the MLB")
dev.off()


# Make predictions
PredictCART = predict(MLB_Blow_Outs_Tree, newdata = Test2, type = "class")
table(Test2$IsBlowOut3, PredictCART)
(892+315)/(892+315+298+114)

PredictROC = predict(MLB_Blow_Outs_Tree, newdata = Test2)
PredictROC

pred = prediction(PredictROC[,2], Test2$IsBlowOut3)
perf = performance(pred, "tpr", "fpr")
plot(perf)


################# Random Forests #########################

# Install randomForest package
library(randomForest)

# Close Games 

# Convert outcome to factor for classification model
Train1$IsCloseGame3 = as.factor(Train1$IsCloseGame3)
Test1$IsCloseGame3 = as.factor(Test1$IsCloseGame3)

# Try again
MLB_CloseGame_Forest = randomForest(IsCloseGame3 ~ DeltaTeamSalary+DeltaAtBats+DeltaBattingAVG+DeltaDoublePlays          
                                    +DeltaDoubles+DeltaErrorsMade+DeltaHits+DeltaLeftOnBase           
                                    +DeltaOnBasePercent+DeltaSluggingPercent+DeltaStrikeouts+DeltaTotalBases           
                                    +DeltaTriplePlays+DeltaTriples+DeltaWhip
                                    , data = Train1, ntree=200, nodesize=25 )

# Make predictions
PredictForest = predict(MLB_CloseGame_Forest, newdata = Test1)
table(Test1$IsCloseGame3, PredictForest)
(1037+138)/(1037+138+355+89)


# Blow Outs

# Convert outcome to factor for classification model
Train2$IsBlowOut3 = as.factor(Train2$IsBlowOut3)
Test2$IsBlowOut3 = as.factor(Test2$IsBlowOut3)

# Try again
MLB_Blowout_Forest = randomForest(IsBlowOut3 ~ DeltaTeamSalary+DeltaAtBats+DeltaBattingAVG+DeltaDoublePlays          
                                  +DeltaDoubles+DeltaErrorsMade+DeltaHits+DeltaLeftOnBase           
                                  +DeltaOnBasePercent+DeltaSluggingPercent+DeltaStrikeouts+DeltaTotalBases           
                                  +DeltaTriplePlays+DeltaTriples+DeltaWhip
                                  , data = Train2, ntree=200, nodesize=25 )

# Make predictions
PredictForest = predict(MLB_Blowout_Forest, newdata = Test2)
table(Test2$IsBlowOut3, PredictForest)
(876+346)/(876+346+267+130)


############## Logistic Regression Model #################

MLB_CloseGame_Log = glm(IsCloseGame3 ~ DeltaTeamSalary+DeltaAtBats+DeltaBattingAVG+DeltaDoublePlays          
                        +DeltaDoubles+DeltaErrorsMade+DeltaHits+DeltaLeftOnBase           
                        +DeltaOnBasePercent+DeltaSluggingPercent+DeltaStrikeouts+DeltaTotalBases           
                        +DeltaTriplePlays+DeltaTriples+DeltaWhip
                        , data = Train1, family=binomial)
summary(MLB_CloseGame_Log)

# Predictions on the test set
predictTest = predict(MLB_CloseGame_Log, type="response", newdata=Test1)

# Confusion matrix with threshold of 0.5
table(Test1$IsCloseGame3, predictTest > 0.5)

# Accuracy
(1002+144)/(1002+144+349+124)

# Baseline 
(1002+124)/(1002+144+349+124)

#Model is just barely better than baseline. 


# Test set AUC 
library(ROCR)
ROCRpred = prediction(predictTest, Test1$IsCloseGame3)
as.numeric(performance(ROCRpred, "auc")@y.values)

# The model could differentiate between blowouts and non-blowouts pretty well 
# with an out-of-sample AUC of 0.76.

############## Feature Importance #############

# estimate variable importance
importance <- varImp(MLB_Blowout_Forest, scale=FALSE)
# summarize importance
importance




































