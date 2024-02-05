library(ggplot2)
library(ggthemes)
library(dplyr)
library(plotly)
library(ggsoccer)
library(hexbin)
library(RColorBrewer)
library(tidyr)
library(forcats)
library(ggforce)

df <- read.csv("~/Desktop/LCSvHGU/CSV/HGUvLCS_Combined.csv")

#Mask the appropriate data according to HALF
LCS.Poss1 <- subset(df,Event=='Possession Lost' & Team=='HGU(A)' & Half=='Second' )

#These names function names need to swap around when changing half.e.g.oneSixth>>fullSixth
#to calculate how much posession lost in coord x(0-17)
oneSixth <- with(LCS.Poss1,c(sum(X >= 0 & X <=17)))
#to calculate how much posession lost in coord x(18-35)
twoSixth <- with(LCS.Poss1,c(sum(X >= 18 & X <=35)))
#to calculate how much posession lost in coord x(36-50)
threeSixth <- with(LCS.Poss1,c(sum(X >= 36 & X <=50)))
#to calculate how much posession lost in coord x(51-68)
fourSixth <- with(LCS.Poss1,c(sum(X >= 51 & X <=68)))
#to calculate how much posession lost in coord x(69-86)
fiveSixth <- with(LCS.Poss1,c(sum(X >= 69 & X <=86)))
#to calculate how much posession lost in coord x(86-100)
fullSixth <- with(LCS.Poss1,c(sum(X >= 86 & X <=100)))

#Make into one new dataframe.Change pos.Index on 2nd Half
pos.Value <- c(oneSixth,twoSixth,threeSixth,fourSixth,fiveSixth,fullSixth)
pos.Name <- c('oneSixth','twoSixth','threeSixth','fourSixth','fiveSixth','fullSixth')
pos.Index <- c(1:6)
#Combine newdf to LCS.Poss1 dataframe
LCS.data <- data.frame(pos.Name,pos.Value,pos.Index)

#Tell R to respect & follow order of our pos.Name
LCS.data$pos.Name <- factor(LCS.data$pos.Name, levels = LCS.data$pos.Name[order(LCS.data$pos.Index)])

#Print out the barchart according to a specific order of the pitch
visual1<-  ggplot(LCS.data, aes(x=pos.Name,y=pos.Value))+  
  
  #add these 3 lines if you wanna check the individuals that lost posession per area
  #theme_pitch() +
  #annotate_pitch(fill = alpha(0.5))+
  #geom_point(x=LCS.Poss1$X,y=LCS.Poss1$Y, aes(color=(factor(Player))),size=2) +
  
  geom_col(color='orange',fill='orange')+
  #Adding labels and percentage sign to bar graph
  geom_text(aes(label =paste(round((pos.Value/sum(pos.Value))*100,digits=1),"%")
                ,vjust = 1.5), position = position_dodge(0.9))+
  
  #Manually drawing the soccerpitch
  geom_segment(aes(x = 0.5, xend = 6.5, y = 0, yend = 0),color='gray')+ 
  geom_segment(aes(x = 0.5, xend = 6.5, y = 9, yend = 9),color='gray')+ 
  geom_segment(aes(x = 6.5, xend = 6.5, y = 0, yend = 9),color='gray')+
  geom_segment(aes(x = 0.5, xend = 0.5, y = 0, yend = 9),color='gray')+
  geom_segment(aes(x = 3.5, xend = 3.5, y = 0, yend = 9),color='gray')+
  geom_segment(aes(x = 1.4, xend = 1.4, y = 2.5, yend = 6.5),color='gray')+
  geom_segment(aes(x = 0.5, xend = 1.4, y = 2.5, yend = 2.5),color='gray')+
  geom_segment(aes(x = 0.5, xend = 1.4, y = 6.5, yend = 6.5),color='gray')+
  geom_segment(aes(x = 5.6, xend = 5.6, y = 2.5, yend = 6.5),color='gray')+
  geom_segment(aes(x = 5.6, xend = 6.5, y = 6.5, yend = 6.5),color='gray')+
  geom_segment(aes(x = 5.6, xend = 6.5, y = 2.5, yend = 2.5),color='gray')+
  geom_ellipse(aes(x0 = 3.5, y0 = 4.5, a = 0.55, b = 1.4, angle = 0),inherit.aes=FALSE,color='gray',alpha=0.1)+
  
  
  #Labels to change when the half changes
  ggtitle("Posession Lost(HGU 2nd-Half) ====>" 
          ,subtitle = 'Lost Posession:Player receiving the ball fails to hold onto it')+
  theme(plot.title = element_text(face = "bold"))+
  labs(x="Soccer Pitch divided by Six",y="No. of times posession lost")

#Print results
print(visual1)

