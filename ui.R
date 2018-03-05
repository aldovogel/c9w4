#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
options(shiny.trace=TRUE) 
#options(shiny.reactlog=TRUE) 
# Define UI for application that draws a histogram

##Slide one

##Slide two

shinyUI(fluidPage(

  # Application title
  titlePanel("Bitcoin Regret Calculator"),
    h1("March 4th 2018"),
    p("The "),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    
    sidebarPanel(
        #daysindataset <- as.numeric(uiOutput("numberofdaysindataset")),
        #daysindataset <- output.daysindataset,
        
        #sliderInput("days","Number of days from today", min = 1, max = numberofdaysindataset, value = 14),
        #checkboxInput("showvolume", "Show Volume", FALSE),
        dateInput("date", "Enter the date on which you first entertained the thought of buying some bitcoin...but didn't.", value= min(csv_bitstamp$Date), min = min(csv_bitstamp$Date), max = max(csv_bitstamp$Date), startview = "year"),
        #p(textOutput("priceonday")),
        sliderInput("buyamountusd", "How much money could you realistically have put into bitcoin at that time?", min = 100, max = 10000, value = 100, pre="$"),
        #p(textOutput("profit"))
        #actionButton("calc", "Calculate profit", icon = icon("bitcoin")),
      fluidRow(column(width=12, tags$span("The price of 1 Bitcoin on", tags$strong(textOutput("buydate")), "was", tags$strong(textOutput("btcpriceonselday")), "USD"))),
      fluidRow(column(width=12, tags$span("Buying", tags$strong(textOutput("buyamount")), " USD worth of BTC and holding it until ", tags$strong(textOutput("datemaxbtcclose")), " and then selling would have made you a profit of ", tags$strong(textOutput("profit")), "Your investment would have increased by a factor of ", tags$strong(textOutput("factor")))))
    ),
        
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(column(width=12, tags$div("Bitcoin price data on ", a(href="https://www.bitstamp.net/","Bitstamp."), " Data from ", a(href="https://www.quandl.com/collections/markets/bitcoin-data", "Quandl.com")))),
      fluidRow(column(width=12, tags$div("Showing bitcoin closing price from",  format(min(csv_bitstamp$Date), "%a %b %d %Y"), " to ", format(max(csv_bitstamp$Date), "%a %b %d %Y")))),
      plotlyOutput("plot")
      #fluidRow(column(width=12, tags$button(textOutput("priceonday")))),
      #fluidRow(column(width=12, tags$h5(textOutput("profit"))))
      )
    )
  )
)