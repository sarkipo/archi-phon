txphar <- function(bool){
  text <- ifelse(bool,"[+phar]","[-phar]")
}
txph <- function(bool){
  text <- ifelse(bool,"[+]","[-]")
}
txlong <- function(bool){
  text <- ifelse(bool,"long","short")
}
txlg <- function(bool){
  text <- ifelse(bool,"[+]","[-]")
}

fillscale <- scale_fill_manual(values = c("a"="#F8766D","e"="#A3A500","i"="#00BF7D","o"="#E76BF3","u"="#00B0F6"))
F3pl <- qplot(factor(txphar(phar)),F3Bk,data = data.b,geom="boxplot",facets=speaker~vowel,fill=vowel,ylim=c(11,17), 
              xlab="Pharyngealisation", ylab="F3 (Bark)", main="Pharyngealisation effect on F3")
F3th <- theme(legend.position="none",title=element_text(size=rel(5)),
              strip.text=element_text(size=rel(4)),axis.text=element_text(size=rel(4)))
F3pl + F3th + geom_boxplot(size=1.2,outlier.size = 3) + fillscale

data.c <- data.b
data.c$long <- txlong(data.c$long)
durpl <- qplot(factor(txph(phar)),log(duration),data = data.c,geom="boxplot",
               xlab="pharyngealisation",ylab="log (duration)", main="Pharyngealisation effect on duration",facets=speaker~vowel+long,fill=vowel)
durth <- theme(legend.position="none",title=element_text(size=rel(3)),
               strip.text=element_text(size=rel(2)),axis.text=element_text(size=rel(2)))
durpl + durth

durpl2 <- qplot(factor(txphar(phar)),log(duration),data = data.c,geom="boxplot",
                xlab="pharyngealisation",ylab="log (duration)", main="Pharyngealisation effect on duration",facets=.~speaker+long,fill=long)
durth2 <- theme(legend.position="none",title=element_text(size=rel(5)),
                strip.text=element_text(size=rel(4)),axis.text=element_text(size=rel(4)))
durpl2 + durth2 + geom_boxplot(size=1.2,outlier.size = 3)


#par(mfcol=c(1,2))
#boxplot(F1 ~ vowel,data=data.P[data.P$filename=='archi-phon-2006-PSX-1-vowels',])
#boxplot(F1 ~ vowel,data=data.P.int[data.P.int$filename=='archi-phon-2006-PSX-1-vowels',])
#par(mfcol=c(1,1))
ceilpl.P <- qplot(factor(vowel),ceiling,data = data.iP[data.iP$stress==T,],geom="boxplot",
      xlab="vowel",ylab="ceiling", main="Retained ceiling values for PSX",facets=.~phar,fill=vowel)
ceilpl.H <- qplot(factor(vowel),ceiling,data = data.iH[data.iH$stress==T,],geom="boxplot",
      xlab="vowel",ylab="ceiling", main="Retained ceiling values for HDK",facets=.~phar,fill=vowel)
ceilpl.J <- qplot(factor(vowel),ceiling,data = data.iJ[data.iJ$stress==T,],geom="boxplot",
      xlab="vowel",ylab="ceiling", main="Retained ceiling values for JSP",facets=.~phar,fill=vowel)

ceilth <- theme(title=element_text(size=rel(2)),strip.text=element_text(size=rel(2)),
      axis.text=element_text(size=rel(1.5)),legend.text=element_text(size=rel(1.5)))

ceil0 <- 5750
ceilp <- ceil0-500
ceil.data <- data.frame(y=c(ceil0,ceil0+500,ceil0+750,ceil0-500,ceil0-750,ceilp,ceilp+500,ceilp+750,ceilp-500,ceilp-750),
  ymin=-600,ymax=+600,vowel=c("a","e","i","o","u"),phar=c(F,F,F,F,F,T,T,T,T,T))
ceil.data$ymin <- ceil.data$y+ceil.data$ymin
ceil.data$ymax <- ceil.data$y+ceil.data$ymax

ceilJ <- ceil0-500
ceilpJ <- ceilJ-500
ceil.dataJ <- data.frame(y=c(ceilJ,ceilJ+500,ceilJ+750,ceilJ-300,ceilJ-500,ceilpJ,ceilpJ+500,ceilpJ+750,ceilpJ-300,ceilpJ-500),
  ymin=-600,ymax=+600,vowel=c("a","e","i","o","u"),phar=c(F,F,F,F,F,T,T,T,T,T))
ceil.dataJ$ymin <- ceil.dataJ$y+ceil.dataJ$ymin
ceil.dataJ$ymax <- ceil.dataJ$y+ceil.dataJ$ymax

ceilpl.P + geom_crossbar(aes(y=y,ymin=ymin,ymax=ymax),color="brown",
  width=0.2,fill="lightgray",alpha=0.3,ceil.data) + ceilth
ceilpl.H + geom_crossbar(aes(y=y,ymin=ymin,ymax=ymax),color="brown",
  width=0.2,fill="lightgray",alpha=0.3,ceil.data) + ceilth
ceilpl.J + geom_crossbar(aes(y=y,ymin=ymin,ymax=ymax),color="brown",
  width=0.2,fill="lightgray",alpha=0.3,ceil.dataJ) + ceilth
