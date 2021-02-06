library(xml2)
library(tidyverse)
library(glue)
library(fs)
library(XML)

options(dplyr.summarise.inform=F)
# Set download folder for  .xml file
carpetaDescarga1 <- "carpetaDescarga1/"

# At the moment script downloads 1 file for each day (Info from 1st Jannuary 2019 is needed
# til today)
a <- 1
for (i in 1:a) {
  
  # Generamos las fechas para la URL de descarga y el nombre del fichero descargado
  start_date <- format(Sys.Date() - i, "%d-%m-%Y")
  end_date <- format(Sys.Date() - i, "%d-%m-%Y")
  file_date  <- gsub(pattern = "\\-",
                     replacement = "",
                     x = Sys.Date() - i)
  
  # Set filename to download
  file_input <- paste0(carpetaDescarga1, "p48cierre_", file_date, ".xml")
  
  # Generate URL to download
  url_to_download <- 
    paste0(
      "https://api.esios.ree.es/archives/107/download?date_type=datos&start_date=",
      start_date,
      "&end_date=",
      end_date
    )
  
  # Download url to folder 1
  download.file(url = url_to_download, destfile = file_input, method = "curl")
}

file_paths <- dir_ls("carpetaDescarga1/") 

# Today's data
for (i in seq_along(file_paths)) {
  today_data <- plyr::ldply(xmlToList(file_paths[[i]]), data.frame)
  vroom::vroom_write(today_data, "output/allData.csv", append = T)
}


# You can run this script everyday and the data will appended automatically.

