# data4

Most of the public data created within our byuidatascience GitHub group is for use in our data science program. We have two types of data folders.

- **data_[NAME]** - This contains data derived by students or faculty for one-time use in a project, but that may have value beyond their project.
- **data4[NAME]** - Which contains data used regularly for varied classes within our data science program.  These repositories tend to be more formally organized.

## data4 repository details

These repositories are built using the [DataPushR R package](https://github.com/BYUIDSS/DataPushR), and they have the following structure.
- There is a `data-raw` folder that has varied file formats of the curated data.  All data is the same, but they are stored in varied formats for use with different software and programming languages. 
this folder can have more data than is available in the R package.
- Each of these repositories is stored as an R package and can be installed in R using `devtools::install_github("byuidatascience/data4[NAME]")`.  If done, the data objects in the `data` folder will be available to the R user.  We recommend using `data4[NAME]::` structure to access the available data.
- Each data set is documented with the `data.md` file in the repository and as a help file in R. You can find the data sources here.
- There is an R script in the `data-raw` folder that documents what was done with the source data before it was created in the repository. 

## data4 Repositories

- [data4benfords](https://github.com/byuidatascience/data4benfords): The repository has varied data sets that can be used to teach about Benford's law.  They can be used to explain the Chi-Square Goodness of Fit process.
- [data4childhealth](https://github.com/byuidatascience/data4childhealth): This repository has varied height and weight measurements of children from various countries under the age of 2. Also, we have the WHO table of mean and standard deviation values for each day of age.  This data can be used to teach about z-scores and the normal distribution.
- [data4births](https://github.com/byuidatascience/data4births): This repository has the birthdates of many professional athletes.  It also has the number of births by month and day of the month for the US and the varied athlete groups.  This data can be used to teach about the Matthew Effect.
- [data4tuberculosis](https://github.com/byuidatascience/data4tuberculosis): This repository has tuberculosis data from the World Health Organization (WHO).  It is messy by intention.  This data can be used to teach tidy principles.
- [data4marathons](https://github.com/byuidatascience/data4marathons): This repository has marathon times for the majority of marathons in the US. It is largely various subsets of data from [Wu's data](https://faculty.chicagobooth.edu/george.wu/research/marathon/marathon_names.htm). One addition is the inclusion of spatial coordinates for the locations of some of the races.  
- [data4legos](https://github.com/byuidatascience/data4legos): Is in development. It was used to build [these trelliscope visualization dashboards](https://byuidatascience.github.io/cse150_lego/index.html)
- [data4LED](https://github.com/byuidatascience/data4LED): Is in development.