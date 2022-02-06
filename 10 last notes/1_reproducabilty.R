# dplyr has many versions: 
browseURL("https://cran.r-project.org/web/packages/dplyr/index.html")
browseURL("https://cran.r-project.org/src/contrib/Archive/dplyr")


# Available CRAN Packages By Date of Publication
browseURL("https://cran.r-project.org/web/packages/available_packages_by_date.html")

# each package has archive
browseURL("https://cran.r-project.org/src/contrib/Archive/")



# dplyr change log: 
browseURL("https://dplyr.tidyverse.org/news/index.html")

# example of dplyr deprecated functions: 
browseURL("https://dplyr.tidyverse.org/reference/se-deprecated.html")

# functions with stopped development: 
library(tidyr)
?gather


# package dependencies: 

browseURL("https://cran.r-project.org/web/packages/miniCRAN/vignettes/miniCRAN-dependency-graph.html")
library(miniCRAN)
# 
pkgDep("dplyr", suggests = F)
pkgDep("dplyr", suggests = T)
(x <- makeDepGraph("dplyr", suggests = F))
plot(x)

# explanation taken from: 
browseURL("https://kbroman.org/pkg_primer/pages/depends.html")
# Depends is used to indicate dependency on a particular version of R, and on packages that are to be loaded (with library()) whenever your package is loaded.


# Suggests is for packages that aren’t really necessary, but that you’re using in your examples, vignettes, or tests.


# for more info read: 
browseURL("https://kbroman.org/pkg_primer/")
browseURL("https://r-pkgs.org/index.html")







