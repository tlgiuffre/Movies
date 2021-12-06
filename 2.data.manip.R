
# === description ===========================================================================
## brief description what the script file is about
#

## if you have clear chunks of code, use collapsible dividers (# ==== or # ----)
## and number the sections. Provide brief description for each section here
## # ***** or #_____ does not make sections 

# ******************************************************************************
## use descriptive names 
# 1) read raw data  load data from clean data folder and ...
# 2) outliers      test for outliers and entryr errors
# 3) .....

# === 1) read raw data =========================================================
# reading data
movie_data <- read.csv("movies.csv")
rating_data <- read.csv("ratings.csv")

# inspecting data
head(movie_data)
head(rating_data)

# === 2) creating data frame for genre =========================================
# creating a data frame of movie genres pulled out of the movie data frame
movie_genre <- as.data.frame(movie_data$genres, stringsAsFactors=FALSE)
# separates genres into columns (rather than by lines)
movie_genre_tidy <- as.data.frame(tstrsplit(movie_genre[,1], '[|]', 
                                        type.convert=TRUE), 
                              stringsAsFactors=FALSE) 
# naming columns of the genre data frame
colnames(movie_genre_tidy) <- c(1:10)
# creating a list of all genres
list_genre <- c("Action", "Adventure", "Animation", "Children", 
                "Comedy", "Crime","Documentary", "Drama", "Fantasy",
                "Film-Noir", "Horror", "Musical", "Mystery","Romance",
                "Sci-Fi", "Thriller", "War", "Western")
# creating an empty matrix (10330 rows and 18 columns filled with 0)
genre_matrix <- matrix(0,(number_of_movies+1),number_of_genres)
# making our genre list the names of each column
colnames(genre_matrix) <- list_genre
# filling in the first row with the same headers (for the loop)
genre_matrix[1,] <- list_genre
# starting  loop that goes through every column of every row
for (row in 1:nrow(movie_genre_tidy)) {
  for (col in 1:ncol(movie_genre_tidy)) {
    #Creates a new name for each cell, and then assigns a value of 1 if it matches
    #E.X. if a movie has action, it gets a 1 under action, but can be searched for
    #action as well.
    gen_col = which(genre_matrix[1,] == movie_genre_tidy[index,col]) 
    genre_matrix[index+1,gen_col] <- 1
  }
}
# removing first row, which was the genre list
genre_data_frame <- as.data.frame(genre_matrix[-1,], stringsAsFactors=FALSE)
head(genre_data_frame)
# converting from characters to integers
for (col in 1:ncol(genre_data_frame)) {
  genre_data_frame[,col] <- as.integer(genre_data_frame[,col]) 
} 
# checking str (to make sure we have integers now)
str(genre_data_frame)
# adding movie id and movie title to genre matrix 2
SearchMatrix <- cbind(movie_data[,1:2], genre_data_frame[])
head(SearchMatrix)

# === 3) creating matrices for rating ==========================================
# creating a new data frame in which each column is a movie
ratingMatrix <- dcast(rating_data, userId~movieId, value.var = "rating", na.rm=FALSE)
# removing userIds
ratingMatrix <- as.matrix(ratingMatrix[,-1]) 
# Converting rating matrix into a recommenderlab sparse matrix
ratingMatrix <- as(ratingMatrix, "realRatingMatrix")
head(ratingMatrix)

# === 4) setting system parameters =============================================
# setting up parameters for building the recommendation system
recommendation_model <- recommenderRegistry$get_entries(dataType = "realRatingMatrix")
names(recommendation_model)

lapply(recommendation_model, "[[", "description")

recommendation_model$IBCF_realRatingMatrix$parameters

# === 5) creating similarity matrices ==========================================
# setting up a similarity matrix for users that uses cosine method to measure 
# how similar 2 users are
similarity_mat <- similarity(ratingMatrix[1:4, ],
                             method = "cosine",
                             which = "users")
as.matrix(similarity_mat)
# generating visualization of the matrix
image(as.matrix(similarity_mat), main = "User's Similarities")

# same process but for movie similarity
movie_similarity <- similarity(ratingMatrix[, 1:4], method =
                                 "cosine", which = "items")
