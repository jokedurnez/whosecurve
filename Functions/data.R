get_data_from_github <- function() {
    date = mdy("01-21-2020")
    fulltable = tibble(
        Province_State = character(),
        Country_region = character(),
        confirmed = integer(),
        deaths = integer(),
        recovered =  integer(),
        date = date()
    )
    
    while (TRUE) {
        date = date + days(1)
        date_string = format(date, "%m-%d-%Y")
        csv_url = paste0(
            "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/",
            "csse_covid_19_data/csse_covid_19_daily_reports/",
            date_string,
            ".csv"
        )
        if (!(url.exists(csv_url))) {
            break
        }
        data <- read.csv(url(csv_url))
        
        if ("Province.State" %in% names(data)) {
            data = data %>%
                rename(Province_State = Province.State,
                       Country_Region = Country.Region)
            
        }
        
        data = data %>%
            group_by(Country_Region) %>%
            summarise(
                confirmed = sum(Confirmed),
                deaths = sum(Deaths),
                recovered = sum(Recovered)
            ) %>%
            ungroup() %>%
            mutate(date = date)
        fulltable = rbind(fulltable, data)
        
    }
    return(fulltable)
}

add_predictions <- function(data, countries, estimated_on) {
    # filtering country
    local_data = data %>% 
        filter(Country_Region %in% countries) %>%
        group_by(Country_Region) %>%
        mutate(
            days_passed = as.double(row_number())
        ) %>%
        ungroup() %>%
        mutate(
            predicted = 0
        )
    
    # add new days after last observation (if necessary)
    for (country in countries){
        maxdate = local_data %>% filter(Country_Region == country) %>% pull(date) %>% max()
        maxind = local_data %>% filter(Country_Region == country) %>% pull(days_passed) %>% max()
        for (dd in 1:30){
            local_data = local_data %>%
                add_row(
                    Country_Region = country,
                    days_passed = maxind + dd,
                    date = maxdate  +days(dd)
                )
        }
    }
    
    # modeling
    
    for (country in countries){
        indat = local_data %>% 
            filter(date <= estimated_on) %>% 
            filter(Country_Region == country)
        result = tryCatch({
            pop.ss <- nls(
                confirmed ~ SSlogis(days_passed, phi1, phi2, phi3), 
                data = indat, 
                start = c(phi1 = 10000, phi2 = 50, phi3 = 1))
            estimates <- coef(pop.ss)
         }, warning = function(w) {
            print("PROBLEM ESTIMATING")
        }, error = function(e) {
            print("PROBLEM ESTIMATING")
        }, finally = {
            print("PROBLEM ESTIMATING")
        })
        
        if (typeof(result) == "double"){
            local_data = local_data %>% mutate(
            predicted = case_when(
                Country_Region == country ~ result[1]/(
                    1 + exp( - ( days_passed - result[2])/result[3])),
                TRUE ~ predicted
                    
                )
            )
        }
    }
    
    
    
    return(local_data)
}

