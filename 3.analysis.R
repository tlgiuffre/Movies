# recommend a set of movies to a new user, by overwriting user 1 in the CSV
#
# this file ensures that an entry is correct, and adds it to ratings
# run Data.manip, run analysis, and run Data.manip agin
# this is because data.manip initializes a bunch of variables used here
# and this file changes the user reviews CSV

# This overwrites the person in position 1, meaning some data is lost.
# however, there are over 600 other data points that are unaffected, so it isnt a big deal

#### we should be able to stick this in datamanip at line 24, and it would work like a charm #####
# as long as we run with "source"

#initialize the new users movie list.
#note that user0 is the new user
user0movielist <- rep(NA, 5)


# loop through movie entries, and read the command prompt for movies
# the data is gross, so you have to entter date as well
#  FOR SOME REASON THIS CAN ONLY RUN PROPERLY BY CLICKING "SOURCE" TO RUN

i <- 1

for (i in 1:5) {
  user0movielist[i] <- readline(prompt= "Enter your next favourite movie and date:")
  print(user0movielist)
  
}

#check to ensure that those movies are in the list
print(is.element(user0movielist, movie_data$title))

#get the movie id from movie nameby looping through user0movielist
i <- 1
for (i in 1:5) {
  user0movielist[i] <- which(movie_data$title==user0movielist[i],arr.ind=TRUE)
  
}

user0movielist

#turn user0movielist into a data frame with "dummy" rating and timestamp values
#this is what overwrites user 1 - hence the name
user0overwrite <- data.frame(rep(1,5), user0movielist,rep(5.0,5), rep(1217897793,5))

# for cbind to work later, user0overwrite names must match column names
colnames(user0overwrite) <- c("userId", "movieId", "rating", "timestamp")

# create a revised version of rating data

temp_rating_data <- rating_data[-which(rating_data$userId==1,),]
rating_data <- rbind(user0overwrite, temp_rating_data)


#### the above could go into datamanip at line 24 and work like a charm ####

# write a new ratings.csv
# path might not work perfectly, but github is fighting me.

write.csv(rating_data, file.path(wk.dir, "ratings2.csv"))



