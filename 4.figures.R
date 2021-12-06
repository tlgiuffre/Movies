
working_directory <- getwd()

# === 1) distribution of the average rating per user ===========================

# Step 1: Call the pdf command to start the plot
pdf(file = paste(working_directory, "/Distribution of average rating per user.pdf"),   
    # The directory you want to save the file in
    width = 4, # The width of the plot in inches
    height = 4) # The height of the plot in inches

# Step 2: displaying distribution of the average rating per user
qplot(average_ratings, fill=I("#0145ac"), col=I("black")) +
  ggtitle("Distribution of the average rating per user")

# Step 3: Run dev.off() to create the file!
dev.off()

# === 2) bar plot of total view of popular movies ==============================

# Step 1: Call the pdf command to start the plot
pdf(file = paste(working_directory, "/Distribution of average rating per user.pdf"),   
    # The directory you want to save the file in
    width = 4, # The width of the plot in inches
    height = 4) # The height of the plot in inches

# displaying distribution of the average rating per user
qplot(average_ratings, fill=I("steelblue"), col=I("red")) +
  ggtitle("Distribution of the average rating per user")

#bar plot of total view of most popular movies 
ggplot(table_views[1:6, ], aes(x = title, y = views)) +
  geom_bar(stat="identity", fill = 'steelblue') +
  geom_text(aes(label=views), vjust=-0.3, size=3.5) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Total Views of the Top Films")

#heat map of 95 percentile users and movies 
binary_minimum_movies <- quantile(rowCounts(movie_ratings), 0.)
binary_minimum_users <- quantile(colCounts(movie_ratings), 0.95, 0.95)
image(movie_ratings[rowCounts(movie_ratings) > minimum_movies,
                    colCounts(movie_ratings) > minimum_users],
      main = "Heatmap of the top users and movies")



