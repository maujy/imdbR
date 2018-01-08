movie_title_list = read.csv("movie_title_list_v1.00.csv", header=TRUE)
str(movie_title_list)
View(movie_title_list)

movie_title_data.frame = movie_title_list[, c(-1, -2, -3, -4, -6, -10 )]
str(movie_title_data.frame)
View(movie_title_data.frame)

# colnames(movie_title_data.frame)
# [1] "worldGross"          "originalTitle"       "startYear"           "runtimeMinutes"      "directors"          
# [6] "writers"             "principalCast"       "averageRating"       "numVotes"            "isSport"            
# [11] "isMusical"           "isFamily"            "isMystery"           "isHistory"           "isCrime"            
# [16] "isDrama"             "isMusic"             "isBiography"         "isAdult"             "isAdventure"        
# [21] "isNews"              "isX.N"               "isFantasy"           "isRomance"           "isWar"              
# [26] "isAction"            "isHorror"            "isThriller"          "isAnimation"         "isDocumentary"      
# [31] "isWestern"           "isSci.Fi"            "isComedy"            "isFilm.Noir"         "summaries"          
# [36] "synopsis"            "filmRating"          "firstRelaseDate"     "firstReleaseCountry" "awards"             
# [41] "productionCo"   

# Linear regression

movie_title_list_simple = movie_title_data.frame[, c(1:8)]
write.csv(movie_title_list_simple, file="output/movie_title_list_simple.csv")


# data.frame = movie_title_data.frame[, c(1, 3:4, 10:34)]

data.frame = movie_title_data.frame[, c(1, 3:4, 12, 16, 20, 23, 26, 28, 29, 30, 32)]
str(data.frame)
View(data.frame)

na.fill

lmTrain = lm(formula = worldGross ~ ., data = data.frame)
summary(lmTrain)

New_data = data.frame(orginalTitle=)


