formants.gg <- function(data=ps.ALL.avg.mid,speaker="ALL",formants="two.one",vowels=c("I","E","A","O","U"),filter="ALL"){
  data.spk <- if (speaker=="ALL") data else data[data$speaker==speaker,]
  data.fil <- if (filter=="ALL") data.spk else data.spk[data.spk$stress==TRUE,]
  data.sel <- if (vowels[1]=="ALL") data.fil else data.fil[data.fil$qual %in% vowels,]
  
  colorscale <- scale_color_manual(values = c("A"="#F8766D","E"="#A3A500","I"="#00BF7D","O"="#E76BF3","U"="#00B0F6"))
  fillscale <- scale_fill_manual(values = c("A"="#F8766D","E"="#A3A500","I"="#00BF7D","O"="#E76BF3","U"="#00B0F6"))
  shapescale <- scale_shape_manual(values = c("Plain"=10,"Phar"=19),labels=c("[–phar]","[+phar]"))
  linescale <- scale_linetype_manual(values = c("Plain"=2,"Phar"=1),labels=c("[–phar]","[+phar]"))
  
  pl <- function(sp="ALL",ff="two.one"){
    switch(ff,
           two.one=qplot(F2Bk,F1Bk,data = data.sel,geom="point",
                         color=qual,shape=phar,size=I(4),
                         xlab="F2 (Bark)", ylab="F1 (Bark)", main=paste(sp,"vowels in F2 x F1 space")) +
                          #don't forget to remove [int] when obsolete
                          scale_x_reverse()+scale_y_reverse(),
           two.three=qplot(F2Bk,F3Bk,data = data.sel,geom="point",
                           color=qual,shape=phar,size=I(4),
                           xlab="F2 (Bark)", ylab="F3 (Bark)", main=paste(sp,"vowels in F2 x F3 space")) +
                            #don't forget to remove [int] when obsolete
             scale_x_reverse()
    )
  }
  
  th <- theme(title=element_text(size=I(20)),legend.title=element_text(size=I(16)),legend.text=element_text(size=I(16)),
              legend.key.size=unit(1,"cm"),
              strip.text=element_text(size=I(16)),axis.text=element_text(size=I(16)))
  
  leg <- labs(dictionary = c(phar = "Phar", qual = "Vowel"))
  
  pl(sp=speaker,ff=formants) + th + leg + colorscale + fillscale + shapescale + linescale +
    stat_ellipse(geom = "polygon",alpha = 0.3,aes(fill = qual,linetype=phar),
                 level = 0.68,size=rel(1),segments = 101) 
  
}

formants.gg(speaker="PSX")+
#  geom_vline(aes(xintercept = bark(2000)), linetype = "dashed") +
  coord_cartesian(xlim = c(7.2,15.8), ylim = c(3,9))
  
formants.gg(speaker="PSX",formants="two.three")+
#  geom_vline(aes(xintercept = bark(2000)), linetype = "dashed") +
  coord_cartesian(xlim = c(7.2,15.8), ylim = c(13,17))

formants.gg(speaker="HDK")
formants.gg(speaker="HDK",formants="two.three")

formants.gg(speaker="JSP")+
  coord_cartesian(ylim = c(3,7))
formants.gg(speaker="JSP",formants="two.three")+
  coord_cartesian(ylim = c(11.8,15.6))


## A3 plot

th.violin <- theme(title=element_text(size=I(20)),legend.title=element_text(size=I(16)),legend.text=element_text(size=I(16)),
            legend.key.size=unit(1,"cm"),
            strip.text=element_text(size=I(16)),axis.text=element_text(size=I(16)))

A3.gg <- ggplot(data = ps.ALL.avg.mid) +
  facet_grid(rows = vars(speaker), cols = vars(qual), scales = "free_y") +
  geom_violin(aes(y = A3c, x = phar, alpha = phar, fill = qual), 
              scale = "count",linewidth = 1,
              quantile.linetype = "solid", quantile.color = "black",  quantiles=c(0.5)) +
  scale_alpha_manual(values = c("Plain"=0.3,"Phar"=1), guide = "none") +
  scale_color_manual(values = c("A"="#F8766D","E"="#A3A500","I"="#00BF7D","O"="#E76BF3","U"="#00B0F6")) +
  scale_fill_manual(values = c("A"="#F8766D","E"="#A3A500","I"="#00BF7D","O"="#E76BF3","U"="#00B0F6")) +
  labs(title = "A3* per vowel and speaker") +
  th.violin

A3.gg


H2KH5K.gg <- ggplot(data = ps.ALL.avg.mid) +
  facet_grid(rows = vars(speaker), cols = vars(qual), scales = "free_y") +
  geom_violin(aes(y = H2KH5Ku, x = phar, alpha = phar, fill = qual), 
              scale = "count",linewidth = 1,
              quantile.linetype = "solid", quantile.color = "black",  quantiles=c(0.5)) +
  scale_alpha_manual(values = c("Plain"=0.3,"Phar"=1), guide = "none") +
  scale_color_manual(values = c("A"="#F8766D","E"="#A3A500","I"="#00BF7D","O"="#E76BF3","U"="#00B0F6")) +
  scale_fill_manual(values = c("A"="#F8766D","E"="#A3A500","I"="#00BF7D","O"="#E76BF3","U"="#00B0F6")) +
  labs(title = "H2k-H5k per vowel and speaker") +
  th.violin

H2KH5K.gg


dur.gg <- ggplot(data = ps.ALL.avg.mid) +
  facet_grid(cols = vars(speaker, long)) +
  geom_violin(aes(y = logDuration, x = phar, alpha = phar, fill = long, color = long), 
              scale = "count",linewidth = 1,
              quantile.linetype = "solid", quantile.color = "black",  quantiles=c(0.5)) +
#  scale_alpha_manual(values = c("Plain"=0.3,"Phar"=1)) +
  scale_alpha_manual(values = c("Plain"=0.3,"Phar"=1), guide = "none") +
  #scale_color_manual(values = c("A"="#F8766D","E"="#A3A500","I"="#00BF7D","O"="#E76BF3","U"="#00B0F6")) +
  #scale_fill_manual(values = c("A"="#F8766D","E"="#A3A500","I"="#00BF7D","O"="#E76BF3","U"="#00B0F6")) +
  labs(title = "Pharyngealisation and vowel duration in short and long vowels") +
  th.violin

dur.gg
