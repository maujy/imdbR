library("jsonlite")
tfidf_list =fromJSON("./tfidf_0107all_v2.json")
str(tfidf_list)
View(tfidf_list)

# movie_title_year = read.csv("movie_title_year.csv", header=TRUE)

movie_title_list = read.csv("movie_title_list_v1.00.csv", header=TRUE)

ibrary(dplyr)
movie_tfidf_list = merge(tfidf_list, movie_title_list,by.x = "imdb_id", by.y = "tconst")
movie_tfidf_list = movie_tfidf_list[, -6]
View(movie_tfidf_list)

# colnames(movie_tfidf_list)
# [1] "imdb_id"             "chname"              "comment"             "noComments"          "tfidf"              
# [6] "domesticGross"       "overseaGross"        "worldGross"          "originalTitle"       "startYear"          
# [11] "runtimeMinutes"      "genres"              "directors"           "writers"             "principalCast"      
# [16] "averageRating"       "numVotes"            "isSport"             "isMusical"           "isFamily"           
# [21] "isMystery"           "isHistory"           "isCrime"             "isDrama"             "isMusic"            
# [26] "isBiography"         "isAdult"             "isAdventure"         "isNews"              "isX.N"              
# [31] "isFantasy"           "isRomance"           "isWar"               "isAction"            "isHorror"           
# [36] "isThriller"          "isAnimation"         "isDocumentary"       "isWestern"           "isSci.Fi"           
# [41] "isComedy"            "isFilm.Noir"         "summaries"           "synopsis"            "filmRating"         
# [46] "firstRelaseDate"     "firstReleaseCountry" "awards"              "productionCo"  

genres_sum = data.frame(genres=colnames(movie_tfidf_list[18:42]), freq=apply(movie_tfidf_list[18:42], 2, sum))
pie(genres_sum)
plot(genres_sum)

library('ggplot2')
g = ggplot(genres_sum, aes(x=genres, y=freq))+geom_count()
g = ggplot(genres_sum, aes(x=genres, y=freq))
# g = g + geom_bar(fill='snow', color='black', stat='identity')
g = g + geom_point()
g = g+ xlab ('Genres') + ylab('Number of times') + ggtitle(paste(nrow(movie_tfidf_list),'Movie summary'))
g = g+ theme(text = element_text(size=14), axis.text.x = element_text(angle=90, hjust=1)) 
g
ggsave(filename='output/movie_genres_tfidf.png', plot = g)

