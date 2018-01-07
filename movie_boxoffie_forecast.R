movie_title_list = read.csv("movie_title_list_v1.00.csv", header=TRUE)
str(movie_title_list)
View(movie_title_list)

data.frame = movie_title_list[, c(-1, -2, -3, -4, -6, -10 )]
str(data.frame)
View(data.frame)

features = 'originalTitlestartYearruntimeMinutes'

na.fill

lmTrain = lm(formula = worldGross ~ originalTitle+startYear+runtimeMinutes, data = data.frame)

summary(lmTrain)

# Linear regression
