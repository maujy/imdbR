library("jsonlite")
imdb_multi =fromJSON("./IMDB_multi_3.json")
str(imdb_multi)
imdb_multi = imdb_multi[, c(-5, -6, -7)]
colnames(imdb_multi) = c('rankOfBoxoffice', 'domesticGross', 'overseaGross', 'worldGross',
                         'tconst', 'summaries', 'synopsis', 'filmRating', 'firstRelaseDate', 'firstReleaseCountry', 'awards', 'productionCo')
imdb_multi$rankOfBoxoffice = as.numeric(sub('<b><font color=\"#17FF17\">', '', imdb_multi$rankOfBoxoffice))
imdb_multi$domesticGross = as.numeric(imdb_multi$domesticGross)
imdb_multi$overseaGross = as.numeric(imdb_multi$overseaGross)
imdb_multi$worldGross = as.numeric(imdb_multi$worldGross)
for (i in 1:nrow(imdb_multi)) {
  if (imdb_multi$productionCo[i] == "list()" || imdb_multi$productionCo[i] =="NULL") {
    imdb_multi$productionCo_n[i] = ""
  } else {
    temp = unlist(imdb_multi$productionCo[i])
    text = as.character(temp[1])
    if (length(temp) > 1) {
      for (j in 2:length(temp)) {
        text = paste(text, temp[j], sep=",")
      }
    }
    imdb_multi$productionCo_n[i] = as.character(text)
  }
}
imdb_multi = imdb_multi[,-12]
colnames(imdb_multi)[12] = 'productionCo'
# imdb_multi = imdb_multi[imdb_multi$worldGross > 0,]
imdb_multi$firstRelaseDate=as.Date(imdb_multi$firstRelaseDate, "%d %B %Y")
str(imdb_multi)
View(imdb_multi)

mmbo = read.csv("mmbo.csv", header=TRUE)
mmbo = mmbo[, c(-1, -3, -4, -5, -6, -7, -8, -9, -16, -23, -26, -33)]
for (i in 2:length(colnames(mmbo))) {
  colnames(mmbo)[i] = paste("is",colnames(mmbo)[i],sep="")
}
str(mmbo)
View(mmbo)


imdb_movie_list = read.csv("imdb_movie_list.csv", header=TRUE)
imdb_movie_list = imdb_movie_list[, c(-1, -3)]
imdb_movie_list$runtimeMinutes = as.numeric(sub("\\N", "", imdb_movie_list$runtimeMinutes))
imdb_movie_list[is.na(imdb_movie_list$runtimeMinutes), "runtimeMinutes"] = NaN
imdb_movie_list[imdb_movie_list$genres=="\\N",'genres'] = ""
imdb_movie_list[imdb_movie_list$directors=="\\N",'directors'] = ""
imdb_movie_list[imdb_movie_list$writers=="\\N",'writers'] = ""
imdb_movie_list[imdb_movie_list$principalCast=="\\N",'principalCast'] = ""
str(imdb_movie_list)
View(imdb_movie_list)

#merge the big table of movie_title_list for analysis
library(dplyr)
movie_title_list_cleaned = merge(imdb_movie_list, mmbo, by = "tconst")
movie_title_list_cleaned = merge(movie_title_list_cleaned, imdb_multi, by = "tconst")
str(movie_title_list_cleaned)
View(movie_title_list_cleaned)
write.csv(movie_title_list_cleaned, file="movie_title_list_cleaned.csv")

#======================================================================================================
# correct movie worldboxoffice data by title
library("jsonlite")
movie_boxoffice =fromJSON("./movies_box_new.json")
str(movie_boxoffice)
movie_boxoffice = movie_boxoffice[ , c(-6, -7)]
colnames(movie_boxoffice) = c('rankOfBoxoffice', 'domesticGross', 'overseaGross', 'worldGross', 'originalTitle')
movie_boxoffice$rankOfBoxoffice = as.numeric(sub('<b><font color=\"#17FF17\">', '', movie_boxoffice$rankOfBoxoffice))
# movie_boxoffice$domesticGross = as.numeric(movie_boxoffice$domesticGross)
# movie_boxoffice$overseaGross = as.numeric(movie_boxoffice$overseaGross)
movie_boxoffice$worldGross = as.numeric(movie_boxoffice$worldGross)
movie_boxoffice = movie_boxoffice[movie_boxoffice$worldGross > 0,]
View(movie_boxoffice)

movie_title_list_cleaned = read.csv("movie_title_list_cleaned.csv", header=TRUE)
movie_title_list_cleaned = movie_title_list_cleaned[, c(-1, -38, -39, -40, -41)]
movie_title_list_cleaned[movie_title_list_cleaned$isAdult.x != movie_title_list_cleaned$isAdult.y,]
movie_title_list_cleaned$isAdult.y = movie_title_list_cleaned$isAdult.x
movie_title_list_cleaned = movie_title_list_cleaned[, c(-3)]
colnames(movie_title_list_cleaned)[20] = 'isAdult'
str(movie_title_list_cleaned)
View(movie_title_list_cleaned)

library(dplyr)
movie_title_list_v1.00 = merge(movie_boxoffice, movie_title_list_cleaned, by = "originalTitle", sort = FALSE)
movie_title_list_v1.00 = movie_title_list_v1.00[order(movie_title_list_v1.00[,2]) , c(2, 3, 4, 5, 6, 1, 7:ncol(movie_title_list_v1.00))]
str(movie_title_list_v1.00)
View(movie_title_list_v1.00)
write.csv(movie_title_list_v1.00, file="movie_title_list_v1.00.csv")

#=======================================================================================================
movie_directors_nmbio_list = read.csv("movie_directors_nmbio_list.csv", header=TRUE)
str(movie_directors_nmbio_list)
View(movie_directors_nmbio_list)

movie_directors_nminfo_list = read.csv("movie_directors_nminfo_list.csv", header=TRUE)
str(movie_directors_nminfo_list)
View(movie_directors_nminfo_list)


#union movie name nconst list
movie_directors_list = read.csv("movie_directors_list.csv", header=TRUE)$nconst
movie_writers_list = read.csv("movie_writers_list.csv", header=TRUE)$nconst
movie_principalCast_list = read.csv("movie_principalCast_list.csv", header=TRUE)$nconst
movie_name_nconst_list_s = union(union(unlist(movie_directors_list), unlist(movie_writers_list)), unlist(movie_principalCast_list))
movie_name_nconst_list = matrix(movie_name_nconst_list_s, nrow=length(movie_name_nconst_list_s))
colnames(movie_name_nconst_list) = c('nconst')
movie_name_nconst_list = sort(movie_name_nconst_list$nconst)
str(movie_name_nconst_list)
View(movie_name_nconst_list)

write.csv(movie_name_nconst_list, file="movie_name_nconst_list.csv")





