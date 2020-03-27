library(shinydashboard)
library(shinyWidgets)
library(lubridate)
library(tidyverse)
library(jsonlite)
library(shinyjs)
library(shiny)
library(httr)
library(RCurl)
library(nlme)


# for deployment, it is crucial that the openlattice package is installed 
# from github.
# library(devtools)
# install_github("Lattice-Works/api-clients", subdir="R")

source("Modules/home.R")
source("Functions/data.R")

colors = c(
    '#455aff',
    '#ffe671',
    '#ff3c5d',
    '#00be84',
    '#ff9a58',
    '#dd9e00',
    "#a3adff",
    '#008f63',
    '#80dfc2',
    '#ffb7a2',
    '#6124e2',
    '#44beff',
    '#00bace',
    '#ddb2ff',
    "#ff9a58",
    "#00be84",
    "#bc0000",
    "#a939ff",
    "#ffde00",
    "#f25497",
    "#2f69ff",
    "#00583d"
)

nacol <- "#dcdce7"


data = read_csv("Resources/data.csv", col_types = cols(date = col_date(format = "%Y-%m-%d")))
# data = get_data_from_github()



