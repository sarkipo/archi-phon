## DURATION ~ PHAR

## no random effects
dur.L.mdl <-  lm(logDuration_z ~ long, data = ps.ALL.avg.mid)
summary(dur.L.mdl)
glance(dur.L.mdl)

## per speaker
dur.LS.mdl <-  lm(logDuration_z ~ long + speaker, data = ps.ALL.avg.mid)
summary(dur.LS.mdl)
glance(dur.LS.mdl)

## long*speaker interaction
dur.LiS.mdl <-  lm(logDuration_z ~ long*speaker, data = ps.ALL.avg.mid)
summary(dur.LiS.mdl)
glance(dur.LiS.mdl)
## not better than without interaction

## length and qual per speaker
dur.LQS.mdl <-  lm(logDuration_z ~ long + qual + speaker, data = ps.ALL.avg.mid)
summary(dur.LQS.mdl)
glance(dur.LQS.mdl)

## length*qual per speaker
dur.LiQ_S.mdl <-  lm(logDuration_z ~ long * qual + speaker, data = ps.ALL.avg.mid)
summary(dur.LiQ_S.mdl)
glance(dur.LiQ_S.mdl)
## anova: not better than without interaction

## length and backness per speaker
dur.LBS.mdl <-  lm(logDuration_z ~ long + backness + speaker, data = ps.ALL.avg.mid)
summary(dur.LBS.mdl)
glance(dur.LBS.mdl)

## length and height per speaker
dur.LHS.mdl <-  lm(logDuration_z ~ long + height + speaker, data = ps.ALL.avg.mid)
summary(dur.LHS.mdl)
glance(dur.LHS.mdl)
## anova: height not different from quality (i.e. can use height as simpler parameter)



