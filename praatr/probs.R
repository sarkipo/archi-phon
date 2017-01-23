prob_freq_binom <- function(n=1000,p=0.05,fmin=10,fmax=100,fstep=1){
  fr <- seq(fmin,fmax,by=fstep)
  pr <- dbinom(fr,n,p)
  plot(fr,pr,type="h",xlab="frequency",ylab="probability of frequency")
}

prob_sample_binom <- function(s=500,n=1000,p=0.05,fmin=10,fmax=100){
  x <- xtabs(~rbinom(s,n,p))/s
  plot(as.numeric(names(x)),x,type="h",xlab="frequency",ylab="sample probability of frequency",xlim=c(fmin,fmax))
}
