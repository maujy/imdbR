#install.packages("dplyr")
library(dplyr)
imdb_mmbo_list = read.csv("mmbo.csv", header=TRUE)
str(imdb_mmbo_list)
View(imdb_mmbo_list)

extract_colnames = c('tconst', 'Sport', 'Musical', 'Family', 'Mystery', 'History', 'Crime', 'Drama', 
                     'Music', 'Biography', 'Adult', 'Adventure', 'News', 'Short', 'X.N', 'Fantasy', 
                     'Romance', 'War', 'Action', 'Horror', 'Thriller', 'Animation', 'Documentary',
                     'Western', 'Sci.Fi', 'Comedy', 'Film.Noir')
sub_mmbo_list = imdb_mmbo_list[extract_colnames]
str(sub_mmbo_list)

table(sub_mmbo_list)