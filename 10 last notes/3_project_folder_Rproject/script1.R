getwd()

browseURL("https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects")


x <- mtcars
y <- head(mtcars)
save(x, file = "mtcars_data.RData")
save(y, file = "mtcars2_data.RData")

# existing files in the envronment should load next time we open the project.