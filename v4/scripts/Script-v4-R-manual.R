# BEFORE EXECUTING THIS SCRIPT, BE SURE TO ESTABLISH YOUR WORKING DIRECTORY (i.e., PROEJECT DIRECTORY)
#  
# You can do this one of ways: (1) manually or (2) from this command file
#
# (1) MANUAL APPROACH
#
# 1) create a folder on your computer calledTHERE IS A FOLDER ON YOUR COMPUTER NAMED "<YourName>Version4".
#
# 2) There are three subfolders in the top level 
# of "<YourName>Version4":
# ----Data
# ----Scripts
# ----Output
#
# 3)"<YourName>Version4" IS DESIGNATED AS R'S WORKING
# DIRECTORY. IF NECESSARY, MANUALLY SET THE WORKING
# DIRECTORY TO "<YourName>Version4".
# 
# AND
# 
# 4) A COPY OF ACS2018Extract.csv IS SAVED IN THE Data SUBFOLDER OF "<YourName>Version4".

# This script:
# -reads the 2018 ACS data extract into a data frame
# -creates a table of group means of income by race and sex
# -saves the table in a .csv file, and stores it in the # "Output" folder.
# -generates a bar graph showing group means of income by # race and sex
# -saves the bar graph in a .png file, and stores it in the # "Output" folder

################################
# Directory structure
################################

# set working directory (here, "v4" for "version4")
getwd()
setwd("./v4")
getwd()

# confirm subdirectories
dir.create("./data", showWarnings = TRUE)
dir.create("./output", showWarnings = TRUE)
dir.create("./scripts", showWarnings = TRUE)

################################
# Working environment
################################

# Clear the environment
rm(list = ls())

# Load packages
library("tidyverse")
library("writexl")

################################
# DATA EXERCISE
################################

# Read the data in ACS2018Extract.csv into a data frame, using a relative directory path to indicate that the .csv file is stored in the Data folder 
ACS2018Extract<-read_csv("data/ACS2018Extract.csv")

# if loading data from web:
# note: be sure to select "raw" data from GitHub to avoid loading HTML
ACS2018Extract<-read_csv("https://raw.githubusercontent.com/mattcingram/UKRN_virtual_workshop_2024/main/v4/data/ACS2018Extract.csv")

# Construct the table of mean income by race and sex
table<-ACS2018Extract |>
  summarize(
    frequency=n(),
    mean_income=mean(income),
    .by=c(race, sex)
  ) |>
  arrange(race, sex)

# Display the table of mean income by race and sex
table

# Save the table in a .csv file, using a relative directory path to indicate the file should be saved in the Output folder
write.csv(table, "output/MeanIncomes.csv")

# Construct the bar graph of mean income by race and sex
graph <- ggplot(table, aes(race, mean_income))+geom_col(aes(fill = sex), position="dodge")

# Display the bar graph of mean income by race and sex
graph

# Save the bar graph in a .png file, using a relative directory path to indicate the file should be saved in the Output folder
ggsave("output/MeanIncomes.png")

###############################
# SAVE WORKING DATA
###############################

save.image("./data/working.RData")
# can now export this file and others to save elsewhere

# end
