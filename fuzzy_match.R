# Loading the libraries
library(dplyr)
library(tidyverse)
library(fuzzyjoin)
library(openxlsx)

# Loading the xlsx file 
path <- "/fuzzy_match.xlsx"

# Extracting the spreadsheets from xlsx file
sheet1_data_tableA <- readxl::read_xlsx(path, sheet = 1)
sheet2_data_tableB <- readxl::read_xlsx(path, sheet = 2)
sheet3_data_tableC <- readxl::read_xlsx(path, sheet = 3)

# Renaming column names of sheet1_data_tableA
names(sheet1_data_tableA)[names(sheet1_data_tableA) == "player_name"] <- "player" 

## Fuzzy match 
final_result <- stringdist_join(sheet1_data_tableA, sheet2_data_tableB, by = "player", mode = "left", ignore_case = FALSE, method = "jw", p = .15, max_dist = 4, distance_col = "dist") %>%
  group_by(player.x) %>%
  top_n(1, -dist) %>%
  select(player_id.x, player_id.y, player.x, player.y, dist) %>%
  group_by(player.x) %>%
  mutate(count.x = row_number()) %>%
  group_by(player.y) %>%
  mutate(count.y = row_number()) %>%
  ungroup() %>%
  filter(count.x == count.y & count.x == 1) %>%
  separate(player.x, into = c("fname.x", "lname.x")) %>%
  separate(player.y, into = c("fname.y", "lname.y")) %>%
  filter(lname.y == lname.x) %>%
  unite("player_name_data_table_A", fname.x, lname.x, sep = " ") %>%
  unite("player_name_data_table_B", fname.y, lname.y, sep = ". ") %>%
  select(-count.x, -count.y)
  
# fuzzy_match_confidence
final_result$dist = 1-final_result$dist


# Renaming column names of final_result
title_col <- colnames(sheet3_data_tableC)
names(final_result)[names(final_result) == "player_id.x"] <- title_col[1]
names(final_result)[names(final_result) == "player_id.y"] <- title_col[2]
names(final_result)[names(final_result) == "dist"] <- title_col[5]

## Create a excel file
fuzzy_match <- createWorkbook()
addWorksheet(fuzzy_match, "data_table_A")
addWorksheet(fuzzy_match, "data_table_B")
addWorksheet(fuzzy_match, "data_table_C")
writeData(fuzzy_match, 1, sheet1_data_tableA)
writeData(fuzzy_match, 2, sheet2_data_tableB)
writeData(fuzzy_match, 3, final_result)
saveWorkbook(fuzzy_match, file = "fuzzy_match[Gaurav-UpWork].xlsx")
saveWorkbook(fuzzy_match, file = "/home/gurjar/Downloads/fuzzy_match_working_file.xlsx", overwrite = TRUE)

