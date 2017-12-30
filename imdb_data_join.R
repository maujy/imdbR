#install.packages("jsonlite")
library("jsonlite")

#get the move tconst list which from move box office
movie_title_tt =fromJSON("./movie_title_tt.json")
str(movie_title_tt)
movie_tconst_list=matrix(movie_title_tt, nrow=length(movie_title_tt))
colnames(movie_tconst_list) = 'tconst'
str(movie_tconst_list)
View(movie_tconst_list)

#merge with with imdb move list
#install.packages("dplyr")
library(dplyr)
imdb_movie_list = read.csv("imdb_movie_list.csv", header=TRUE)
str(imdb_movie_list)
View(imdb_movie_list)

movie_boxoffice_list=merge(movie_tconst_list, imdb_movie_list, by = 'tconst')
str(movie_boxoffice_list)
View(movie_boxoffice_list)

write.csv(movie_boxoffice_list, file="movie_boxoffice_list.csv")


#extra movie_title_year with numVotes>=1000, averageRating>=6 
test = filter(movie_boxoffice_list, numVotes>=1000)
summary(test$averageRating)
str(test)
View(test)

test2 = filter(test, averageRating >=6)
summary(test2$averageRating)
str(test2)
View(test2)

write.csv(test2, file="move_title_year.csv")


#extra move_directors_nconst
movie_boxoffice_list = read.csv("movie_boxoffice_list.csv", header=TRUE)
movie_directors_nconst = subset(movie_boxoffice_list, directors != "\\N", select = c('directors'))
str(movie_directors_nconst)
View(movie_directors_nconst)

movie_directors_nconst_s = unique(unlist(strsplit(as.character(movie_directors_nconst$directors), ",")))
str(movie_directors_nconst_s)
movie_directors_list = matrix(movie_directors_nconst_s, nrow=length(movie_directors_nconst_s))
colnames(movie_directors_list) = c('nconst')

str(movie_directors_list)
View(movie_directors_list)

write.csv(movie_directors_list, file="movie_directors_list.csv")

#extra move_writers_nconst
movie_boxoffice_list = read.csv("movie_boxoffice_list.csv", header=TRUE)
movie_writers_nconst =  subset(movie_boxoffice_list, writers != "\\N", select = c('writers'))
str(movie_writers_nconst)
View(movie_writers_nconst)

movie_writers_nconst_s = unique(unlist(strsplit(as.character(movie_writers_nconst$writers), ",")))
str(movie_writers_nconst_s)

movie_writers_list = matrix(movie_writers_nconst_s, nrow=length(movie_writers_nconst_s))
colnames(movie_writers_list) = c('nconst')
str(movie_writers_list)
View(movie_writers_list)

write.csv(movie_writers_list, file="movie_writers_list.csv")


#extra move_principalCast_nconst
movie_boxoffice_list = read.csv("movie_boxoffice_list.csv", header=TRUE)
movie_principalCast_nconst = subset(movie_boxoffice_list, principalCast != "\\N", select = c('principalCast'))
str(movie_principalCast_nconst)
View(movie_principalCast_nconst)

movie_principalCast_nconst_s = unique(unlist(strsplit(as.character(movie_principalCast_nconst$principalCast), ",")))
str(movie_principalCast_nconst_s)

movie_principalCast_list = matrix(movie_principalCast_nconst_s, nrow=length(movie_principalCast_nconst_s))
colnames(movie_principalCast_list) = c('nconst')
str(movie_principalCast_list)
View(movie_principalCast_list)

write.csv(movie_principalCast_list, file="movie_principalCast_list.csv")
