pkgs <- c("statmod","RCurl","jsonlite")
for (pkg in pkgs) {
  if (! (pkg %in% rownames(installed.packages()))) { install.packages(pkg) }
}

# Now we download, install and initialize the H2O package for R.
install.packages("h2o", type="source", repos="http://h2o-release.s3.amazonaws.com/h2o/rel-vajda/2/R")

library(h2o)
h2o.init(nthreads = 1, max_mem_size = "1500m")


# Load some data
customerData <- h2o.importFile("https://s3-us-west-1.amazonaws.com/dsclouddata/LendingClubData/Loans-Customer-Info.csv")
accountData <- h2o.importFile("https://s3-us-west-1.amazonaws.com/dsclouddata/LendingClubData/Loans-Account-Info.csv")


# View the data
summary(object = customerData, exact_quantiles=TRUE)
head(customerData)


# Join the files into a single frame
customer360 <- h2o.merge(x = customerData, y = accountData, by = "RowID")
head(customer360)


# Pick a response variable for the supervised problem
response <- "Bad_Loan"


# Use all other columns (except for the name) as predictors
predictors <- setdiff(names(customer360), c(response)) 


# Split dataset giving the training dataset 75% of the data
customer360.split <- h2o.splitFrame(data=customer360, ratios=0.75)


# Create a training set from the 1st dataset in the split
customer360.train <- customer360.split[[1]]


# Create a testing set from the 2nd dataset in the split
customer360.test <- customer360.split[[2]]



LoanApprover <- h2o.gbm(model_id = "LoanApprover.model", x = predictors, y = response, training_frame = customer360.train)

LoanApprover

h2o.varimp_plot(LoanApprover)
# h2o.partialPlot(object = LoanApprover, data = customer360.train, cols = c("Interest_Rate", "Annual_Income"))

h2o.saveModel(object = LoanApprover, path="Models")

h2o.predict(object = LoanApprover, newdata = customer360.test)

h2o.clusterInfo()
