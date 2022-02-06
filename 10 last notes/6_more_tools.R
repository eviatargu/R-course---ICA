# 1. clipr
library(clipr)
write_clip(mtcars)

read_clip()
read_clip_tbl()


browseURL("https://cran.r-project.org/web/packages/clipr/index.html")




# 2. edit like excel
# you can edit manually like in excel: 
x <- mtcars
x2 <- edit(x)


# a package called editData: 
browseURL("https://cran.r-project.org/web/packages/editData/vignettes/editData.html")


