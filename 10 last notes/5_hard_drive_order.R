# 1.example for a mess
shell.exec("S:/Research Division/9755 Retail Fuel Market/Verification of Findning")


# 2. mortgage research
shell.exec("S:/mortgage.research")

all_files <- dir("S:/mortgage.research", recursive = T) # 6205 files

all_R_scripts <- dir("S:/mortgage.research", recursive = T, pattern = "\\.R$")
View(as.data.frame(all_R_scripts))

all_RMD_files <- dir("S:/mortgage.research", recursive = T, pattern = "\\.Rmd$")
View(as.data.frame(all_RMD_files))

all_RData_files <- dir("S:/mortgage.research", recursive = T, pattern = "\\.RData$")
View(as.data.frame(all_RData_files))


# use find in files to fine you code:
# ctrl+shift+F
# looking for glm( to fine a function I used before: 



# looking for plot I created in the past: 
# figure_24.png can't be found because the plot was not created in a script :(


# 3. payment apps

shell.exec("S:/Research Division/Payment apps")
# every folder name is in English







