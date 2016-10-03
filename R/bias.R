Bias = function(dat, beta_true){
  ## ---------------- ##
  ## Calculates bias  ##
  ## ---------------- ##
  
  beta_star = mean(dat[,3])
  bias = beta_star - beta_true
  
  return(bias)
}