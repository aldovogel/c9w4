#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
#options(shiny.trace=TRUE) 
#options(shiny.reactlog=TRUE) 

shinyUI(fluidPage(
  titlePanel("Bitcoin Regret Calculator"),
    h3("March 5th 2018"),
    p("The below application takes one year worth of bitcoin pricing data and allows the user to select a date from within that range and calculates 
      the profit made if the user would have spend an x amount of US dollar buying bitcoin (input by user using a slider) and then selling on bitcoin's 
      highest closing price (dec 16th 2017). Or if a date is selected that falls after that point how much the user would profit if the bitcoin price ever
      reached that height again in the future."),
  sidebarLayout(
    sidebarPanel(
        #show volume checkbox, not useful anymore
        #checkboxInput("showvolume", "Show Volume", FALSE),
      
        dateInput("date", "Enter the date on which you first entertained the thought of buying some bitcoin...but didn't.", value= min(csv_bitstamp$Date), min = min(csv_bitstamp$Date), max = max(csv_bitstamp$Date), startview = "year"),
        sliderInput("buyamountusd", "How much money could you realistically have put into bitcoin at that time?", min = 100, max = 10000, value = 100, pre="$"),

      fluidRow(column(width=12, tags$span("The price of 1 Bitcoin on", tags$strong(textOutput("buydate")), "was", tags$strong(textOutput("btcpriceonselday")), "USD"))),
      fluidRow(column(width=12, tags$span("Buying", tags$strong(textOutput("buyamount")), " USD worth of BTC and holding it until ", tags$strong(textOutput("datemaxbtcclose")), " and then selling would have made you a profit of ", tags$strong(textOutput("profit")), "Your investment would have increased by a factor of ", tags$strong(textOutput("factor")))))
    ),
        
    # Show a plot and some info on the dataset used
    mainPanel(
      fluidRow(column(width=12, tags$div("Bitcoin price data on ", a(href="https://www.bitstamp.net/","Bitstamp."), " Data from ", a(href="https://www.quandl.com/collections/markets/bitcoin-data", "Quandl.com")))),
      fluidRow(column(width=12, tags$div("Contains data on bitcoin price from",  format(min(csv_bitstamp$Date), "%a %b %d %Y"), " to ", format(max(csv_bitstamp$Date), "%a %b %d %Y")))),
      plotlyOutput("plot")
      )
    )
  )
)