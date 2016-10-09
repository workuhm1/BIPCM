
## ********************************************************************************
## Copyright: FSW, Leiden University, The Netherlands
## ********************************************************************************
##  Program     : generate.R
##  Author      : Hailemichael M. Worku (hmetiku@yahoo.com)
##  Date        : 2010 - 2015
##  Description : The script generates bivariate binary responses (y1_i, y2_i) 
##                following a Bivariate Logistic Regression (BLR) model (sometimes  
##                referred to as Palmgren Model). The association model, i.e., 
##                log(tau_i)=eta_i, is a constrained model whose parameters 
##                are defined as function of the marginal parameters following
##                a 2-dimensional IPC model.
##  Remarks     : N/A
## ********************************************************************************
##  Input : nn [M]     - sample size
##          seedIN [O] - seed number
##  Output: A comma-separated txt dataset
##  ********************************************************************************


gen_palm = function(nn=500, seedIN=NULL)   {
  
  ## Check if SEED value is give by the user
  if(!is.null(seedIN)){
    set.seed(seedIN)
  }

  ## Generate predictors from binomial/normal distribution
  id = matrix(c(1:nn))
  X1 = matrix(rbinom(n = nn, size = 1, prob = 0.67))
  X2 = matrix(rnorm(nn))
  X3 = matrix(rnorm(nn))
  X4 = matrix(rnorm(nn))
  X5 = matrix(rnorm(nn))
  
  ## Combine all predictors
  data0 = data.frame(id, X1, X2, X3, X4, X5)
         
  ## Define mu1, mu2 and eta3 (to be used for defining the BL model)    
  ## Remark: The true values are obtained from the BLR model fitted on the NESDA data (Table 4).
  ##         beta03 = phi1*beta01 + phi2*beta02 - 0.5*phi1^2 - 0.5*phi2^2 - phi1 - phi2
  ##         betak3 = phi1*betak1 + phi2*betak2
  mu1 = logit(-2.20 + 0.00*X1  + 0.20*X2 - 0.15*X3 + 1.05*X4 - 0.45*X5, inv=TRUE)    # logit(mu1) = eta1 
  mu2 = logit(-1.50 + -0.25*X1 + 0.00*X2 - 0.15*X3 + 1.15*X4 - 0.15*X5, inv=TRUE)    # logit(mu2) = eta2
  eta3 = 1.65 + 0.10*X1 - 0.05*X2 + 0.10*X3 - 0.70*X4 + 0.15*X5                      # log(OR) = eta3
  
  ## Generate binary responses
  ymat = rbinom2.or(n=nn, mu1=mu1, mu2=mu2, oratio=exp(eta3), twoCols=TRUE) 
             
  ## Combine Bivariate binary responses and predictors
  data0 = data.frame(data0, ymat)

  ## Return output dataset
  return(data0)
}