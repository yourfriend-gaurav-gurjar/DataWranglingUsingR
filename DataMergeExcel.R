###########################################################################################################################################
# Loading the data into R
###########################################################################################################################################
library(readr)
library(readxl)
# bd_df <- read_csv("/media/gurjar/Gaurav-HDD/Practice-R/Jeremy McClane/board_data_sample.csv", na = c("", "NA", "UNKNOWN"))
bd_df <- read_csv("/media/gurjar/Gaurav-HDD/Practice-R/Jeremy McClane/board_data_sample.csv")
# ceo_df <-read_xlsx("/media/gurjar/Gaurav-HDD/Practice-R/Jeremy McClane/Equilar All Company CEO Data for U Wisconsin on 8.17.2018.xlsx", na = c("", "NA", "UNKNOWN"))
ceo_df <-read_xlsx("/media/gurjar/Gaurav-HDD/Practice-R/Jeremy McClane/Equilar All Company CEO Data for U Wisconsin on 8.17.2018.xlsx")
###########################################################################################################################################
# Pulling the sample data out of Loaded datasets
###########################################################################################################################################
bd_df
ceo_df
sampl_bd_df <- head(bd_df)
sampl_ceo_df <- head(ceo_df)
sampl_bd_df
sampl_ceo_df
###########################################################################################################################################
# Setting up the dates fields in sampl_bd_df 
###########################################################################################################################################
# sampl_bd_df$date_startrole <- dmy(sampl_bd_df$date_startrole)
# sampl_bd_df$date_endrole <- dmy(sampl_bd_df$date_endrole)
sampl_bd_df$date_startrole <- as.POSIXct(sampl_bd_df$date_startrole)

sampl_ceo_df$start_date_CEO <- dmy(sampl_ceo_df$start_date_CEO)
sampl_ceo_df$stop_date_CEO <- dmy(sampl_ceo_df$stop_date_CEO)
sampl_ceo_df
    
head(bd_df)
head(ceo_df)

###########################################################################################################################################
# Creating Data Frames of sampl_bd_df and sampl_ceo_df
###########################################################################################################################################
bd_df <- as.data.frame(bd_df)
bd_df
ceo_df <- as.data.frame(ceo_df)


###########################################################################################################################################
# Applying the merge operation on sample data
###########################################################################################################################################

merged.df <- sampl_ceo_df %>% add_row(company_name = sampl_bd_df$company_name, 
                                company_id = sampl_bd_df$companyid,
                                name = sampl_bd_df$directorname,
                                title = sampl_bd_df$rolename,
                                start_date_CEO = sampl_bd_df$date_startrole,
                                stop_date_CEO = sampl_bd_df$date_endrole
                              )
