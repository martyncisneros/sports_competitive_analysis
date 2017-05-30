###### Plots ######
library(ggplot2)
library(grid)

###################### Comebacks ########################

## Comebacks - Case 1

league <- c('NBA','NFL','NHL','MLB')
comebacks <- c(ComebacksInNBA_Playoffs,ComebacksInNFL_Playoffs,ComebacksInNHL_Playoffs,ComebacksInMLB_Playoffs)
Type <- c('Playoffs','Playoffs','Playoffs','Playoffs')
comebackdata_PO <- data.frame(league, comebacks,Type)

league <- c('NBA','NFL','NHL','MLB')
comebacks <- c(ComebacksInNBA_RegularSeason,ComebacksInNBA_RegularSeason,ComebacksInNBA_RegularSeason,ComebacksInMLB_RegularSeason)
Type <- c('Season','Season','Season','Season')
comebackdata_RS <- data.frame(league, comebacks, Type)

comebackdata <- rbind(comebackdata_PO,comebackdata_RS)
comebackdata <- comebackdata[order(-comebackdata$comebacks),]

ComeBackCase1 <- ggplot(data=comebackdata, aes(x=reorder(league, -comebacks), y=comebacks, fill=Type)) +
  #black outline outside of bars
  geom_bar(stat="identity", position=position_dodge(), colour="black", size=.1) +
  #legend theme
  scale_fill_manual(values=c("#00bdc4", "#f8766d")) + theme_bw() +
  theme(legend.text = element_text(size=4,colour="#535353",face="bold")) +
  theme(legend.background = element_rect(fill="#F0F0F0")) +
  theme(legend.title=element_blank()) +
  theme(legend.key = element_rect(size = 4)) +
  theme(legend.position = c(.9, .9)) + 
  theme(legend.key.size = unit(.15, 'cm')) +
  #background theme
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  #title theme
  ggtitle("Comebacks by League - Case 1") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  #axis theme
  ylab("Comeback Game %") + xlab("League") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_blank()) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank()) +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "Comebackcase1.png",
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
ComeBackCase1
dev.off()


## Comebacks - Case 2

league <- c('NBA','NFL','NHL','MLB')
comebacks2 <- c(ComebacksInNBA_Playoffs_2,ComebacksInNFL_Playoffs_2,ComebacksInNHL_Playoffs_2,ComebacksInMLB_Playoffs_2)
Type <- c('Playoffs','Playoffs','Playoffs','Playoffs')
comebackdata_PO <- data.frame(league, comebacks2,Type)

league <- c('NBA','NFL','NHL','MLB')
comebacks2 <- c(ComebacksInNBA_RegularSeason_2,ComebacksInNBA_RegularSeason_2,ComebacksInNBA_RegularSeason_2,ComebacksInMLB_RegularSeason_2)
Type <- c('Season','Season','Season','Season')
comebackdata_RS <- data.frame(league, comebacks2, Type)

comebackdata2 <- rbind(comebackdata_PO,comebackdata_RS)
comebackdata2 <- comebackdata[order(-comebackdata$comebacks2),]

ComeBackCase2 <- ggplot(data=comebackdata2, aes(x=reorder(league, -comebacks2), y=comebacks2, fill=Type)) +
  #black outline outside of bars
  geom_bar(stat="identity", position=position_dodge(), colour="black", size=.1) +
  #legend theme
  scale_fill_manual(values=c("#00bdc4", "#f8766d")) + theme_bw() +
  theme(legend.text = element_text(size=4,colour="#535353",face="bold")) +
  theme(legend.background = element_rect(fill="#F0F0F0")) +
  theme(legend.title=element_blank()) +
  theme(legend.key = element_rect(size = 4)) +
  theme(legend.position = c(.9, 1.05)) + 
  theme(legend.key.size = unit(.15, 'cm')) +
  #background theme
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  #title theme
  ggtitle("Comebacks by League - Case 2") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  #axis theme
  ylab("Comeback Game %") + xlab("League") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_blank()) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank()) +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "Comebackcase2.png",
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
ComeBackCase2
dev.off()


###################### Close Games  ########################

## Close Games - Case 1

CloseGamesInMLB_RegularSeason
CloseGamesInMLB_Playoffs

league <- c('NBA','NFL','NHL','MLB')
closegames <- c(CloseGamesInNBA_Playoffs,CloseGamesInNFL_Playoffs,CloseGamesInNHL_Playoffs,CloseGamesInMLB_Playoffs)
Type <- c('Playoffs','Playoffs','Playoffs','Playoffs')
closegamedata_PO <- data.frame(league, closegames,Type)

