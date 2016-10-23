coverage <- function(dat, beta_true){
  ## ------------------------- ##
  ## Calculates Coverage rate  ##
  ## ------------------------- ##
  
  OK = (dat$Lower <= beta_true)&(dat$Upper >= beta_true)
  cover <- 100 * sum(OK) / 1000
  
  return(cover)
}