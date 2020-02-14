library(dplyr)
board_sample_data <- read_csv("/home/gaurav/board_data_sample.csv")
bd_full_df <- read_xlsx("/home/gaurav/Equilar All Company Director Data for U Wisconsin 8.17.2018.xlsx")
ceo_full_df <- read_xlsx("/home/gaurav/Equilar All Company CEO Data for U Wisconsin on 8.17.2018.xlsx")

glimpse(board_sample_data)
glimpse(bd_full_df)
glimpse(ceo_full_df)
filtered_board_sample_data <- board_sample_data %>%
  select(company_name, cik, companyid, ticker, directorid, directorname, companyname, rolename, date_startrole, date_endrole)
filtered_board_sample_data  

filtered_bd_df <- bd_full_df %>%
  select(Company_Id, Executive_Id, Director_Id, Company_Name, Ticker, Name, Is_Chair, Is_Vice_Chair, Is_Lead_Director, Is_Audit_Cmte_Spec, Is_Cmte_Chair)

filtered_ceo_df <- ceo_full_df %>%
  select(company_id, management_id, executive_id, company_name, ticker, name, title, is_resigned, start_date_CEO, stop_date_CEO, Co_Chief_CEO, Former_CEO)

names(filtered_ceo_df)[names(filtered_ceo_df) == "company_name"] <- "Company_Name" 
names(filtered_ceo_df)[names(filtered_ceo_df) == "company_id"] <- "Company_Id" 
names(filtered_ceo_df)[names(filtered_ceo_df) == "executive_id"] <- "Executive_Id"
names(filtered_ceo_df)[names(filtered_ceo_df) == "management_id"] <- "Management_Id"
names(filtered_ceo_df)[names(filtered_ceo_df) == "ticker"] <- "Ticker" 
names(filtered_ceo_df)[names(filtered_ceo_df) == "name"] <- "Name" 
### RENAMING board_sample_data columns
names(filtered_board_sample_data)[names(filtered_board_sample_data) == "company_name"] <- "Company_Name" 
names(filtered_board_sample_data)[names(filtered_board_sample_data) == "companyid"] <- "Company_Id" 
names(filtered_board_sample_data)[names(filtered_board_sample_data) == "ticker"] <- "Ticker" 
names(filtered_board_sample_data)[names(filtered_board_sample_data) == "directorid"] <- "Director_Id" 
names(filtered_board_sample_data)[names(filtered_board_sample_data) == "directorname"] <- "Director_Name" 

glimpse(filtered_board_sample_data)
glimpse(filtered_bd_df)
glimpse(filtered_ceo_df)

final_dataset <- full_join(filtered_bd_df, filtered_ceo_df)

board_dir_n_bd_df_dataset <- full_join(filtered_board_sample_data, filtered_bd_df)
board_dir_with_ceo_df_data <- full_join(board_dir_n_bd_df_dataset, filtered_ceo_df)

write.csv(board_dir_with_ceo_df_data, 'merged_three_datasets.csv')
