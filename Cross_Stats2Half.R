library(ggplot2)
library(ggthemes)
library(dplyr)
library(plotly)
library(ggsoccer)

df <- read.csv("~/Desktop/LCSvHGU/CSV/HGUvLCS_Combined.csv")

cross.map <- subset(df,Event=='Cross' & Half=='Second')
lcs.cross <- subset(cross.map, Team=='LCS(H)')
hgu.cross <- subset(cross.map, Team=='HGU(A)')
crossLCS <- nrow(lcs.cross)
crossHGU <- nrow(hgu.cross)
cross.map$X2 <- as.numeric(cross.map$X2)
cross.map$Y2 <- as.numeric(cross.map$Y2)

#Use a pitch background and plot the passes
final.plot <- ggplot(cross.map,aes(color=Cross.successful.or.blocked, linetype=Team,)) +
  annotate_pitch(colour = "black") +
  
  #need to flip the y-axis as the data's pitch is inverted.
  geom_segment(aes(x = X, y = 100 -Y, xend = X2, yend = 100 -Y2),
               arrow = arrow(length = unit(0.3, "cm"),
                             type = "closed")) +
  theme_pitch() +
  theme(panel.background = element_rect(fill = "#3ab54a"), plot.title = element_text(hjust=0.5)) +
  
  ggtitle("Crosses per half", subtitle = '<====LCS/HGU====> Second Half')+
  theme(plot.title = element_text(face = "bold"))+
  annotate('text',7,4,
           label=paste("No. of LCS crosses=",crossLCS),
           parse=FALSE,
           hjust=0.4, size=3.5)+
  annotate('text',7,9,
           label=paste("No. of HGU crosses=",crossHGU),
           parse=FALSE,
           hjust=0.4, size=3.5)


#print
print(final.plot)
#fin.plotly <- ggplotly(final.plot)
#print(fin.plotly)
