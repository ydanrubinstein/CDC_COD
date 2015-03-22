# Author: Y. Dan Rubinstein
# Date: Mar 20, 2015
# Project assignment for Coursera Data Products Class
# Displays interactive dashboard of cause of death per 100k population in the USA. Data from CDC
# Allows User to select year (or animate across years), and COD

library(shiny)
library(googleVis)



# for each COD, bucket the death rate across all years  
# so the color mapping and legend are consistent across any choice of Year 
myCut = cut(as.numeric(cleanData$Death.Rate), NUMBUCKETS) 
colorBuckets = as.numeric(myCut)
legend.text = levels(myCut)
myColors = colorRampPalette(c("green", "white", "red"))(NUMBUCKETS)

shinyServer(function(input, output) {
  myYear =  reactive({
    input$Year
  })
  output$year = renderText({
    paste("Deaths per 100,000 in", myYear(), "from", input$causeOfDeath)
  })
  
  
  output$myMap = renderGvis({
    #extract the data of interest (DOI) for a specific cause of death
    causeOfDeath = input$causeOfDeath 
    DOI = cleanData[(cleanData$ICD.Chapter == causeOfDeath) & (Year == myYear()),]
    maxValue = max(cleanData[(cleanData$ICD.Chapter == causeOfDeath), "Death.Rate"])
    
    gg = gvisGeoChart(DOI, locationvar="State", colorvar="Death.Rate",
                      options=list(region="US", displayMode="regions",
                                   colorAxis = paste("{minValue: 0, maxValue:", maxValue," , colors: ['green', 'white', 'red']}"),
                                   resolution="provinces",   
                                   datalessRegionColor = "929292",
                                   width=600, height=400))
    gg
  })
})
