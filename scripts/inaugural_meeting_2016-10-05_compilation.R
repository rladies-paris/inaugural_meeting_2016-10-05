## LOAD PACKAGES ####
source("scripts/inaugural_meeting_2016-10-05_packages.R")


## RUN SCRIPTS ####
source("scripts/inaugural_meeting_2016-10-05_cleaning.R")
source("scripts/inaugural_meeting_2016-10-05_figures.R")


## SAVE ENVIRONMENT FOR PRESENTATION ####
save.image("presentation/inaugural_meeting_2016-10-05_environment.RData")
