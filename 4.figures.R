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