league <- c('NBA','NFL','NHL','MLB')
closegames <- c(CloseGamesInNBA_RegularSeason,CloseGamesInNFL_RegularSeason,CloseGamesInNHL_RegularSeason,CloseGamesInMLB_RegularSeason)
Type <- c('Season','Season','Season','Season')
closegamedata_RS <- data.frame(league, closegames, Type)

closegamedata <- rbind(closegamedata_PO,closegamedata_RS)
closegamedata <- closegamedata[order(-closegamedata$closegames),]

CloseGameCase1 <- ggplot(data=closegamedata, aes(x=reorder(league, -closegames), y=closegames, fill=Type)) +
  #black outline outside of bars
  geom_bar(stat="identity", position=position_dodge(), colour="black", size=.1) +
  #legend theme
  scale_fill_manual(values=c("#00bdc4", "#f8766d")) + theme_bw() +
  theme(legend.text = element_text(size=4,colour="#535353",face="bold")) +
  theme(legend.background = element_rect(fill="#F0F0F0")) +
  theme(legend.title=element_blank()) +
  theme(legend.key = element_rect(size = 4)) +
  theme(legend.position = c(.9, .9)) + 
  theme(legend.key.size = unit(.15, 'cm')) +
  #background theme
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  #title theme
  ggtitle("Close Games by League - Case 1") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  #axis theme
  ylab("Close Game %") + xlab("League") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_blank()) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank()) +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "Closegamecase1.png",
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
CloseGameCase1
dev.off()

## Close Games - Case 2

league <- c('NBA','NFL','NHL','MLB')
closegames2 <- c(CloseGamesInNBA_Playoffs_2,CloseGamesInNFL_Playoffs_2,CloseGamesInNHL_Playoffs_2,CloseGamesInMLB_Playoffs_2)
Type <- c('Playoffs','Playoffs','Playoffs','Playoffs')
closegamedata_PO <- data.frame(league, closegames2,Type)

league <- c('NBA','NFL','NHL','MLB')
closegames2 <- c(CloseGamesInNBA_RegularSeason_2,CloseGamesInNFL_RegularSeason_2,CloseGamesInNHL_RegularSeason_2,CloseGamesInMLB_RegularSeason_2)
Type <- c('Season','Season','Season','Season')
closegamedata_RS <- data.frame(league, closegames2, Type)

closegamedata2 <- rbind(closegamedata_PO,closegamedata_RS)
closegamedata2 <- closegamedata2[order(-closegamedata2$closegames2),]

CloseGameCase2 <- ggplot(data=closegamedata2, aes(x=reorder(league, -closegames2), y=closegames2, fill=Type)) +
  #black outline outside of bars
  geom_bar(stat="identity", position=position_dodge(), colour="black", size=.1) +
  #legend theme
  scale_fill_manual(values=c("#00bdc4", "#f8766d")) + theme_bw() +
  theme(legend.text = element_text(size=4,colour="#535353",face="bold")) +
  theme(legend.background = element_rect(fill="#F0F0F0")) +
  theme(legend.title=element_blank()) +
  theme(legend.key = element_rect(size = 4)) +
  theme(legend.position = c(.9, .9)) + 
  theme(legend.key.size = unit(.15, 'cm')) +
  #background theme
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  #title theme
  ggtitle("Close Games by League - Case 2") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  #axis theme
  ylab("Close Game %") + xlab("League") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_blank()) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank()) +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "Closegamecase2.png",
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
CloseGameCase2
dev.off()

## Close Games - Case 3

league <- c('NBA','NFL','NHL','MLB')
closegames3 <- c(CloseGamesInNBA_Playoffs_3,CloseGamesInNFL_Playoffs_3,CloseGamesInNHL_Playoffs_3,CloseGamesInMLB_Playoffs_3)
Type <- c('Playoffs','Playoffs','Playoffs','Playoffs')
closegamedata_PO <- data.frame(league, closegames3,Type)

league <- c('NBA','NFL','NHL','MLB')
closegames3 <- c(CloseGamesInNBA_RegularSeason_3,CloseGamesInNFL_RegularSeason_3,CloseGamesInNHL_RegularSeason_3,CloseGamesInMLB_RegularSeason_3)
Type <- c('Season','Season','Season','Season')
closegamedata_RS <- data.frame(league, closegames3, Type)

closegamedata3 <- rbind(closegamedata_PO,closegamedata_RS)
closegamedata3 <- closegamedata3[order(-closegamedata3$closegames3),]

