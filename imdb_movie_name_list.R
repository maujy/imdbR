#install.packages("dplyr")
library(dplyr)

imdb_title_basics = read.csv("title.basics.tsv", header=TRUE, sep="\t")
View(imdb_title_basics)
str(imdb_title_basics)
head(imdb_title_basics)

imdb_title_basics_movie = subset(imdb_title_basics, titleType=='movie')
imdb_title_basics_movie = imdb_title_basics_movie[ , -2]
imdb_title_basics_movie = imdb_title_basics_movie[ , -6]
View(imdb_title_basics_movie)
str(imdb_title_basics_movie)
head(imdb_title_basics_movie)

# imdb_title_basics_movie_2017 = subset(imdb_title_basics, titleType=='movie' & startYear=='2017')
# View(imdb_title_basics_movie_2017)
# str(imdb_title_basics_movie_2017)
# head(imdb_title_basics_movie_2017)

imdb_title_crew = read.csv("title.crew.tsv", header=TRUE, sep="\t")
View(imdb_title_crew)
str(imdb_title_crew)
head(imdb_title_crew)

imdb_title_principals = read.csv("title.principals.tsv", header=TRUE, sep="\t")
View(imdb_title_principals)
str(imdb_title_principals)
head(imdb_title_principals)

imdb_ratings = read.csv("title.ratings.tsv", header=TRUE, sep="\t")
View(imdb_ratings)
str(imdb_ratings)
head(imdb_ratings)

imdb_name_basics = read.csv("name.basics.tsv", header=TRUE, sep="\t")
View(imdb_name_basics)
str(imdb_name_basics)
head(imdb_name_basics)


#merge the title and rating tables together
imdb_movie_list_1 = merge(imdb_title_basics_movie, imdb_title_crew, by='tconst')
imdb_movie_list_2 = merge(imdb_movie_list_1, imdb_title_principals, by='tconst')
imdb_movie_list = merge(imdb_movie_list_2, imdb_ratings, by='tconst')
View(imdb_movie_list)
str(imdb_movie_list)
head(imdb_movie_list)
write.csv(imdb_movie_list, file="imdb_movie_list.csv")
write.csv(imdb_name_basics, file="imdb_name_list.csv")

#extract data from table
#install.packages("dplyr")
library(dplyr)
imdb_movie_list = read.csv("imdb_movie_list.csv", header=TRUE)
View(imdb_movie_list)
str(imdb_movie_list)
imdb_name_list = read.csv("imdb_name_list.csv", header=TRUE)
View(imdb_name_list)
str(imdb_name_list)

filter(imdb_movie_list, primaryTitle =="Life of Pi" )
filter(imdb_name_list, primaryName =="Ang Lee" )

