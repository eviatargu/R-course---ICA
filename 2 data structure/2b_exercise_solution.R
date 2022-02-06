# setup
pacman::p_load(readxl, tidyverse, magrittr)

# list all files to handle
list.files("2_data", pattern = '.xlsx')
(file_name <- list.files("2_data", pattern = 'dy'))
(file_path <- file.path("2_data", file_name))
a1 <- read_excel(file_path, col_names = F, sheet = "לוח 01")


# create a date variable from file name
year <- str_sub(file_name, 3,4)
month <- str_sub(file_name, 5, 6)
(year_month <- paste("20", year, "-", month, sep = ""))

# vector of names: 
names <- c("row_num2", "recycled_from_other_bank_interest",
           "recycled_from_other_bank_sum", "total_type_to_repayment",	
           "total_interest", "total_sum","var_time_to_repayment",
           "var_anchor_add", "var_anchor", "var_sum",
           "fixed_time_to_repayment", "fixed_interest", 
           "fixed_sum", "sub_headings","headings",	"row_num1")

# work on each sheet
# sheet 1 
# columns are in fliped order, file columns order: 
a1b <- a1[,order(ncol(a1):1)]

# the data in each table starts where the text לוח is: 
(cell_1 <- which(a1b == "לוח 01", arr.ind = T)) # so we know its is the 22nd row
# note that cell one is a matrix of 1 row and 2 columns: 
attributes(cell_1)

# taking 6 rows back from the row position of cell_1
a1b <- a1b[cell_1[1]-7 + 1:36, ]
# the names vector needs to be reversed as well:
# (originally I wrote the names vecor in reversed order as the first data sets I worked on were as such)

names(a1b) <- rev(names)
# after checking that the names match the information in the first 6 rows,
# revmoving the first 7 rows: 
a1b <- a1b[-c(1:7),]

# create columnes needed to identify the data
a1b$year_month <- year_month # the data of the data
a1b$inflation <- "cpi_linked" # sheet 1 is צמוד מדד
a1b$board <- "board 01" # another indicator

# clean duplicated data
a1b$row_num2 <- NULL

# fill na's
# 2nd and 3rd columns had "merged excel cells", fill it with data: 
a1b <- tidyr::fill(a1b, headings, .direction = "down")

# copy data from 2nd column to 3rd column:
a1b$sub_headings[is.na(a1b$sub_headings)] <- a1b$headings[is.na(a1b$sub_headings)]

str(a1b)
# all data is "charachter". 
# after checking that there will be no loss of data, we convert all numbers to numeric: 

# turn all relevant columns to numeric: 
a1b[4:15] <- map_df(a1b[4:15], parse_number)
str(a1b)



# this function will take the first 3 excel sheets, work on each of them and rbind the resaults
f_boi_data1 <- function(file_name){
  # load excel sheets
  a1 <- read_excel(file_name, col_names = F, sheet = "לוח 01")
  a2 <- read_excel(file_name, col_names = F, sheet = "לוח 02")
  a3 <- read_excel(file_name, col_names = F, sheet = "לוח 03")
  # get sheet data
  year <- str_sub(file_name, 3,4)
  month <- str_sub(file_name, 5, 6)
  (year_month <- paste("20", year, "-", month, sep = ""))
  print(year_month)
  # vector of names: 
  names <- c("row_num2", "recycled_from_other_bank_interest",
             "recycled_from_other_bank_sum", "total_type_to_repayment",	
             "total_interest", "total_sum","var_time_to_repayment",
             "var_anchor_add", "var_anchor", "var_sum",
             "fixed_time_to_repayment", "fixed_interest", 
             "fixed_sum", "sub_headings","headings",	"row_num1")
  
  # work on each sheet
  # sheet 1 
  a1b <- a1[,order(ncol(a1):1)]
  (cell_1 <- which(a1b == "לוח 01", arr.ind = T))
  a1b <- a1b[cell_1[1]-7 +1:36  , ]
  
  
  names(a1b) <- rev(names)
  a1b <- a1b[-c(1:7),]
  a1b$year_month <- year_month
  a1b$inflation <- "cpi_linked"
  a1b$board <- "board 01"
  a1b$row_num2 <- NULL
  # fill na's
  a1b <- tidyr::fill(a1b, headings, .direction = "down")
  a1b$sub_headings[is.na(a1b$sub_headings)] <- a1b$headings[is.na(a1b$sub_headings)]
  
  # sheet 2 
  a2b <- a2[,order(ncol(a2):1)]
  (cell_1 <- which(a2b == "לוח 02", arr.ind = T))
  a2b <- a2b[cell_1[1]-7 +1:34  , ]
  
  names(a2b) <- rev(names)
  a2b <- a2b[-c(1:7),]
  a2b$year_month <- year_month
  a2b$inflation <- "non linked"
  a2b$board <- "board 02"
  a2b$row_num2 <- NULL
  # fill na's
  a2b <- tidyr::fill(a2b, headings, .direction = "down")
  a2b$sub_headings[is.na(a2b$sub_headings)] <- a2b$headings[is.na(a2b$sub_headings)]
 
  # sheet 3 
  a3b <- a3[,order(ncol(a3):1)]
  (cell_1 <- which(a3b == "לוח 03", arr.ind = T))
  a3b <- a3b[cell_1[1]-7 +1:34  , ]
  
  names(a3b) <- rev(names)
  a3b <- a3b[-c(1:7),]
  a3b$year_month <- year_month
  a3b$inflation <- "foreigh currency"
  a3b$board <- "board 03"
  a3b$row_num2 <- NULL
  # fill na's
  a3b <- tidyr::fill(a3b, headings, .direction = "down")
  a3b$sub_headings[is.na(a3b$sub_headings)] <- a3b$headings[is.na(a3b$sub_headings)]
  
  # rbind three data frames
  a_all <- do.call("rbind", list(a1b, a2b, a3b))
  
  } # good for 2015-01 - 2017-03
three_sheets <-f_boi_data1(file_path)




