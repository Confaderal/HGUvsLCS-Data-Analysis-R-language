library(ggplot2)
library(ggthemes)
library(dplyr)
library(plotly)
library(ggsoccer)

df <- read.csv("~/Desktop/LCSvHGU/CSV/HGUvLCS_Combined.csv")

set.piece <- subset(df,Event=='Set Piece' )


#Use a pitch background and plot the passes
final.plot <- ggplot(set.piece,aes(color=Team, size = Half )) +
  annotate_pitch(colour = "black") +
  
  #y axis needs to be flipped coz https://fcpythonvideocoder.netlify.app/ has a reversed y-axis.
  geom_point( aes(x = X, y = 100 - Y)) +
  
  
  #theme_pitch() +
  theme(panel.background = element_rect(fill = "#3ab54a"), plot.title = element_text(hjust=0.5)) +
  
  ggtitle("Set Piece areas( Full 90 mins)" ,subtitle = 'Direction of LCS 1st Half attack =======>\n<====== Direction of HGU 1st Half attack')+ 
  theme(plot.title = element_text(face = "bold"))


#print
print(final.plot)
#fin.plotly <- ggplotly(final.plot)
#print(fin.plotly)
