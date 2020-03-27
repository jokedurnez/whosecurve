source("global.R")

ui <- tagList(
    useShinyjs(),
    # extendShinyjs(text = jscode),
    navbarPage(
        id = "navbar",
        title =
            div(
                "Flattening The Curve"
            ),
        fluid = FALSE,
        windowTitle = "Flattening The Curve",
        header = tags$head(
            tags$style(HTML(
                "#page-nav > li:first-child { display: none; }"
            )),
            tags$link(rel = "stylesheet", type = "text/css", href = "AdminLTE.css"),
            tags$link(rel = "stylesheet", type = "text/css", href = "shinydashboard.css"),
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
            tags$link(rel = "icon", type = "image/png", href = "favicon.png"),
            tags$script(src = "https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js")
        ),
        theme = "custom.css",
        
        tabPanel(
            tags$style("html, body {overflow: visible !important;"),
            tags$style(
                "
                       body {
                       -moz-transform: scale(0.75, 0.75); /* Moz-browsers */
                       zoom: 0.8; /* Other non-webkit browsers */
                       zoom: 80%; /* Webkit browsers */
                       }
                       "
            ),
            title = "Home",
            # fluidRow(column(
            #     width = 12,
            #     box(
            #         width = 12,
            #         title = "Whose curve is this curve??",
            #         tags$p("Dashboard Introduction."),
            #         p(
            #             id = "status",
            #             "",
            #             align = "center",
            #             class = "html_status"
            #         )
            #     )
            # )),
            
            # tabsetPanel(
                # type = "pills",
                home_ui("home")

                
            # )
        )
    )
    
    
)