home_ui <- function(id) {
    ns <- NS(id)
    # tabPanel("Curving",
    #          tags$style("html, body {overflow: visible !important;"),
             fluidRow(
                  column(
                     width =12,
                     box(
                         width = 12,
                         title = "Whose Curve is This Curve?",
                         p("This dashboard is based on a medium post by Jacob !", tags$a(href = "https://medium.com/@jacob.denolf/hi-belgium-how-is-your-curve-doing-today-1f9c380de491","You can find it here !")
                     ),
                     p("THe data is taken from ", tags$a(href = "https://github.com/CSSEGISandData/COVID-19"), "Johns Hopkins CSSE." )
                     ),
                     box(
                         width = 12,
                         title = "The Curve",
                         uiOutput(ns("days_ago")),
                         plotOutput(ns("curve")),
                         uiOutput(ns("country"))
                     )
                  )
                 
             )
    
    
}

home_server <- function(input,
                        output,
                        session) {
    ns <- session$ns
    

    ####################
    ## OUTPUT OBJECTS ##
    ####################
    
    output$days_ago <- renderUI({
        sliderInput(ns("days_ago"), label = "How many days ago", min =-10,
                    max = 0, value = 0)
    })

    output$country <- renderUI({
        checkboxGroupButtons(
            inputId = ns("country"),
            "Select more countries:",
            choices = data$Country_Region %>% unique %>% sort,
            selected = c( "Belgium", "Spain", "France"),
            justified = FALSE
        )
    })
    
    output$curve <-
        renderPlot({
            if (!is.null(input$country)){
            country = input$country
            estimated_on = max(data$date[!is.na(data$confirmed)]) + days(input$days_ago)
            
            local_data = data %>% add_predictions(country, estimated_on)
            
            ggplot(local_data)+
                geom_line(aes(x=date, y=predicted, color = Country_Region), lwd = 2, alpha = 0.2)  +
                geom_point(aes(x = date, y = confirmed, color = Country_Region),size = 2) + 
                theme_minimal()  +
                theme(legend.position="bottom")
            }
            
        }, res=100)

}