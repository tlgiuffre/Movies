# "Hello World"

# Big Data Challenge | Data Analysis in R | Group 2: Jacob, Sacha, Sofia, Tristan | December, 2021
Slides: https://docs.google.com/presentation/d/15wcCqO0x5FEu794siyjRMdmIJB8dVpT-MkCo2LNctH8/edit?usp=sharing

# Question: 
Can we use user data (similiar to what is done by Subscription Streaming Entertainment Services(i.e. Neftlix, Hulu, Amazon Prime)) to generate movie reccomendations / **and can we then use the data to see trends in content consumed at different times throughout the year (i.e. do we see more Horror movies consumed in October?).** 

# Description:

Recommendation systems using Machine Learning have many applications across many varying industries.  Subscription Streaming Entertainment Services like Netflix, Hulu, Amazon Prime, etc. offer users content recommendations based on previous watches and trending films/shows. Our group has set out to create our own reccomendation system based on user preferences and browsing history using machine learning and the MovieLens dataset. This dataset consists of 105339 ratings applied over 10329 movies. Our reccomendation system will utilize this dataset and user input data to provide individualized reccomendations for future content consumption. 

# Outline/Workflow:
We decided to take on this project for a number of reasons; one being we found a lot of resources related to the topic online. Another being that we are all (as individuals) implictly involved in these types of systems in our own lives (i.e. we all use a variation of these Subscription Streaming Entertainment Services and/or have our data tracked across many online sites for personalized ads, etc.).

Our approach was to first do some brief googling to hone into our exact topic. In doing this we discovered a very helpful guide that provided examples of this system with some source code and data that was easily accessible to get us started in creating the program (DataFlair, 2019). 

After we had access to the data, and installed the required packages, we started our data manipulation to organize our movie and rating.csv files. Next, we began working off of the source code making edits to the code and reverse engineering it to understand how and why it works before going on to expand on it. 

Once we had set up our data, our matrices, and normalized our data, we set up our Machine Learning to both train and test whether the recommendation model would work.

We then went on to set up a UI for user input to curate movie recommendations based on the user input. 

# Summary of Results:
Our group set out to create a program to provide movie recommendations based on similiar users content consumption and ratings. Recommendation systems using machine learning have become prevalent in many aspects of life and are particuilarily useful for scaling large amounts of data. The main example we looked at was the utilization of this system in Subscription Streaming Entertainment Services. These services use recommendation systems to curate content to individuals based on their user data and those of users who have viewed similiar content to recommend future content consumption. 

# Limitations

One limitation to our project was the dataset we used, we struggled to find ways to expand the scope of our project because we were limited to the information availiable (or rather not avaliable) in the dataset. I.e. we were interested in generally seeing what genres of movies are consumed at different times of the year, or how weather impacts what genres are consumed but we couldn't connect our movie data with other temporal or geographical data.  

***Another limitation was due to time constraints we decided not to start our project from scratch but rather expand on previous work done on the topic to further our own understanding and develop the scope of our code.*** 

Future projects could aim to expand on our work by incoporating it into a live data base (like the Quest Movie Criteon Library ((which is no longer a thing)) to provide recommendations on an ongoing basis for users in realtime based on what is avaliable within the library (essentially adding the recommendation system to a platform like a netflix to curate content recommendations).  

This could also be expanded to apply recommendations across content types using other databases (i.e. since you liked X movie, you might like Y book)

# Bibliography

Machine Learning Project—Data Science Movie Recommendation System Project in R. (2019, July 27). DataFlair. https://data-flair.training/blogs/data-science-r-movie-recommendation/