CloseGameCase3 <- ggplot(data=closegamedata3, aes(x=reorder(league, -closegames3), y=closegames3, fill=Type)) +
  #black outline outside of bars
  geom_bar(stat="identity", position=position_dodge(), colour="black", size=.1) +
  #legend theme
  scale_fill_manual(values=c("#00bdc4", "#f8766d")) + theme_bw() +
  theme(legend.text = element_text(size=4,colour="#535353",face="bold")) +
  theme(legend.background = element_rect(fill="#F0F0F0")) +
  theme(legend.title=element_blank()) +
  theme(legend.key = element_rect(size = 4)) +
  theme(legend.position = c(.9, .9)) + 
  theme(legend.key.size = unit(.15, 'cm')) +
  #background theme
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  #title theme
  ggtitle("Close Games by League - Case 3") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  #axis theme
  ylab("Close Game %") + xlab("League") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_blank()) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank()) +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "Closegamecase3.png",
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
CloseGameCase3
dev.off()

###################### Blow Outs ########################

## Blow Outs - Case 1

BlowOutsInMLB_RegularSeason
BlowOutsInMLB_Playoffs

league <- c('NBA','NFL','NHL','MLB')
BlowOuts <- c(BlowOutsInNBA_Playoffs,BlowOutsInNFL_Playoffs,BlowOutsInNHL_Playoffs,BlowOutsInMLB_Playoffs)
Type <- c('Playoffs','Playoffs','Playoffs','Playoffs')
BlowOutdata_PO <- data.frame(league, BlowOuts,Type)

league <- c('NBA','NFL','NHL','MLB')
BlowOuts <- c(BlowOutsInNBA_RegularSeason,BlowOutsInNFL_RegularSeason,BlowOutsInNHL_RegularSeason,BlowOutsInMLB_RegularSeason)
Type <- c('Season','Season','Season','Season')
BlowOutdata_RS <- data.frame(league, BlowOuts, Type)

BlowOutdata <- rbind(BlowOutdata_PO,BlowOutdata_RS)
BlowOutdata <- BlowOutdata[order(-BlowOutdata$BlowOuts),]

BlowOutCase1 <- ggplot(data=BlowOutdata, aes(x=reorder(league, -BlowOuts), y=BlowOuts, fill=Type)) +
  #black outline outside of bars
  geom_bar(stat="identity", position=position_dodge(), colour="black", size=.1) +
  #legend theme
  scale_fill_manual(values=c("#00bdc4", "#f8766d")) + theme_bw() +
  theme(legend.text = element_text(size=4,colour="#535353",face="bold")) +
  theme(legend.background = element_rect(fill="#F0F0F0")) +
  theme(legend.title=element_blank()) +
  theme(legend.key = element_rect(size = 4)) +
  theme(legend.position = c(.9, .9)) + 
  theme(legend.key.size = unit(.15, 'cm')) +
  #background theme
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  #title theme
  ggtitle("Blowouts by League - Case 1") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  #axis theme
  ylab("Blowout Game %") + xlab("League") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_blank()) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank()) +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "Blowoutcase1.png",
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
BlowOutCase1
dev.off()

## Blow outs - Case 2

league <- c('NBA','NFL','NHL','MLB')
BlowOuts2 <- c(BlowOutsInNBA_Playoffs_2,BlowOutsInNFL_Playoffs_2,BlowOutsInNHL_Playoffs_2,BlowOutsInMLB_Playoffs_2)
Type <- c('Playoffs','Playoffs','Playoffs','Playoffs')
BlowOutdata_PO <- data.frame(league, BlowOuts2,Type)

league <- c('NBA','NFL','NHL','MLB')
BlowOuts2 <- c(BlowOutsInNBA_RegularSeason_2,BlowOutsInNFL_RegularSeason_2,BlowOutsInNHL_RegularSeason_2,BlowOutsInMLB_RegularSeason_2)
Type <- c('Season','Season','Season','Season')
BlowOutdata_RS <- data.frame(league, BlowOuts2, Type)

BlowOutdata2 <- rbind(BlowOutdata_PO,BlowOutdata_RS)
BlowOutdata2 <- BlowOutdata2[order(-BlowOutdata2$BlowOuts2),]

