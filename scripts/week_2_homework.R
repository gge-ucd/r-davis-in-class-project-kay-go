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
#runif pulls up "uniform distribution" -- I'm not sure what the 50, 4, 50 mean, but I think this function generally is organizing the data according to 'uniform distribution'
?replace()
#this function is adding NAs in spots 4, 12, 22, and 27
#every time "hw2" appears, that's checking to see what the functions have done to it


#HW Problem 1
hw2_1 <- na.omit(hw2)
hw2_1
#hw2_1 no longer has NAs
hw2_1 > 14
prob <- hw2_1[hw2_1 > 14]
prob1 <- prob[prob < 38]
prob1
#the "|" or AND function wasn't working for me for some reason, so I had to break this step down into two mini-steps. Might ask about this in class tomorrow.

#HW Problem 2
times3 <- prob1*3
times3
plus10 <- times3 + 10
plus10

#HW Problem 3
final <- plus10[c(T, F, T, F, T, F, T, F, T, F, T, F, T, F, T, F, T, F, T, F, T, F, T)]
final
