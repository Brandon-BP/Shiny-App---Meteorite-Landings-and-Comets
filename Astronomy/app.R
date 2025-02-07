#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shiny)
library(shinythemes)
library(tidyverse)
library(lubridate)
library(usmap)
library(ggplot2)
library(shinyWidgets)
library(scales)
library(rnaturalearthdata)
library(rnaturalearth)
library(rworldmap)
library(Cairo)
library(RColorBrewer)
library(plotly)
library(highcharter)
library(magrittr)



# Imported Datasets

fireball <- read.csv("cneos_fireball_data.csv")
meteor <- read.csv("Meteorite_Landings.csv")
stars <- read.csv("SDSS_stars.csv")
test <- read.csv("SDSS_test.csv")
wd <- read.csv("SDSS_wd.csv")
p = "https://astrostatistics.psu.edu/MSMA/datasets/asteroid_dens.dat"
sp = read.table(p, header = TRUE) 
r = "https://astrostatistics.psu.edu/MSMA/datasets/NGC4406_profile.dat"
gal = read.table(r, header = TRUE) 
f = "https://astrostatistics.psu.edu/MSMA/datasets/NGC4472_profile.dat"
gal2 = read.table(f, header = TRUE) 


# Define UI for application that draws a histogram
ui <- navbarPage("Astronomy Research App", theme = shinytheme("flatly"),
               tabPanel("Home", tags$head(tags$style(HTML(".tab-content {margin: 20px;}"))),
                        "This App is designed for the purposes of further analysis and observation of astronomical objects enetering or being within cetain distance of Earth's atmoshphere. Specfically we are looking at datasets distrbuted by NASA involving observations of meterorite Landings and Bolides.",
                        tags$a(href = "https://neo-bolide.ndc.nasa.gov/#/", "Click here for further information in regards to NASA's work in Bolide Detections."),
                        tags$a(href = "https://data.nasa.gov/Space-Science/Meteorite-Landings/ak9y-cwf9", "Click here also for further information in regards to NASA's work in dectecting meteorite landings from the Meteoritical Society."),
                        
                        
                        #Images of Bollides and Meteorites for further reference 
                        h1("Bolide Visuals"),
                        tags$h1("The best way to define a bolide is as an extremely bright meteor, especially one that explodes in the astmosphere."),
                
                        tags$img(src = "https://cm-web-news-files.s3.amazonaws.com/uploads/2018/01/story-meteor-featured-1200x630.jpg", height = 400, width = 600),
                        tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/1/17/Meteor_Bolide.JPG", height = 400, width = 600),
                        tags$img(src ="https://cdn.mos.cms.futurecdn.net/bRz2QRqX4Agjmzj2YMMn75-320-80.jpg", height = 400, width = 600 ),
                        tags$img(src ="https://cdn.mos.cms.futurecdn.net/hgBLQ9i79UGcixm6vdMAiF-1200-80.jpg", height = 400, width = 600 ),
                        
                        h1("Meteorite Visuals"),
                        tags$h1("A meteorite is a solid like piece of debris from an object such as a comet, asteroid or even a meteoroid that was from outer space and manages to survive its passage through the atmoshphere and reaches the surface or a planet or moon"),
                        tags$img(src = "https://lh6.googleusercontent.com/proxy/t0PkIaO0q53pAy_fd8pfJaqWqfv_vNfD97vBEdTeSOM0N4FlQS-yTXhF-A85aJTi1oqiLGdFpn10VZkDvJii2t2doTYD9xtKmIza1OmjzQJb6wJq=w1200-h630-p-k-no-nu", height = 400, width = 600),
                        tags$img(src = "https://i.ytimg.com/vi/dvd47rMYia0/maxresdefault.jpg", height = 400, width = 600),
                        
                        tags$div(
                        #Further links for reference
                        h1("Here are Further links on information in regards to bolides and Meteorites"),
                        tags$br(),
                        tags$a(href = "https://solarsystem.nasa.gov/asteroids-comets-and-meteors/meteors-and-meteorites/overview/?page=0&per_page=40&order=id+asc&search=&condition_1=meteor_shower%3Abody_type","Click here for SolarSytem.gov"),
                        tags$br(),
                        tags$a(href = "https://www.meteorite.com/", "meteorite.com"),
                        tags$br(),
                        tags$a(href = "https://bgr.com/2020/11/30/japan-fireball-bolide-meteor/", "fireball in Japan"),
                        tags$br(),
                        tags$a(href = "https://astronomy.com/news/2004/05/anatomy-of-a-bolide", "Astronomy News"),
                        ),
                        
               ),
               
               
               
      
               tags$img(src = "http://objekty.astro.cz/obr/objekty/ngc/n4406.jpg", height = 400, width = 600),
               h1("NGC4406 Data Scatter Plot"),
               sliderInput("myslider","Value Specification Range", min = 1 ,max = 25, value = 10),
               plotlyOutput("myplot")
               
               
           
               
               
              
                        

               
              
               
               
               
               
               
               
)



server <- function(input, output,session) {
  dat <- reactive(gal[1:input$myslider,])
  
  output$myplot <- renderPlotly({
    p <- ggplot(dat(), aes(radius, surf_mag)) + geom_point(color = "red")
    p <- ggplotly(p)
    p
    
  })
  


}

shinyApp(ui = ui, server = server)


