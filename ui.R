# Author: Y. Dan Rubinstein
# Date: Mar 20, 2015
# Project assignment for Coursera Data Products Class
# Displays interactive dashboard of cause of death per 100k population in the USA. Data from CDC
# Allows User to select year (or animate across years), and COD

shinyUI(pageWithSidebar(
  headerPanel("CDC Cause of Death (COD) by State and Year"),
  sidebarPanel(
    sliderInput('Year', 'Year:',value = 2012, round = T, 
                animate = T, sep = "", min = 1999, max = 2013, step = 1),
    selectInput("causeOfDeath", "Cause of Death (COD):", width = '70%',
                choices = as.character(levels(cleanData$ICD.Chapter)), 
                selected=as.character(levels(cleanData$ICD.Chapter))[13]),
    
    p('Select a year and a Cause of Death. Hover over any state to see exact number of deaths from the selected COD in the selected year. 
       Hit the play button to see an animation across time for the selected COD.
       Note that the color range is deliberately selected to span the COD rate (for the given COD) across all years to be able to visually compare years on the same visual scale.
      Missing data is denoted by a dark gray color for that state, for that year, for that COD.', style="color: #a2a2a2"),
    p('Created by: Y. Dan Rubinstein for Coursera Data Products class project.', style="color: #a2a2a2"),
    p('Source data obtained from CDC web site:',  style="color: #a2a2a2"),
    a ('http://wonder.cdc.gov/ucd-icd10.html')
  
    ),
  mainPanel(
    h3(textOutput("year")),
    htmlOutput("myMap")
    )
))