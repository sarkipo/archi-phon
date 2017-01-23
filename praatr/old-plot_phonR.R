myplot.phonR <- function(speaker="ALL",vowels=c("i","e","a","o","u","\u0259"),split="phar",filter="str"){
  data.spk <- if (speaker=="ALL") data.a else data.a[data.a$speaker==speaker,]
  data.fil <- if (filter=="ALL") data.spk else data.spk[data.spk$stress==TRUE,]
  data.sel <- if (vowels[1]=="ALL") data.fil else data.fil[data.fil$vowel %in% vowels,]
  attach(data.sel)
  
  par(mfrow = c(2, 1))
  manycol <- c("green", "darkgreen", "orange", "darkorange", "magenta", "darkmagenta", "cyan", "darkcyan", "red", "darkred", "gray", "darkgray")
  plotVowels(F1Bk, F2Bk, vowel, group = phar, pretty = TRUE, plot.tokens = TRUE, plot.means = FALSE, 
             cex.tokens=3,alpha.tokens = 0.7, var.col.by = vowel, var.style.by = grps, 
             ellipse.line = TRUE, ellipse.fill = TRUE, fill.opacity = 0.2,
             legend.kwd="bottomright",legend.args=c(ncol=2,cex=0.25),xlab="F2 (Bark)",ylab="F1 (Bark)",label.las = 0)
  plotVowels(-F3Bk, F2Bk, vowel, group = phar, pretty = TRUE, plot.tokens = TRUE, plot.means = FALSE, 
             cex.tokens=2,alpha.tokens = 0.7, var.col.by = vowel, var.style.by = grps, 
             ellipse.line = TRUE, ellipse.fill = TRUE, fill.opacity = 0.1,
             legend.kwd="bottomleft",legend.args=c(ncol=2),xlab="F2 (Bark)",ylab="F3 (Bark)",label.las = 0)
  
  par(mfrow = c(1, 1))
  
  detach(data.sel)
}
