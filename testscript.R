# set to local directory
#setwd("/Users/jokedurnez/openlattice/shiny/curve/")
source('global.R')

# global.R reads in data
data = read_csv("Resources/data.csv")

# data = get_data_from_github()

countries = c( "Belgium", "Spain")
estimated_on = max(data$date[!is.na(data$confirmed)])
local_data = data %>% add_predictions(countries, estimated_on)

ggplot(local_data)+
    geom_line(aes(x=date, y=predicted, color = Country_Region), lwd = 2, alpha = 0.2)  +
    geom_point(aes(x = date, y = confirmed, color = Country_Region),size = 2) + 
    theme_minimal()

