### data generating ###
n<- 200 #This line of code simply sets n equal to 200. 
p<- 100 #This line of code sets p equal to 100. 
beta<- c(1,-1,-1,0,1,2,1.5,-2, rep(0, p-8)) #Creates a vector with 100 elements. The first 8 are defined and the rest are 0. These are the betas of the true model. 
X1<- as.factor(sample(3,n,replace = TRUE)) #Factors are variables in R which take on a limited number of different values. These variables are therefore categorical variables. This line of code creates a vector of 200 variables and encodes the vector as a factor with 3 levels (1, 2, and 3).
X2<- as.factor(sample(5,n,replace = TRUE)) #This line of code creates a vector of 200 variables and encodes the vector as a factor with 5 levels (1, 2, 3, 4, and 5)
X3<- matrix(rnorm(n*(p-6)), n, (p-6)) #Creates a matrix out of 200*94 observations generated with a mean of 0 and a standard deviation of 1. These are the non-categorical variable generation values.  
Xdat<- data.frame(X1, X2, X3) #Combines X1, X2, and X3 into a data frame where X1 makes up the first column, X2, makes up the second column, and the X3 matrix makes up the rest of the columns. Data frames allow columns to contain different types of data. Xdat contains the generated values for X variables. This data frame contains both the categorical and non-categorical values for X. 
X<- model.matrix(~., Xdat)[,-1] #This function is fascinating. It converts the factors into binary "True" and "False" data. For example, the first factor in X1 is 3. If we look at X, the first row of column X12 shows 0 while the X13 column shows a 1. This means that X1 is equal to 3. If both X12 and X13 were 0, then the value of X1 must be 1. X2 is converted likewise, but has 4 columns because it has 5 possible levels. Finally, the "intercept" column is removed with [,-1].
dim(X) #This returns the dimensions of X. 
#head(X[,1:15])
Y<- X%*%beta+rnorm(n,0,2) #First matrix X is multiplied by vector beta. Let's take a look at the dimensions (200X100)*(100X1). The columns in X matches the rows in beta and the result is a 200X1 matrix that is then added to a normal distribution with 200 observations, a mean of 0, and a standard deviation of 2.  
### end of data generating ###
mydf<- data.frame(Y=Y, Xdat) #Examination of mydf brings it all together. All of the work leading up to vector Y was part of generating Y values. These will likely be used as the true values of Y against which estimations of Y will be compared. Xdat is generated values for the X variables including categorical variables. Both the Y and X generated values are placed in a single data frame called mydf. 
index<- sample(n, 0.8*n) #This is the first step in producing training and testing data. It sets apart 80% of the numbers 1-200 (randomly) for training data.
train<- mydf[index,] #Training data split out from mydf using index.
test<- mydf[-index,] # Testing data split out from mydf using remaning data not used in train. 
