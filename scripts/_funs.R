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



dir_download <- function(x, drive_folder = "data4", repo_detail = "data4"){
  
  
  subfolder <- str_extract(x, str_c(repo_detail, "[a-z|A-Z|0-9]{1,}")) %>% 
    str_remove(repo_detail)
  
  newname_path <- fs::path_file(x) %>% 
    fs::path_ext_remove() %>% 
    str_c("_", repo_detail, ".", fs::path_ext(x))
  download_path <- str_c(drive_folder,"/", subfolder,"/", newname_path)
  download.file(x, download_path)
  print(newname_path)
}


document_download <- function(x, drive_folder = "data4"){
  
  gh_data_readme <- gh::gh(glue::glue("GET /repos/byuidatascience/{repos}/contents/data.md", 
                                      repos = x))$download_url

  subfolder <- str_remove(x, "data4")
  
  tf <- tempfile()
  download.file(gh_data_readme, tf)
  fs::dir_create(str_c(drive_folder,"/", subfolder))
  rmarkdown::render(input = tf, output_format = "pdf_document", 
                    output_file = "data.pdf", output_dir = str_c(drive_folder,"/", subfolder))
}

