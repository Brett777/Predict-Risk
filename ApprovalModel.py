
# coding: utf-8

# In[ ]:

import h2o
import pandas as pd

# initialize the model scoring server
h2o.init(nthreads=1,max_mem_size=1, start_h2o=True, strict_version_check = False)

def approve_loan(Loan_Amount,Term,Interest_Rate,Employment_Years,Home_Ownership,Annual_Income,Verification_Status,Loan_Purpose,State,
                 Debt_to_Income,Delinquent_2yr,Revolving_Cr_Util,Total_Accounts,Longest_Credit_Length):
    # connect to the model scoring service
    h2o.connect()

    # open the downloaded model
    ChurnPredictor = h2o.load_model(path='DRF_model_1496459915419_4') 

    # define a feature vector to evaluate with the model
    newData = pd.DataFrame({'Loan_Amount' : Loan_Amount,
                            'Term' : Term,
                            'Interest_Rate' : Interest_Rate,
                            'Employment_Years' : Employment_Years,
                            'Home_Ownership' : Home_Ownership,
                            'Annual_Income' : Annual_Income,
                            'Verification_Status' : Verification_Status,
                            'Loan_Purpose' : Loan_Purpose,
                            'State' : State,
                            'Debt_to_Income' : Debt_to_Income,
                            'Delinquent_2yr' : Delinquent_2yr,
                            'Revolving_Cr_Util' : Revolving_Cr_Util,
                            'Total_Accounts' : Total_Accounts,
                            'Longest_Credit_Length' : Longest_Credit_Length}, index=[0])
    
    # evaluate the feature vector using the model
    predictions = ChurnPredictor.predict(h2o.H2OFrame(newData))
    predictionsOut = h2o.as_list(predictions, use_pandas=False)
    prediction = predictionsOut[1][0]
    probabilityBad = predictionsOut[1][1]
    probabilityGood = predictionsOut[1][2]
    return "Prediction: " + str(prediction) + " |Probability of Bad Loan: " + str(probabilityBad) + " |Probability of Good Loan: " + str(probabilityGood)

