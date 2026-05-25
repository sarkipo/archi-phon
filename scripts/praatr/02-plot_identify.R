myplot3i <- function(data=data.a,speaker="ALL",vowels=c("i","e","a","o","u","\u0259"),split="phar",filter="str"){
  data.spk <- if (speaker=="ALL") data else data[data$speaker==speaker,]
  data.fil <- if (filter=="ALL") data.spk else data.spk[data.spk$stress==TRUE,]
  data.sel <- if (vowels[1]=="ALL") data.fil else data.fil[data.fil$vowel %in% vowels,]
  attach(data.sel)

  if (split == "phar") grp <- factor(grps) else grp <- factor(vowel)
  manycol <- c("green", "darkgreen", "orange", "darkorange", "magenta", "darkmagenta", "cyan", "darkcyan", "red", "darkred", "gray", "darkgray")
  scatter3d(F1Bk,F3Bk,F2Bk,surface = F, surface.col = manycol, ellipsoid = T,groups=grp, sphere.size=1.5, radius=log10(duration))
  points <- Identify3d(F1Bk,F3Bk,F2Bk,groups=grp, col=manycol)
  
  detach(data.sel)

  if (length(points)>0) msg <- "\nYou have selected the following vowels:\n" else msg <- "\nYou have selected no vowels.\n"
  cat(msg)
  for (point in points){
    r <- data.sel[as.numeric(point),]
    cat(point,'\t', as.character(r$speaker), as.character(r$vowel), as.character(r$phone),
        as.character(r[c(4:8,15:17)]), '\n')
  }
  
  for (point in points){
    praatextract(data.sel[as.numeric(point),],point)
  }
}

praatextract <- function(data.check,vowel.id){
  speaker <- data.check$speaker
  soundfile <- data.check$filename
  command <- paste0('sendpraat.exe praat "runScript: \\"',WD("scr-ExtractVowel.praat"),'\\", ', data.check$time, ', ', vowel.id, ', \\"', soundfile, '\\""')
  shell(command) 
}