## null model with word random effect
dur.0.w.mdl <-  lmer(logDuration_z ~ (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(dur.0.w.mdl)
r.squaredGLMM(dur.0.w.mdl)

## speaker with word random effect
dur.S.w.mdl <-  lmer(logDuration_z ~ speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(dur.S.w.mdl)
r.squaredGLMM(dur.S.w.mdl)

## length per speaker with word random effect
dur.LS.w.mdl <-  lmer(logDuration_z ~ long + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(dur.LS.w.mdl)
r.squaredGLMM(dur.LS.w.mdl)

## phar per speaker with word random effect
dur.PS.w.mdl <-  lmer(logDuration_z ~ phar + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(dur.PS.w.mdl)
r.squaredGLMM(dur.PS.w.mdl)

## length and phar per speaker with word random effect
dur.LPS.w.mdl <-  lmer(logDuration_z ~ long + phar + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(dur.LPS.w.mdl)
r.squaredGLMM(dur.LPS.w.mdl)
## PS vs. PLS anova: 0.000671, still ***

## length*phar per speaker with word random effect
dur.LiP_S.w.mdl <-  lmer(logDuration_z ~ long * phar + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(dur.LiP_S.w.mdl)
r.squaredGLMM(dur.LiP_S.w.mdl)
## not better than without interaction


## length and height per speaker with word random effect
dur.LHS.w.mdl <-  lmer(logDuration_z ~ long + height + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(dur.LHS.w.mdl)
r.squaredGLMM(dur.LHS.w.mdl)

## length + height + phar per speaker with word random effect
dur.LHPS.w.mdl <-  lmer(logDuration_z ~ long + height + phar + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(dur.LHPS.w.mdl)
r.squaredGLMM(dur.LHPS.w.mdl)
## tiny bit better AIC & R2m than without phar, same BIC, R2c tiny bit worse
## anova LHS vs. LHPS: 0.007087 **

## length + height*phar per speaker with word random effect
dur.HiP_LS.w.mdl <-  lmer(logDuration_z ~ long + height*phar + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(dur.HiP_LS.w.mdl)
r.squaredGLMM(dur.HiP_LS.w.mdl)
## qual*phar not interesting


##
## F0
##


## null model with word random effect
pitch.0.w.mdl <-  lmer(logF0 ~ (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(pitch.0.w.mdl)
r.squaredGLMM(pitch.0.w.mdl)

## speaker with word random effect
pitch.S.w.mdl <-  lmer(logF0 ~ speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(pitch.S.w.mdl)
r.squaredGLMM(pitch.S.w.mdl)
anova(pitch.0.w.mdl, pitch.S.w.mdl, test="Chisq")

## length + speaker with word random effect
pitch.LS.w.mdl <-  lmer(logF0 ~ long + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
## n.s.

## height + speaker with word random effect
pitch.HS.w.mdl <-  lmer(logF0 ~ height + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(pitch.HS.w.mdl)
r.squaredGLMM(pitch.HS.w.mdl)
anova(pitch.S.w.mdl, pitch.HS.w.mdl)

## backness + speaker with word random effect
pitch.BS.w.mdl <-  lmer(logF0 ~ backness + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(pitch.BS.w.mdl)
r.squaredGLMM(pitch.BS.w.mdl)
anova(pitch.S.w.mdl, pitch.BS.w.mdl)
## still yes...

## quality + speaker with word random effect
pitch.QS.w.mdl <-  lmer(logF0 ~ qual + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(pitch.QS.w.mdl)
r.squaredGLMM(pitch.QS.w.mdl)
anova(pitch.HS.w.mdl, pitch.QS.w.mdl)
## but qual not better than height

## phar + height + speaker with word random effect
pitch.PHS.w.mdl <-  lmer(logF0 ~ phar + height + speaker + (1|wordRussian), data = ps.ALL.avg.mid, REML = FALSE)
summary(pitch.PHS.w.mdl)
r.squaredGLMM(pitch.PHS.w.mdl)
anova(pitch.HS.w.mdl, pitch.PHS.w.mdl)
## PHAR does not add




##
## F3
##

## response
resp.F3 <- "F3Bk"

## formulas
fflist.F3 <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+L+Q+S+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.F3 <- c(1:7)
comp_with.F3 <- c(0,1,2,2,2,5,6)

## call
F3.mdl.df <- build_models(resp.F3,fflist.F3,ps.ALL.avg.mid,model_num.F3,comp_with.F3)

## ITOGO
## Q is better than H & B, L is n.s., P is good (6.657245e-61)



##
## F2
##

## response
resp.F2 <- "F2Bk"

## formulas
fflist.F2 <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+L+Q+S+(1|W)",
  '8' = "P*Q+S+(1|W)",
  '9' = "P*B+S+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.F2 <- c(1:9)
comp_with.F2 <- c(0,1,2,2,2,5,6,5,4)

## call
F2.mdl.df <- build_models(resp.F2,fflist.F2,ps.ALL.avg.mid,model_num.F2,comp_with.F2)

## ITOGO
## Q > B >> H, L & P n.s.


##
## F1
##

## response
resp.F1 <- "F1Bk"

## formulas
fflist.F1 <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+L+Q+S+(1|W)",
  '8' = "P+Q+S+(1|W)",
  '9' = "P*Q+S+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.F1 <- c(1:9)
comp_with.F1 <- c(0,1,2,2,2,5,6,5,8)

## call
F1.mdl.df <- build_models(resp.F1,fflist.F1,ps.ALL.avg.mid,model_num.F1,comp_with.F1)

## ITOGO
## '9' = "P*Q+S+(1|W)" is the best. L is n.s. Q >~ H.


## F3F2, F2F1, F1F0
## H1H2, H2H4, H4H2K, H2KH5K
## H2K, H5K
## H1A1, H1A2, H1A3
## A1, A2, A3
## A1A2, A1A3, A2A3
## CPP, HNR05, HNR15, HNR25, HNR35
## int, soe

## fixef: phar, long, backness, height, speaker
## ranef: wordRussian

## F0, FF


## FF-FF


## HH-HH

##
## H1H2
##

## response
resp.H1H2 <- "H1H2c"

## formulas
fflist.H1H2 <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.H1H2 <- c(1:7)
comp_with.H1H2 <- c(0,1,2,2,2,5,5)

## call
H1H2.mdl.df <- build_models(resp.H1H2,fflist.H1H2,ps.ALL.avg.mid,model_num.H1H2,comp_with.H1H2)

## ITOGO
## P & L n.s. Q = H, H > B; singular fit (word)


##
## H2H4
##

## response
resp.H2H4 <- "H2H4c"

## formulas
fflist.H2H4 <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.H2H4 <- c(1:7)
comp_with.H2H4 <- c(0,1,2,2,2,5,5)

## call
H2H4.mdl.df <- build_models(resp.H2H4,fflist.H2H4,ps.ALL.avg.mid,model_num.H2H4,comp_with.H2H4)

## ITOGO
## L & P n.s. Q > B, H.


##
## H4H2K
##

## response
resp.H4H2K <- "H4H2K"

## formulas
fflist.H4H2K <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)",
  '8' = "P*Q+S+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.H4H2K <- c(1:8)
comp_with.H4H2K <- c(0,1,2,2,2,5,5,7)

## call
H4H2K.mdl.df <- build_models(resp.H4H2K,fflist.H4H2K,ps.ALL.avg.mid,model_num.H4H2K,comp_with.H4H2K)

## ITOGO
## L n.s. P works.(pharPhar     Est. -4.2375     0.6935  -6.110). P*Q not unambiguously better.


##
## H2KH5K
##

## response
resp.H2KH5K <- "H2KH5Ku"

## formulas
fflist.H2KH5K <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)",
  '8' = "P*Q+S+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.H2KH5K <- c(1:8)
comp_with.H2KH5K <- c(0,1,2,2,2,5,5,7)

## call
H2KH5K.mdl.df <- build_models(resp.H2KH5K,fflist.H2KH5K,ps.ALL.avg.mid,model_num.H2KH5K,comp_with.H2KH5K)

## ITOGO
## L n.s. P strong.(pharPhar     Est.  7.9338     0.7219  10.990). P*Q not sign. better.
## BOTH H2K higher AND H5K lower (see below)



##
## H2K
##

## response
resp.H2K <- "H2Ku"

## formulas
fflist.H2K <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)",
  '8' = "P*Q+S+(1|W)",
  '9' = "P*S+Q+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.H2K <- c(1:9)
comp_with.H2K <- c(0,1,2,2,2,5,5,7,7)

## call
H2K.mdl.df <- build_models(resp.H2K,fflist.H2K,ps.ALL.avg.mid,model_num.H2K,comp_with.H2K)

## ITOGO
## L n.s. P works.(pharPhar     Est. 3.8896     0.6644   5.855). P*Q, P*S not better.



##
## H5K
##

## response
resp.H5K <- "H5Ku"

## formulas
fflist.H5K <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)",
  '8' = "P*Q+S+(1|W)",
  '9' = "P*S+Q+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.H5K <- c(1:9)
comp_with.H5K <- c(0,1,2,2,2,5,5,7,7)

## call
H5K.mdl.df <- build_models(resp.H5K,fflist.H5K,ps.ALL.avg.mid,model_num.H5K,comp_with.H5K)

## ITOGO
## P good (pharPhar     -3.8301     0.6419  -5.967). L, P*Q, P*S not worth.


## HH-AA


## AA

##
## A1
##

## response
resp.A1 <- "A1c"

## formulas
fflist.A1 <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)",
  '8' = "P*Q+S+(1|W)",
  '9' = "P*S+Q+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.A1 <- c(1:9)
comp_with.A1 <- c(0,1,2,2,2,5,5,7,7)

## call
A1.mdl.df <- build_models(resp.A1,fflist.A1,ps.ALL.avg.mid,model_num.A1,comp_with.A1)

## ITOGO
## P marginally

##
## A2
##

## response
resp.A2 <- "A2c"

## formulas
fflist.A2 <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)",
  '8' = "P*Q+S+(1|W)",
  '9' = "P*S+Q+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.A2 <- c(1:9)
comp_with.A2 <- c(0,1,2,2,2,5,5,7,7)

## call
A2.mdl.df <- build_models(resp.A2,fflist.A2,ps.ALL.avg.mid,model_num.A2,comp_with.A2)

## ITOGO
## P,L not at all.


##
## A3
##

## response
resp.A3 <- "A3c"

## formulas
fflist.A3 <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)",
  '8' = "P*Q+S+(1|W)",
  '9' = "P*S+Q+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.A3 <- c(1:9)
comp_with.A3 <- c(0,1,2,2,2,5,5,7,7)

## call
A3.mdl.df <- build_models(resp.A3,fflist.A3,ps.ALL.avg.mid,model_num.A3,comp_with.A3)

## ITOGO
## P works (pharPhar     -6.1495     0.5377 -11.437), P*Q a little better (pharPhar:qualO -5.58769    1.35775  -4.115), P*S not worth.


## AA-AA


## HARMONICITY

##
## CPP
##

## response
resp.CPP <- "CPP"

## formulas
fflist.CPP <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.CPP <- c(1:7)
comp_with.CPP <- c(0,1,2,2,2,5,5)

## call
CPP.mdl.df <- build_models(resp.CPP,fflist.CPP,ps.ALL.avg.mid,model_num.CPP,comp_with.CPP)

## ITOGO
## Q = H > B. P n.s. L a bit.


##
## HNR05
##

## response
resp.HNR05 <- "HNR05"

## formulas
fflist.HNR05 <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.HNR05 <- c(1:7)
comp_with.HNR05 <- c(0,1,2,2,2,5,5)

## call
HNR05.mdl.df <- build_models(resp.HNR05,fflist.HNR05,ps.ALL.avg.mid,model_num.HNR05,comp_with.HNR05)

## ITOGO
## P tiny bit sign. L much more than P.


##
## HNR35
##

## response
resp.HNR35 <- "HNR35"

## formulas
fflist.HNR35 <- c(
  '1' = "(1|W)",
  '2' = "S+(1|W)",
  '3' = "H+S+(1|W)",
  '4' = "B+S+(1|W)",
  '5' = "Q+S+(1|W)",
  '6' = "L+Q+S+(1|W)",
  '7' = "P+Q+S+(1|W)"
)

## model indexes for pairwise testing with anova
model_num.HNR35 <- c(1:7)
comp_with.HNR35 <- c(0,1,2,2,2,5,5)

## call
HNR35.mdl.df <- build_models(resp.HNR35,fflist.HNR35,ps.ALL.avg.mid,model_num.HNR35,comp_with.HNR35)

## ITOGO
## P n.s. L sign.


## INT, SOE
