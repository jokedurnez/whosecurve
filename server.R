server <- shinyServer(function(input, output, session) {

    

    # observe({
        # if (dim(data$fulldata)[1] > 0){
            callModule(home_server, "home")
          # }
    # })

    
    
})
