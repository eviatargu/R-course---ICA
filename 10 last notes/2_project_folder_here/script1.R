# here: A Simpler Way to Find Your Files
library(here)
here()
set_here()
here()

# Use the 'here()' function as a drop-in replacement for 'file.path()', it will always locate the files relative to your project root.

dir() # you can use list.files() as well, its the same function.

dir(here())
dir(here("sub_folder_1"))
dir(here("sub_folder_1", "sub_folder_2")) # its the same as:
dir(here("sub_folder_1/sub_folder_2")) 

# open the script to edit: 
file.edit(here("sub_folder_1/sub_folder_2", "script_in_sub_folder_2.R")) 

# save data in the folder: 
save(mtcars, file = here("sub_folder_1", "sub_folder_2", "mtcars_data.RData"))


# if you want to know more go to:  
browseURL("https://cran.r-project.org/web/packages/here/index.html")


