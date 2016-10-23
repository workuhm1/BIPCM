
## ********************************************************************************
## Copyright: FSW, Leiden University, The Netherlands
## ********************************************************************************
##  Program     : eval_sim_results.R
##  Author      : Hailemichael M. Worku (hmetiku@yahoo.com) 
##  Date        : 2010 - 2015
##  Description : The script calculates bias, rmse and coverage for model parameter
##  Remarks     : N/A
## ********************************************************************************
##  Input : true_vect [M] - true values used in the simulation study and 
##                          stored as a vector.
##          type_parm [M] - type of parameter to be analyzed (1=marginal; 
##                          2=association; 3=both marginal & association).
##          dsin      [M] - input dataset.  
##  Output: N/A
##  ********************************************************************************

   
eval_sim <- function(true_vect, type_parm, dsin) {
  
  ## Initialize input parameters
  n_row <- dim(true_vect)[1]
  out <- data.frame(parm=character(), true=numeric(0), 
                    bias=numeric(0), rmse=numeric(0), coverage=numeric(0))
  
  for (i in 1:n_row) {
    
    ## Initialize input parameters used in the loop
    parm     <- as.character(true_vect[i, 1])
    parm_val <- true_vect[i, 2]
    
    if (type_parm == 1 || type_parm==3) {       # marginal parameters
      dat_parm <- dsin[dsin$Parameter==parm, ] 
    }
    else if (type_parm == 2) {  # association parameters
      dat_parm <- dsin[dsin$Label==parm, ] 
    }
    
    ## calculate efficiency statistics
    bias     <- round(Bias(dat = dat_parm, beta_true = parm_val), 2)
    rmse     <- round(RMSE(dat = dat_parm, beta_true = parm_val), 2)
    coverage <- round(coverage(dat = dat_parm, beta_true = parm_val), 2)
    
    ## save the results
    tmp <- data.frame(parm=parm, true=parm_val, bias=bias, rmse=rmse, coverage=coverage)
    out <- rbind(out, tmp)
  }
  
  return(out)
}