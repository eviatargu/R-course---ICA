# from advenced R chapter 4- subsetting: 

#1. use [[ instead of [ ----
# While you must use [[ when working with lists, I’d also recommend using it with atomic vectors whenever you want to extract a single value. For example, instead of writing:
for (i in 2:length(x)) {
  out[i] <- fun(x[i], out[i - 1])
}

# It’s better to write:
for (i in 2:length(x)) {
  out[[i]] <- fun(x[[i]], out[[i - 1]])
}
# Doing so reinforces the expectation that you are getting and setting individual values.

# 2.With lists, you can use x[[i]] <- NULL to remove a component. To add a literal NULL, use x[i] <- list(NULL):
x <- list(a = 1, b = 2)
x[["b"]] <- NULL
str(x)
# m 1

y <- list(a = 1, b = 2)
y["b"] <- list(NULL)
str(y)

# Subsetting with nothing can be useful with assignment because it preserves the structure of the original object. Compare the following two expressions. In the first, mtcars remains a data frame because you are only changing the contents of mtcars, not mtcars itself. In the second, mtcars becomes a list because you are changing the object it is bound to.
mtcars[] <- lapply(mtcars, as.integer)
is.data.frame(mtcars)


mtcars <- lapply(mtcars, as.integer)
is.data.frame(mtcars)