BlowOutCase2 <- ggplot(data=BlowOutdata2, aes(x=reorder(league, -BlowOuts2), y=BlowOuts2, fill=Type)) +
  #black outline outside of bars
  geom_bar(stat="identity", position=position_dodge(), colour="black", size=.1) +
  #legend theme
  scale_fill_manual(values=c("#00bdc4", "#f8766d")) + theme_bw() +
  theme(legend.text = element_text(size=4,colour="#535353",face="bold")) +
  theme(legend.background = element_rect(fill="#F0F0F0")) +
  theme(legend.title=element_blank()) +
  theme(legend.key = element_rect(size = 4)) +
  theme(legend.position = c(.9, .9)) + 
  theme(legend.key.size = unit(.15, 'cm')) +
  #background theme
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  #title theme
  ggtitle("Blowouts by League - Case 2") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  #axis theme
  ylab("Blowout Game %") + xlab("League") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_blank()) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank()) +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "Blowoutcase2.png",
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
BlowOutCase2
dev.off()

## Blow outs - Case 3

league <- c('NBA','NFL','NHL','MLB')
BlowOuts3 <- c(BlowOutsInNBA_Playoffs_3,BlowOutsInNFL_Playoffs_3,BlowOutsInNHL_Playoffs_3,BlowOutsInMLB_Playoffs_3)
Type <- c('Playoffs','Playoffs','Playoffs','Playoffs')
BlowOutdata_PO <- data.frame(league, BlowOuts3,Type)

league <- c('NBA','NFL','NHL','MLB')
BlowOuts3 <- c(BlowOutsInNBA_RegularSeason_3,BlowOutsInNFL_RegularSeason_3,BlowOutsInNHL_RegularSeason_3,BlowOutsInMLB_RegularSeason_3)
Type <- c('Season','Season','Season','Season')
BlowOutdata_RS <- data.frame(league, BlowOuts3, Type)

BlowOutdata3 <- rbind(BlowOutdata_PO,BlowOutdata_RS)
BlowOutdata3 <- BlowOutdata3[order(-BlowOutdata3$BlowOuts3),]

BlowOutCase3 <- ggplot(data=BlowOutdata3, aes(x=reorder(league, -BlowOuts3), y=BlowOuts3, fill=Type)) +
  #black outline outside of bars
  geom_bar(stat="identity", position=position_dodge(), colour="black", size=.1) +
  #legend theme
  scale_fill_manual(values=c("#00bdc4", "#f8766d")) + theme_bw() +
  theme(legend.text = element_text(size=4,colour="#535353",face="bold")) +
  theme(legend.background = element_rect(fill="#F0F0F0")) +
  theme(legend.title=element_blank()) +
  theme(legend.key = element_rect(size = 4)) +
  theme(legend.position = c(.9, .9)) + 
  theme(legend.key.size = unit(.15, 'cm')) +
  #background theme
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  #title theme
  ggtitle("Blowouts by League - Case 3") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  #axis theme
  ylab("Blowout Game %") + xlab("League") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_blank()) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank()) +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "Blowoutcase3.png",
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
BlowOutCase3
dev.off()

###################### Salary Cap v Wins ########################

nba <- ggplot(data=Wins_vs_Salary_NBA, aes(x = TeamSalary/1000000, y = Wins)) +
  geom_point(stat="identity", colour="#00bdc4", size=.01) +  theme_bw() +
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  ggtitle("Payroll vs Wins in the NBA") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  ylab("Average Wins Per Season") + xlab("Payroll Per Season (in Millions)") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_text(size=4,colour="#535353",face="bold",vjust=-.5)) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank())  +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "NBApayrollandwins.png",
  width     = 2.13,
  height    = 1.42,
  units     = "in",
  res       = 600 ,
  pointsize = 4
)
par(
  mar      = c(5, 5, 2, 2),
  xaxs     = "i",
  yaxs     = "i",
  cex.axis = 2,
  cex.lab  = 2
)
nba
dev.off()

nfl <- ggplot(data=Wins_vs_Salary_NFL, aes(x = TeamSalary/1000000, y = Wins)) +
  geom_point(stat="identity", colour="#00bdc4", size=.01) +  theme_bw() +
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  ggtitle("Payroll vs Wins in the NFL") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  ylab("Average Wins Per Season") + xlab("Payroll Per Season (in Millions)") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_text(size=4,colour="#535353",face="bold",vjust=-.5)) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank())  +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "NFLpayrollandwins.png",
  width     = 2.13,
  height    = 1.42,
  units     = "in",
  res       = 600 ,
  pointsize = 4
)
par(
  mar      = c(5, 5, 2, 2),
  xaxs     = "i",
  yaxs     = "i",
  cex.axis = 2,
  cex.lab  = 2
)
nfl
dev.off()


