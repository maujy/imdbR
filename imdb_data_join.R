#install.packages("jsonlite")
library("jsonlite")

#get the move tconst list which from move box office
move_title_tt =fromJSON("./movie_title_tt.json")
str(move_title_tt)
move_tconst_list=matrix(move_title_tt, nrow=length(move_title_tt))
colnames(move_tconst_list) = 'tconst'
str(move_tconst_list)
View(move_tconst_list)

#merge with with imdb move list
#install.packages("dplyr")
library(dplyr)
imdb_movie_list = read.csv("imdb_movie_list.csv", header=TRUE)
str(imdb_movie_list)
View(imdb_movie_list)

move_boxoffice_list=merge(move_tconst_list, imdb_movie_list, by = 'tconst')
str(move_boxoffice_list)
View(move_boxoffice_list)

#extra move_title_year with numVotes>=1000, averageRating>=6 
test = filter(move_boxoffice_list, numVotes>=1000)
summary(test$averageRating)
str(test)
View(test)

test2 = filter(test, averageRating >=6)
summary(test2$averageRating)
str(test2)
View(test2)

write.csv(test2, file="move_title_year.csv")

