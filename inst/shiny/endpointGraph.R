endpointGraph_create <- reactive({
  filterBy <- input$epGroup
  meanEARlogic <- as.logical(input$meanEAR)
  hitThres <- hitThresValue()
  chemicalSummary <- chemicalSummary()
  catType = as.numeric(input$radioMaxGroup)
  
  endpointGraph <- plot_tox_endpoints(chemicalSummary, 
                                      category = c("Biological","Chemical","Chemical Class")[catType],
                                      mean_logic = as.logical(input$meanEAR),
                                      hit_threshold = hitThresValue(),
                                      filterBy = filterBy) 
  return(endpointGraph)
})

output$endpointGraph <- renderPlot({ 
  
  validate(
    need(!is.null(input$data), "Please select a data set")
  )
  
  print(endpointGraph_create())
})

output$endpointGraph.ui <- renderUI({
  
  height <- PlotHeight_ep()
  
  plotOutput("endpointGraph", height = height, width = "100%")
})

PlotHeight_ep = reactive({
  
  filterBy <- input$epGroup
  catType = as.numeric(input$radioMaxGroup)
  cat_col <- c("Bio_category","chnm","Class")[catType]
  
  chemicalSummary <- chemicalSummary()
  
  if(filterBy != "All"){
    chemicalSummary <- chemicalSummary %>%
      filter_(paste0(cat_col," == '", filterBy,"'"))
  }
  
  n <- 35*length(unique(chemicalSummary$endPoint))
  
  if(n < 500){
    return(500)
  } else {
    return(n)
  }
  
})

output$downloadEndpoint <- downloadHandler(
  
  filename = "endPoint.png",
  
  content = function(file) {
    device <- function(..., width, height) {
      grDevices::png(..., width = width, height = height,
                     res = 300, units = "in")
    }
    ggsave(file, plot = endpointGraph_create(), device = device)
  }
)