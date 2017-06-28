library(h2o)
h2o.init(nthreads = 1, max_mem_size = "1500m")

# This is the deployable function

approveLoan <- function(Loan_Amount,Term,Interest_Rate,Employment_Years,Home_Ownership,Annual_Income,Verification_Status,Loan_Purpose,State,
                        Debt_to_Income,Delinquent_2yr,Revolving_Cr_Util,Total_Accounts,Longest_Credit_Length){

  newLoanApplication <- data.frame('Loan_Amount' = Loan_Amount,
                                   'Term' = Term,
                                   'Interest_Rate' = Interest_Rate, 
                                   'Employment_Years' = Employment_Years,
                                   'Home_Ownership' = Home_Ownership,
                                   'Annual_Income' = Annual_Income,
                                   'Verification_Status'= Verification_Status,
                                   'Loan_Purpose' = Loan_Purpose,
                                   'State' = State,
                                   'Debt_to_Income' = Debt_to_Income,
                                   'Delinquent_2yr' = Delinquent_2yr,
                                   'Revolving_Cr_Util' = Revolving_Cr_Util,
                                   'Total_Accounts' = Total_Accounts,
                                   'Longest_Credit_Length' = Longest_Credit_Length)
  
  newLoanApplicationH2O <- as.h2o(newLoanApplication)
  loanApprover <- h2o.loadModel(path = "LoanApprover.model")
  prediction = h2o.predict(object = loanApprover, newdata = newLoanApplicationH2O)
 return(prediction)
}

# Sample data to test the function

Loan_Amount = 5000
Term = "60 months"
Interest_Rate=13
Employment_Years=5
Home_Ownership="RENT"
Annual_Income=75000
Verification_Status="VERIFIED - income"
Loan_Purpose="credit_card"
State="CA"
Debt_to_Income=16.12
Delinquent_2yr=0
Revolving_Cr_Util=37
Total_Accounts=6
Longest_Credit_Length=97

# Create a sample frame for testing
newLoanApplication <- data.frame('Loan_Amount' = Loan_Amount,
                                 'Term' = Term,
                                 'Interest_Rate' = Interest_Rate, 
                                 'Employment_Years' = Employment_Years,
                                 'Home_Ownership' = Home_Ownership,
                                 'Annual_Income' = Annual_Income,
                                 'Verification_Status'= Verification_Status,
                                 'Loan_Purpose' = Loan_Purpose,
                                 'State' = State,
                                 'Debt_to_Income' = Debt_to_Income,
                                 'Delinquent_2yr' = Delinquent_2yr,
                                 'Revolving_Cr_Util' = Revolving_Cr_Util,
                                 'Total_Accounts' = Total_Accounts,
                                 'Longest_Credit_Length' = Longest_Credit_Length)

head(newLoanApplication)

approveLoan(Loan_Amount,Term,Interest_Rate,Employment_Years,Home_Ownership,Annual_Income,Verification_Status,Loan_Purpose,State,Debt_to_Income,Delinquent_2yr,Revolving_Cr_Util,Total_Accounts,Longest_Credit_Length)
