library(ggplot2)
library(dplyr)
library(DT)
library(tidyr)
library(wesanderson)

setwd("C:/Users/sh355/Desktop/shiny")
videogamesales <- read.csv("vgsales.csv")

videogamesales <- videogamesales[!(videogamesales$Year %in% c("N/A", "2017", "2020")),]

videogamesales <- videogamesales %>% gather(Region, Revenue, 7:10)

videogamesales$Region <- factor(videogamesales$Region)

# Function to define the theme use across all the plots in the file.
mytheme_1 <- function() {
  
  return(theme(axis.text.x = element_text(angle = 90, size = 10, vjust = 0.4), plot.title = element_text(size = 15, vjust = 2),axis.title.x = element_text(size = 12, vjust = -0.35)))
  
}
mytheme_2 <- function() {
  
  return(theme(axis.text.x = element_text(size = 10, vjust = 0.4), plot.title = element_text(size = 15, vjust = 2),axis.title.x = element_text(size = 12, vjust = -0.35)))
  
}

ggplot(videogamesales, aes(Year)) + 
  geom_bar(fill = "blue") +
  mytheme_1() +
  ggtitle("Video Game Releases by Year")


revenue_by_year <- videogamesales %>% 
  group_by(Year) %>%
  summarize(Revenue = sum(Global_Sales))

publisher_year <- videogamesales %>% 
  group_by(Year, Publisher) %>% 
  summarize(Revenue = sum(Global_Sales))

platform_year <- videogamesales %>% 
  group_by(Year, Platform) %>% 
  summarize(Revenue = sum(Global_Sales))

platform_year<-as.data.frame(platform_year)

platform_year<-platform_year[-c(239,240),]





shinyServer(function(input, output) {
  
  output$Total<- renderPlot({
  ggplot(revenue_by_year, aes(Year, Revenue)) + 
    geom_bar(fill = "maroon", stat = "identity") +
    ggtitle("Video Game Revenue by Year")+theme(axis.text.x  = element_text(angle=45, vjust=0.5))
  })
  
  
  output$Total2<- renderPlot({
    ggplot(revenue_by_year, aes(Year, Revenue)) + 
      geom_bar(fill = "maroon", stat = "identity") +
      ggtitle("Video Game Revenue by Year")+theme(axis.text.x  = element_text(angle=45, vjust=0.5))
  })
  output$PlatformPlot4<- renderPlot({
    
    ggplot()+geom_point(aes(x=1980:2016, y=psvec))+geom_bar(aes(x=1980:2016, y=psvec), stat="identity", fill="maroon")+labs(x="Year", y="Revenue")+theme(axis.text.x  = element_text(angle=45, vjust=0.5))  })
  


  
  
  output$PlatformPlot<- renderPlot({

  #  barplot(platform_year[,input$select]*1000, 
    a<-platform_year[platform_year$Platform == input$select,]
    c<-a[,3]
    names(c)<-a[,1]
    
    barplot(c,
            main=input$select,
            ylab="Revenue",
            xlab="Year")
  })

  
  output$PlatformPlot2<- renderPlot({
    
  ggplot(data = platform_year[platform_year$Platform %in% input$checkGroup,]) +
    geom_point(mapping = aes(x=Year, y=Revenue, group = Platform, color=Platform),na.rm = TRUE)+
    geom_line(mapping = aes(x=Year, y=Revenue, group = Platform, color=Platform),na.rm = TRUE)+theme(axis.text.x  = element_text(angle=45, vjust=0.5))
    
  })
  

  output$PlatformPlot3<- renderPlot({
    
    ggplot()+geom_point(aes(x=1980:2016, y=psvec))+geom_bar(aes(x=1980:2016, y=psvec), stat="identity", fill="maroon")+labs(x="Year", y="Revenue")+theme(axis.text.x  = element_text(angle=45, vjust=0.5))  })

})




  





ggplot(data = platform_year[platform_year$Platform %in% "PC",]) +
geom_point(mapping = aes(x=Year, y=Revenue, group = Platform, color="PC"),na.rm = TRUE)+
  geom_line(mapping = aes(x=Year, y=Revenue, group = Platform, color="PC"),na.rm = TRUE)

 
#ggplot(data = platform_year[platform_year$Platform == "Wii",]) +
#  geom_line(mapping = aes(x=Year, y=Revenue, group = Platform,color="Wii"))


#ggplot(data = platform_year) +
#  geom_point(mapping = aes(x=platform_year$Year[platform_year$Platform == "PC"], y=platform_year$Revenue[platform_year$Platform == "PC"] ,color="PC"),na.rm = TRUE)


     