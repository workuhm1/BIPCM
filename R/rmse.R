RMSE = function(dat, beta_true){
  ## ------------------------------------------ ##
  ## Calculates root mean-squared error (RMSE)  ##
  ## ------------------------------------------ ##
  
  beta_star <- mean(dat[,3])
  se_beta_star <- sd(dat[,3])
  rmse <- sqrt(((beta_star - beta_true)**2) + (se_beta_star**2))
  
  return(rmse)
}