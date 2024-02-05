library(ggplot2)
library(ggthemes)
library(dplyr)
library(plotly)
library(ggsoccer)
library(hexbin)
library(RColorBrewer)

df <- read.csv("~/Desktop/LCSvHGU/CSV/HGUvLCS_Combined.csv")

#for first half only
interception <- subset(df,Event=='Interception' & Half=='Second' )
lcs.int <- subset(interception, Team=='LCS(H)')
hgu.int <- subset(interception, Team=='HGU(A)')
intLCS <- nrow(lcs.int)
intHGU <- nrow(hgu.int)


visual1<- ggplot(data = interception, aes(x=X, y=Y)) + 
  theme_pitch() +
  stat_density2d(aes(fill = ..density..^0.5), geom = "tile", contour = FALSE, n = 200) +
  scale_fill_continuous(low = "green", high = "red")+
  
  #annotatepitch must be bottom of the layer for it to appear.
  annotate_pitch(colour = "white",fill = alpha(0.5))+
  
  #adding the player passing positions to the plot
  geom_point(x=interception$X,y=interception$Y, aes(color=Team),size=2) +
  
  #Labels
  ggtitle("2nd-half interceptions <===LCS/HGU===>" ,subtitle = (label=paste("No. of LCS interceptions=",intLCS,"\nNo. of HGU interceptions=",intHGU)))+
  theme(plot.title = element_text(face = "bold"))
#+annotate('text',50,4,
#label=paste("No. of LCS interceptions=",intLCS),
#parse=FALSE,
#hjust=0.4, size=3.5)+

#annotate('text',50,9,
#label=paste("No. of ALB interceptions=",intALB),
#parse=FALSE,
#hjust=0.4, size=3.5)

print(visual1)