as.matrix(movie_similarity)
image(as.matrix(movie_similarity), main = "Movies similarity")

# extracting values from the matrix so the unique ones can be counted
rating_values <- as.vector(ratingMatrix@data)
unique(rating_values)

# === 6) counting ratings and views ============================================
# creating a count of movie ratings
table_of_ratings <- table(rating_values) 

# counting views for each movie
movie_views <- colCounts(ratingMatrix)

# create a data frame of views
table_views <- data.frame(movie = names(movie_views),
                          views = movie_views)

# sorting the data frame by number of views
table_views <- table_views[order(table_views$views,
                                 decreasing = TRUE), ] 

# adding a new empty column to data the data frame
table_views$title <- NA

# creating a loop that will fill in every row with the movie title
for (index in 1: number_of_movies){
  table_views[index,3] <- as.character(subset
                                       (movie_data,
                                        movie_data$movieId == table_views[index,1])$title)
}

head(table_views)

movie_ratings <- ratingMatrix[rowCounts(ratingMatrix) > 50,
                              colCounts(ratingMatrix) > 50]
# looking at top 98 percentile users and movies
minimum_movies<- quantile(rowCounts(movie_ratings), 0.98)
minimum_users <- quantile(colCounts(movie_ratings), 0.98)

average_ratings <- rowMeans(movie_ratings)
# displaying distribution of the average rating per user
qplot(average_ratings, fill=I("steelblue"), col=I("red")) +
  ggtitle("Distribution of the average rating per user")

# normalizing movie data 
normalized_ratings <- normalize(movie_ratings)
sum(rowMeans(normalized_ratings) > 0.00001)

# looking at top 95 percentile users and movies
binary_minimum_movies <- quantile(rowCounts(movie_ratings), 0.95)
binary_minimum_users <- quantile(colCounts(movie_ratings), 0.95)
# binarizing good rated movies 
good_rated_films <- binarize(movie_ratings, minRating = 3)

# === 6) setting up the AI =====================================================
# taking a sample of 420, assigning true to 80% and false to the rest
sampled_data<- sample(x = c(TRUE, FALSE),
                      size = nrow(movie_ratings),
                      replace = TRUE,
                      prob = c(0.8, 0.2))

# creating training data for the AI program and testing data (which are not the 
# same) to see if the model works
training_data <- movie_ratings[sampled_data, ]
testing_data <- movie_ratings[!sampled_data, ]

# setting parameters for recommendation system
recommendation_system <- recommenderRegistry$get_entries(dataType ="realRatingMatrix")
recommendation_system$IBCF_realRatingMatrix$parameters

# using recommendation model
recommen_model <- Recommender(data = training_data,
                              method = "IBCF",
                              parameter = list(k = 30))
# defining an s4 class for object oriented programming
class(recommen_model)

# === 7) recommending movies ===================================================
# looking at info about the model 
model_info <- getModel(recommen_model)
# defining an s4 class for object oriented programming
class(model_info$sim)
# checking the dimensions of the model 
dim(model_info$sim)
# setting top items to 20
top_items <- 20

sum_rows <- rowSums(model_info$sim > 0)
table(sum_rows)
sum_cols <- colSums(model_info$sim > 0)

# the number of movies to recommend to each user
top_recommendations <- 10 
# building a prediction thing for 10 recommendations for 73 users 
predicted_recommendations <- predict(object = recommen_model,
                                     newdata = testing_data,
                                     n = top_recommendations)
# recommendation for the first user
user1 <- predicted_recommendations@items[[1]] 
# getting movie recommendations in character form
movies_user1 <- predicted_recommendations@itemLabels[user1]
# getting the titles of the recommended movies
movies_user2 <- movies_user1

for (index in 1:10){
  movies_user2[index] <- as.character(subset(movie_data,
                                             movie_data$movieId == movies_user1[index])$title)
}

# creating matrix with the recommendations for each user
recommendation_matrix <- sapply(predicted_recommendations@items,
                                function(x){ as.integer(colnames(movie_ratings)[x]) }) 
recommendation_matrix[,1:4]

#___ end _______________________________________________________________________




