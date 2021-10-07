set.seed(15)
hw2

hw2 <- runif(50, 4, 50)
hw2

hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

#asked what set.seed means
?set.seed()
#set.seed appears to be a random number generator,
?runif()
#runif pulls up "uniform distribution" -- I'm not sure what the 50, 4, 50 mean, but I think this function generally is organizing the data according to 'uniform distribution' ** 50 numbers, 4 is minimum, 50 is maximum.
?replace()
#this function is adding NAs in spots 4, 12, 22, and 27
#every time "hw2" appears, that's checking to see what the functions have done to it


#HW Problem 1
hw2_1 <- na.omit(hw2)
hw2_1

#another way to do it is [hw2[!is.na(hw2)]] where the ! indicates "do the reverse."
#hw2_1 no longer has NAs
hw2_1 > 14
prob <- hw2_1[hw2_1 > 14]
prob1 <- prob[prob < 38]
prob1
#the "|" or AND function wasn't working for me for some reason, so I had to break this step down into two mini-steps. Might ask about this in class tomorrow.
#in class, we used &

#HW Problem 2
times3 <- prob1*3
times3
plus10 <- times3 + 10
plus10

#HW Problem 3
final <- plus10[c(T, F, T, F, T, F, T, F, T, F, T, F, T, F, T, F, T, F, T, F, T, F, T)]
final

#a simpler way to do this that doesn't involve all the TFs?
#odds <- seq(from = 1, to = 23, by = 2) --- created an object called "odds" using the seq function, 23 is the length of the vector... 
#final <- plus10[odds] --- using vector to identify which numbers you want to take out.
#in the future, can also put your "to"s set to another function to simplify it and reduce the number of steps you personally have to take to make it unique to a particular data set.
#or... can do seq(1,23,2)
#can also just have put T, F --- due to repeating principle // "vector recycling"