nhl <- ggplot(data=Wins_vs_Salary_NHL, aes(x = TeamSalary/1000000, y = Wins)) +
  geom_point(stat="identity", colour="#00bdc4", size=.01) +  theme_bw() +
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  ggtitle("Payroll vs Wins in the NHL") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  ylab("Average Wins Per Season") + xlab("Payroll Per Season (in Millions)") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_text(size=4,colour="#535353",face="bold",vjust=-.5)) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank())  +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "NHLpayrollandwins.png",
  width     = 2.13,
  height    = 1.42,
  units     = "in",
  res       = 600 ,
  pointsize = 4
)
par(
  mar      = c(5, 5, 2, 2),
  xaxs     = "i",
  yaxs     = "i",
  cex.axis = 2,
  cex.lab  = 2
)
nhl
dev.off()

mlb <- ggplot(data=Wins_vs_Salary_MLB, aes(x = TeamSalary/1000000, y = Wins)) +
  geom_point(stat="identity", colour="#00bdc4", size=.01) +  theme_bw() +
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  ggtitle("Payroll vs Wins in the MLB") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  ylab("Average Wins Per Season") + xlab("Payroll Per Season (in Millions)") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_text(size=4,colour="#535353",face="bold",vjust=-.5)) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank())  +
  geom_hline(yintercept=0,size=.5,colour="#535353") 

png(
  "MLBpayrollandwins.png",
  width     = 2.13,
  height    = 1.42,
  units     = "in",
  res       = 600 ,
  pointsize = 4
)
par(
  mar      = c(5, 5, 2, 2),
  xaxs     = "i",
  yaxs     = "i",
  cex.axis = 2,
  cex.lab  = 2
)
mlb
dev.off()


############# 2017 Salary Caps ################


# 2017 Salary Caps
league <- c('NBA','NFL','NHL','MLB')
salarycap17 <- c(94.1,155.27,73.0,189)

salarycaps17 <- data.frame(league, salarycap17)
salarycaps17 <- salarycaps17[order(-salarycaps17$salarycap17),]

salarycapbyleague <- ggplot(data=salarycaps17, aes(x=reorder(league, -salarycap17), y=salarycap17)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black", size=.1, fill="#00bdc4", width = .5) +
  theme_bw() +
  theme(panel.background=element_rect(fill="#F0F0F0")) +
  theme(plot.background=element_rect(fill="#F0F0F0")) +
  theme(panel.border=element_rect(colour="#F0F0F0")) +
  ggtitle("2017 Salary Cap by League") +
  theme(plot.title=element_text(face="bold",hjust=-.08,vjust=2,colour="#3C3C3C",size=5)) +
  ylab("Salary Cap (in Millions)") + xlab("League") +
  theme(axis.text.x=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.text.y=element_text(size=4,colour="#535353",face="bold")) +
  theme(axis.title.y=element_text(size=4,colour="#535353",face="bold",vjust=1.5)) +
  theme(axis.title.x=element_blank()) +
  theme(panel.grid.major=element_line(colour="#D0D0D0",size=.2)) +
  theme(axis.ticks=element_blank()) +
  geom_hline(yintercept=0,size=.5,colour="#535353")

png(
  "Salarycapbyleague.png",
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
salarycapbyleague
dev.off()

# Competitive Index

competitive_index <- round((x+y+(1-z)+(1-q)+(1-w))/5,2)
competitive_index

#NBA = 0.35
x=(AVGComebackNBA/100)
y=(AVGCloseGameNBA/100)
z=(AVGBlowoutNBA/100)
q=cor(Wins_vs_Salary_NBA$Wins,Wins_vs_Salary_NBA$TeamSalary)
w=NBA_Random_Forest_Model_Accuracy

#MLB = 0.34
x=(AVGComebackMLB/100)
y=(AVGCloseGameMLB/100)
z=(AVGBlowoutMLB/100)
q=cor(Wins_vs_Salary_MLB$Wins,Wins_vs_Salary_MLB$TeamSalary)
w= MLB_Random_Forest_Model_Accuracy
  
#NHL = 0.49
x=(AVGComebackNHL/100)
y=(AVGCloseGameNHL/100)
z=(AVGBlowoutNHL/100)
q=cor(Wins_vs_Salary_NHL$Wins,Wins_vs_Salary_NHL$TeamSalary)
w=NHL_Random_Forest_Model_Accuracy

#NFL = 0.47
x=(AVGComebackNFL/100)
y=(AVGCloseGameNFL/100)
z=(AVGBlowoutNFL/100)
q=cor(Wins_vs_Salary_NFL$Wins,Wins_vs_Salary_NFL$TeamSalary)
w=NFL_Random_Forest_Model_Accuracy




