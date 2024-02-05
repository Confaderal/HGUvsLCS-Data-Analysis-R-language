library(ggplot2)
library(ggthemes)
library(dplyr)
library(plotly)

#For easier access, put the CSV file on the desktop.On desktop I put the file in a folder called "LCSvHGU" and in a subfolder called "CSV".
#For windows users, the path should use 'double backslashes' like this within the apostrophes- C:\\Users\\Admin\\Desktop\\LCSvHGU\\CSV\\HGUvLCS_Combined.csv
df <- read.csv("~/Desktop/LCSvHGU/CSV/HGUvLCS_Combined.csv")

mask_df <- subset(df,Event=='Shot') 
lcsMask <- subset(mask_df,Team=='LCS(H)')
hguMask <- subset(mask_df,Team=='HGU(A)') 
hgu <-nrow(hguMask)
lcs <-nrow(lcsMask)


analysis <- ggplot (mask_df,aes( x=On.Off.target.or.Saved, y=Player,color=Team)) + geom_count(size=5)

#To have a number label for recurring variables. i.e. 2 shots saved by the same player
soccer.analysis <- analysis + geom_text(data = ggplot_build(analysis)$data[[1]], 
                                        aes(x, y, label = n), color = "#ffffff")

#Add header. 0.5 is in the middle, 1 is at right-aligned
shot.analysis <-soccer.analysis + 
  ggtitle("Total shots",subtitle = (label=paste("Total LCS Shots=",lcs,"HGU shots",hgu,"\nGoals count towards the Shotcount")))+ theme(plot.title = element_text(face = "bold"))

print(shot.analysis)
#gpl <- ggplotly(analysis)
#print(gpl)