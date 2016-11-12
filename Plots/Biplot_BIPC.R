
Biplot_BIPC <- function (object, gr.var = FALSE, markers = NULL, 
                         xlab = NULL, ylab = NULL, legend = "bl", asp=1, ...) {
  
    B <- object$B
    Z <- object$Z
    X <- object$X
  
    eta.X = as.matrix(cbind(1,X))
    eta.B = as.matrix(B)
    eta = eta.X%*%eta.B
    
		n <- dim(X)[1]
		p <- dim(X)[2]
    Ip <- diag(p)
    intercept <- c(1, rep(0, p)) %*% B
    minAA <- min(Z)
    maxAA <- max(Z)
    for (j in 1:p) {
      e <- c(0, Ip[j, ])
      AA <- rep(1, length(unique(X[, j]))) %*% intercept + 
            unique(X[, j]) %*% (e %*% B)
      if (min(AA) < minAA) 
          minAA <- min(AA)
      if (max(AA) > maxAA) 
          maxAA <- max(AA)
    }
    
    plot(eta[, 1], eta[, 2], xlab = "", ylab = "", type = "n", asp=1)
    
    abline(h=0, col="red")
    abline(v=0, col="red")
    points(0,0,pch=19)
    points(1,0,pch=19)
    points(0,1,pch=19)
    points(Z[4,1],Z[4,2],pch=19)
  
    text(-3,-0.1,"DYST")
    text(-0.2,-3,"GAD", srt=90)
    text(1.2,0.60,"G=4", cex=1)
    text(0.3, -0.15, "G=1", cex=1)
    text(1.25, -0.2, "G=2", cex=1)
    text(-0.50, 1, "G=3", cex=1)
    
    points(eta[, 1], eta[, 2], pch = ".", cex = 3.5, col = gray(0.6)) 
    
    ## Biplot legened on the line
    for (j in 1:p) {
      e <- c(0, Ip[j, ])
      AA <- rep(1, length(unique(X[, j]))) %*% intercept + 
          unique(X[, j]) %*% (e %*% B)
      ordera= order(AA[,1])
      AA.tmp<<-AA
      
      lines(AA[ordera,2] ~ AA[ordera,1], lwd=2)
      
      cordmy = matrix(c(min(AA[,1])-0.1,min(AA[,2])-0.1, max(AA[,1])+0.1,max(AA[,1])+1.05, 
                        min(AA[,1])-0.1,min(AA[,2])-0.1), 3,2, byrow=TRUE)
      text(cordmy[j,1],cordmy[j,2], labels=colnames(X)[j], cex=1)
      
      if (is.numeric(markers)) {
          marks = markers[, j]
          points(rep(1, length(unique(X[, j]))) %*% intercept + 
              marks %*% (e %*% B))
      }
      else {
          mn <- mean(X[, j])
          s <- sd(X[, j])
          marks <- as.matrix(c((mn - 2 * s), (mn - s)))
          points(rep(1, length(marks)) %*% intercept + 
              marks %*% (e %*% B), pch = "-", cex=2)
          marks <- mn
          points(rep(1, length(marks)) %*% intercept + 
              marks %*% (e %*% B), pch = 16)
          marks <- c((mn + s), (mn + 2 * s))
          points(rep(1, length(marks)) %*% intercept + 
              marks %*% (e %*% B), pch = "+", cex=1.5)
      }
    }
}		
		
		
 