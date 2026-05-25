formants.gg <- function(data=data.a,speaker="ALL",formants="two.one",vowels=c("i","e","a","o","u","\u0259"),split="phar",filter="str"){
  data.spk <- if (speaker=="ALL") data else data[data$speaker==speaker,]
  data.fil <- if (filter=="ALL") data.spk else data.spk[data.spk$stress==TRUE,]
  data.sel <- if (vowels[1]=="ALL") data.fil else data.fil[data.fil$vowel %in% vowels,]
  
  colorscale <- scale_color_manual(values = c("a"="#F8766D","e"="#A3A500","i"="#00BF7D","o"="#E76BF3","u"="#00B0F6"))
  fillscale <- scale_fill_manual(values = c("a"="#F8766D","e"="#A3A500","i"="#00BF7D","o"="#E76BF3","u"="#00B0F6"))
  shapescale <- scale_shape_manual(values = c("TRUE"=19,"FALSE"=10),labels=c("[-phar]","[+phar]"))
  linescale <- scale_linetype_manual(values = c("TRUE"=1,"FALSE"=2),labels=c("[-phar]","[+phar]"))
  
  pl <- function(sp="ALL",ff="two.one"){
    switch(ff,
           two.one=qplot(F2Bk,F1Bk,data = data.sel,geom="point",
                         color=vowel,shape=phar,size=I(5),
                         xlab="F2 (Bark)", ylab="F1 (Bark)", main=paste(sp,"vowels in F2 x F1 space [int]")) +
                          #don't forget to remove [int] when obsolete
                          scale_x_reverse()+scale_y_reverse(),
           two.three=qplot(F2Bk,F3Bk,data = data.sel,geom="point",
                           color=vowel,shape=phar,size=I(5),
                           xlab="F2 (Bark)", ylab="F3 (Bark)", main=paste(sp,"vowels in F2 x F3 space [int]")) +
                            #don't forget to remove [int] when obsolete
             scale_x_reverse()
    )
  }
  
  th <- theme(title=element_text(size=I(20)),legend.title=element_text(size=I(16)),legend.text=element_text(size=I(16)),
              legend.key.size=unit(1,"cm"),
              strip.text=element_text(size=I(16)),axis.text=element_text(size=I(16)))
  
  pl(sp=speaker,ff=formants) + th + colorscale + fillscale + shapescale + linescale +
    stat_ellipse(geom = "polygon",alpha = 0.3,aes(fill = vowel,linetype=phar),
                 level = 0.68,size=rel(1),segments = 101)
  
}


formants.gg.pub <- function(data=data.a,speaker="ALL",formants="two.one",vowels=c("i","e","a","o","u","\u0259"),split="phar",filter="str"){
  #sizes are tuned for poster quality (~2400px)
  data.spk <- if (speaker=="ALL") data else data[data$speaker==speaker,]
  data.fil <- if (filter=="ALL") data.spk else data.spk[data.spk$stress==TRUE,]
  data.sel <- if (vowels[1]=="ALL") data.fil else data.fil[data.fil$vowel %in% vowels,]
  
  colorscale <- scale_color_manual(values = c("a"="#F8766D","e"="#A3A500","i"="#00BF7D","o"="#E76BF3","u"="#00B0F6"))
  fillscale <- scale_fill_manual(values = c("a"="#F8766D","e"="#A3A500","i"="#00BF7D","o"="#E76BF3","u"="#00B0F6"))
  shapescale <- scale_shape_manual(values = c("TRUE"=19,"FALSE"=10),labels=c("[-phar]","[+phar]"))
  linescale <- scale_linetype_manual(values = c("TRUE"=1,"FALSE"=2),labels=c("[-phar]","[+phar]"))
  
  pl <- function(sp="ALL",ff="two.one"){
    switch(ff,
           two.one=qplot(F2Bk,F1Bk,data = data.sel,geom="point",
                         color=vowel,shape=phar,size=I(10),
                         xlab="F2 (Bark)", ylab="F1 (Bark)", main=paste(sp,"vowels in F2 x F1 space")) +
             scale_x_reverse()+scale_y_reverse(),
           two.three=qplot(F2Bk,F3Bk,data = data.sel,geom="point",
                           color=vowel,shape=phar,size=I(10),
                           xlab="F2 (Bark)", ylab="F3 (Bark)", main=paste(sp,"vowels in F2 x F3 space")) +
             scale_x_reverse()
    )
  }
  
  th <- theme(title=element_text(size=I(48)),legend.title=element_text(size=I(40)),legend.text=element_text(size=I(36)),
              legend.key.size=unit(2,"cm"),
              strip.text=element_text(size=I(40)),axis.text=element_text(size=I(36)))
  
  pl(sp=speaker,ff=formants) + th + colorscale + fillscale + shapescale + linescale +
    stat_ellipse(geom = "polygon",alpha = 0.3,aes(fill = vowel,linetype=phar),
                 level = 0.68,size=rel(1),segments = 101)
  
}