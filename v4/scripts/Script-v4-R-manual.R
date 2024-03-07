###########################################################################
# BEFORE EXECUTING THIS SCRIPT, BE SURE TO ESTABLISH YOUR WORKING DIRECTORY 
###########################################################################
#
# You can do this several ways: 
# (1) manual approach, 
# (2) code approach, hardcoding filepath for working directory in command file, and 
# (3) code approach, using relative filepaths in command file.
# All three approaches are outlined below.
# The key idea is that establishing a working directory is a core TIER principle 
# and a good reproducibility practice.
#
# (1) MANUAL APPROACH
# In this approach, you create a folder on your computer called "<YourName>Version4".
# This is your working directory.
# In RStudio, you would then go the menu bar at the top of the screen, 
# click on the 'Session' tab, select 'Set Working Directory', select 'Choose Directory', 
# and then navigate the windows to set the folder location.
# You could use the Session tab this way in the virtual RStudio environment.
#
# Within the working directory, you also create three subfolders:
# ----data
# ----code
# ----output
#
# ** alternately, you could call the 'code' subfolder 'scripts', and you could divide 
# the 'output' folder into 'tables' and 'figures'
#
# A copy of ACS2018Extract.csv is saved in the data subfolder.
#
# The current script does the following:
# -reads the 2018 ACS data extract into a data frame
# -creates a table of group means of income by race and sex
# -saves the table in a .csv file, and stores it in the # "Output" folder.
# -generates a bar graph showing group means of income by # race and sex
# -saves the bar graph in a .png file, and stores it in the # "Output" folder

# (2) CODE APPROACH, HARDCODING FILEPATH
# In this approach, you create a folder on your computer called "<YourName>Version4".
# This is your working directory.

# (1) CODE APPROACH, USING RELATIVE FILEPATH
# In this approach, you create a folder on your computer called "<YourName>Version4".
# This is your working directory.


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
