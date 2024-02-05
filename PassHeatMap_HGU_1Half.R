library(ggplot2)
library(ggthemes)
library(dplyr)
library(plotly)
library(ggsoccer)
library(hexbin)
library(RColorBrewer)

df <- read.csv("~/Desktop/LCSvHGU/CSV/HGUvLCS_Combined.csv")

#for first half only
lcs.pass1 <- subset(df,Event=='Successful Pass' & Team=='HGU(A)' & Half=='First' )
total.pass <- nrow(lcs.pass1)


visual1<- ggplot(data = lcs.pass1, aes(x=X, y=Y)) + 
  theme_pitch() +
  stat_density2d(aes(fill = ..density..^0.5), geom = "tile", contour = FALSE, n = 200) +
  scale_fill_continuous(low = "green", high = "red")+
  
  #annotatepitch must be bottom of the layer for it to appear.
  annotate_pitch(colour = "white",fill = alpha(0.5))+
  
  #adding the player passing positions to the plot
  geom_point(x=lcs.pass1$X,y=lcs.pass1$Y, aes(color=(factor(Player))),size=2) +
  
  #Labels
  ggtitle("<===== Heatmap for HGU 1st-half Passes" ,subtitle = (label=paste("No. of HGU passes=",total.pass)))+
  labs(color= 'Player')+
  theme(plot.title = element_text(face = "bold"))

print(visual1)

