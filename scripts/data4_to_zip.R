library(tidyverse)
library(googledrive)
library(googlesheets4)
library(DataPushR)
library(gh)
library(archive)
#https://github.com/yihui/tinytex/issues/126
# copied from another repo.  May not work just right.

csv_files_get <- function(repo_name = "data4benfords"){
  gh_data_raw <- gh::gh(glue::glue("GET /repos/byuidatascience/{repo}/contents/data-raw/", 
                                   repo = repo_name))
  
  data_folders <- map(gh_data_raw, "name") %>% 
    unlist() %>% 
    .[-str_which(., "\\.")]
  
  gh_files_get <- function(x, repo = repo_name){
    gh::gh(glue::glue("GET /repos/byuidatascience/{repo}/contents/data-raw/{folder}", 
                      folder = x, repo = repo))
  }
  
  list_get <- function(x){
    map(x, "download_url")
  }
  
  list_files <- map(data_folders, ~gh_files_get(.x))
  
  csv_files <- map(list_files, ~list_get(.x)) %>% 
    unlist() %>%
    .[str_which(., ".csv")]
  csv_files
  
}

dir_download <- function(x, drive_folder = "data4"){
  
  
  subfolder <- str_extract(x, str_c(drive_folder, "[a-z|A-Z|0-9]{1,}")) %>% 
    
    str_remove(drive_folder)
  
  
  newname_path <- fs::path_file(x) %>% 
    fs::path_ext_remove() %>% 
    str_c(".", fs::path_ext(x))
  download_path <- str_c(drive_folder,"/", subfolder,"/", newname_path)
  download.file(x, download_path)
  print(newname_path)
}


document_download <- function(x){
  
  gh_data_readme <- gh::gh(glue::glue("GET /repos/byuidatascience/{repos}/contents/data.md", 
                                      repos = x))$download_url
  drive_folder = "data4"
  subfolder <- str_remove(x, "data4")
  
  tf <- tempfile()
  download.file(gh_data_readme, tf)
  fs::dir_create(str_c(drive_folder,"/", subfolder))
  rmarkdown::render(input = tf, output_format = "pdf_document", 
                    output_file = "data.pdf", output_dir = str_c(drive_folder,"/", subfolder))
}



repo_names <- c("data4benfords", "data4births", "data4marathons", "data4childhealth", "data4tuberculosis")

#x <- repo_names <- "data4childhealth"

csv_list <- repo_names %>%
  map( ~csv_files_get(repo_name = .x)) %>% 
  unlist() 
#%>%  .[-str_which(. , "race_[0-9]{1,5}.csv")]

repo_names %>%
  map(~document_download(.x))

csv_list %>% map(~dir_download(.x))


## now zip each folder

subfolder <- str_remove(repo_names, "data4")


zip_create <- function(x) {
  archive::archive_write_dir(str_c("data4/", x, ".zip"), str_c("data4/", x))
  }

subfolder |>
  map(, ~zip_create(.x))


