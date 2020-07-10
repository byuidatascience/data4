library(tidyverse)
library(googledrive)
library(googlesheets4)
library(DataPushR)
library(gh)
#https://github.com/yihui/tinytex/issues/126

source("scripts/_funs.R")

repo_names <- c("data4benfords", "data4births", "data4marathons", "data4childhealth", "data4tuberculosis")

x <- repo_names <- "data4childhealth"

csv_list <- repo_names %>%
  map( ~csv_files_get(repo_name = .x)) %>% 
  unlist() 
#%>%  .[-str_which(. , "race_[0-9]{1,5}.csv")]

repo_names %>%
  map(~document_download(.x, drive_folder = "docs/cse150/data/"))

csv_list %>% map(~dir_download(.x, drive_folder = "docs/cse150/data"))

setwd("docs/cse150/data/")

data_folders <- dir()

for (i in seq_along(data_folders)) {
  
  setwd(data_folders[i])
  file_zip <- dir()
  zip(zipfile = str_c('../', data_folders[i]), files = file_zip)
  setwd("..")
  print(i)
}




