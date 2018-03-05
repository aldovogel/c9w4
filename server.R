library(shiny)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$plot <- renderPlotly({
      #output$numberofdaysindataset <- reactive({TRUE})
      #days <- input$days
      
      selectedDay <- nrow(csv_bitstamp) - which(csv_bitstamp$Date ==input$date)
      dayrange <- selectedDay:nrow(csv_bitstamp)
      
      #get btc price on selected day
      btcPriceOnSelDay <- round(csv_bitstamp[which(csv_bitstamp$Date ==input$date),]$Close, digits = 2)
      
      buydate <- format(input$date, "%a %b %d %Y")
      
      #find maximum closing price in datasite
      maxBtcClose <- max(csv_bitstamp$Close)
      dateMaxBtcClose <- format(csv_bitstamp[csv_bitstamp$Close == maxBtcClose,]$Date, "%a %b %d %Y")
      
      #get BTC price on date input
      srow <- which(csv_bitstamp$Date == input$date)
      price <- csv_bitstamp[srow,]$Close
      
      #get amount of BTC bought on date and calculate profit
      btcbought <- input$buyamountusd/price
      profit <- round(btcbought*maxBtcClose - input$buyamountusd, digits = 2)

      #text outputs
      output$buydate <- renderText({buydate})
      output$btcpriceonselday <- renderText({paste0("$", formatC(as.numeric(btcPriceOnSelDay), format="f", digits=2, big.mark = ","))})
      output$buyamount <- renderText({paste0("$", formatC(as.numeric(input$buyamountusd), format="f", digits=2, big.mark = ","))})
      output$datemaxbtcclose <- renderText({dateMaxBtcClose})
      output$profit <- renderText({paste0("$", formatC(as.numeric(profit), format="f", digits=2, big.mark = ","))})
      output$factor <- renderText({paste(round(profit/input$buyamountusd, digits=2), "x")})
      
      #plot
      p <- plot_ly(data = csv_bitstamp, x = csv_bitstamp$Date[dayrange], y = csv_bitstamp$Close[dayrange], type = "scatter", mode = "lines", showlegend = TRUE, name = "BTC Closing Price") %>%
          add_trace(y = ~High[dayrange], type="scatter", mode="lines", fill = "tonexty", fillcolor = "rgba(0,100,80,0.2)", line = list(color="transparent"), showlegend = TRUE, name="Day High") %>%
          add_trace(y = ~Low[dayrange], type="scatter", mode="lines", fill = "tonexty", fillcolor = "rgba(0,100,80,0.2)", line = list(color="transparent"), showlegend = TRUE, name="Day Low")
          
          #toggle for showing volume in plot, not used anymore
          #if(input$showvolume){
          #  p <- p %>% add_trace(x = csv_bitstamp$Date[dayrange], y = csv_bitstamp$Volume..BTC.[dayrange]/10, type="bar", name = "Volume BTC x 10")
          #}
        
      p$elementId <- NULL 
      p
  })
  
})
