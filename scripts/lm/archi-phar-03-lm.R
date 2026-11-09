## DURATION ~ PHAR

dur.L.mdl <-  lm(logDuration ~ speaker + long, data = ps.ALL.avg.mid)
tidy(dur.L.mdl)
glance(dur.L.mdl)

dur.L_P.mdl <-  lm(logDuration ~ speaker + long + phar, data = ps.ALL.avg.mid)
tidy(dur.L_P.mdl)
glance(dur.L_P.mdl)

dur.L_Q.mdl <-  lm(logDuration ~ speaker + long + qual, data = ps.ALL.avg.mid)
tidy(dur.L_Q.mdl)
glance(dur.L_Q.mdl)

dur.L_Q_P.mdl <-  lm(logDuration ~ speaker + long + qual + phar, data = ps.ALL.avg.mid)
tidy(dur.L_Q_P.mdl)
glance(dur.L_Q_P.mdl)

## FORMANTS

## Fn ~ VOWEL QUALITY

f1.Q.mdl <- lm(F1Bk ~ qual, data = ps.ALL.avg.mid)
tidy(f1.Q.mdl)
glance(f1.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.750

f2.Q.mdl <- lm(F2Bk ~ qual, data = ps.ALL.avg.mid)
tidy(f2.Q.mdl)
glance(f2.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.787

f3.Q.mdl <- lm(F3Bk ~ qual, data = ps.ALL.avg.mid)
tidy(f3.Q.mdl)
glance(f3.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.149

f3f2.Q.mdl <- lm(F3F2Bk ~ qual, data = ps.ALL.avg.mid)
tidy(f3f2.Q.mdl)
glance(f3f2.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.650


## Fn ~ HEIGHT or BACKNESS

f1.H.mdl <- lm(F1Bk ~ height, data = ps.ALL.avg.mid)
tidy(f1.H.mdl)
glance(f1.H.mdl)
#### [PSX-1_2_3:] aR²= 0.742

f1.B.mdl <- lm(F1Bk ~ backness, data = ps.ALL.avg.mid)
tidy(f1.B.mdl)
glance(f1.B.mdl)
#### [PSX-1_2_3:] aR²= 0.688

f2.H.mdl <- lm(F2Bk ~ height, data = ps.ALL.avg.mid)
tidy(f2.H.mdl)
glance(f2.H.mdl)
#### [PSX-1_2_3:] aR²= 0.0359

f2.B.mdl <- lm(F2Bk ~ backness, data = ps.ALL.avg.mid)
tidy(f2.B.mdl)
glance(f2.B.mdl)
#### [PSX-1_2_3:] aR²= 0.766

f3.H.mdl <- lm(F3Bk ~ height, data = ps.ALL.avg.mid)
tidy(f3.H.mdl)
glance(f3.H.mdl)
#### [PSX-1_2_3:] aR²= 0.0508

f3.B.mdl <- lm(F3Bk ~ backness, data = ps.ALL.avg.mid)
tidy(f3.B.mdl)
glance(f3.B.mdl)
#### [PSX-1_2_3:] aR²= 0.116

f3f2.H.mdl <- lm(F3F2Bk ~ height, data = ps.ALL.avg.mid)
tidy(f3f2.H.mdl)
glance(f3f2.H.mdl)
#### [PSX-1_2_3:] aR²= 0.0131

f3f2.B.mdl <- lm(F3F2Bk ~ backness, data = ps.ALL.avg.mid)
tidy(f3f2.B.mdl)
glance(f3f2.B.mdl)
#### [PSX-1_2_3:] aR²= 0.633


## Fn ~ VOWEL LENGTH

f1.L.mdl <- lm(F1Bk ~ long, data = ps.ALL.avg.mid)
tidy(f1.L.mdl)
glance(f1.L.mdl)
#### [PSX-1_2_3:] aR²= 0.00282

f2.L.mdl <- lm(F2Bk ~ long, data = ps.ALL.avg.mid)
tidy(f2.L.mdl)
glance(f2.L.mdl)
#### [PSX-1_2_3:] aR²= -0.0000279

f3.L.mdl <- lm(F3Bk ~ long, data = ps.ALL.avg.mid)
tidy(f3.L.mdl)
glance(f3.L.mdl)
#### [PSX-1_2_3:] aR²= -0.00000108

f3f2.L.mdl <- lm(F3F2Bk ~ long, data = ps.ALL.avg.mid)
tidy(f3f2.L.mdl)
glance(f3f2.L.mdl)
#### [PSX-1_2_3:] aR²= 0.0000323


## Fn ~ PHARYNGEALIZATION

f1.P.mdl <- lm(F1Bk ~ phar, data = ps.ALL.avg.mid)
tidy(f1.P.mdl)
glance(f1.P.mdl)
#### [PSX-1_2_3:] aR²= 0.0137

f2.P.mdl <- lm(F2Bk ~ phar, data = ps.ALL.avg.mid)
tidy(f2.P.mdl)
glance(f2.P.mdl)
#### [PSX-1_2_3:] aR²= 0.000229

f3.P.mdl <- lm(F3Bk ~ phar, data = ps.ALL.avg.mid)
tidy(f3.P.mdl)
glance(f3.P.mdl)
#### [PSX-1_2_3:] aR²= 0.263

f3f2.P.mdl <- lm(F3F2Bk ~ phar, data = ps.ALL.avg.mid)
tidy(f3f2.P.mdl)
glance(f3f2.P.mdl)
#### [PSX-1_2_3:] aR²= 0.0538


## Fn ~ PHARYNGEALIZATION +/* QUALITY

f3.P_Q.mdl <- lm(F3Bk ~ phar + qual, data = ps.ALL.avg.mid)
tidy(f3.P_Q.mdl)
glance(f3.P_Q.mdl)
#### [PSX-1_2_3:] aR²= 0.398

f3.PiQ.mdl <- lm(F3Bk ~ phar * qual, data = ps.ALL.avg.mid)
tidy(f3.PiQ.mdl)
glance(f3.PiQ.mdl)
#### [PSX-1_2_3:] aR²= 0.438

f3.PiH.mdl <- lm(F3Bk ~ phar * height, data = ps.ALL.avg.mid)
tidy(f3.PiH.mdl)
glance(f3.PiH.mdl)
#### [PSX-1_2_3:] aR²= 0.279

f3.PiB.mdl <- lm(F3Bk ~ phar * backness, data = ps.ALL.avg.mid)
tidy(f3.PiB.mdl)
glance(f3.PiB.mdl)
#### [PSX-1_2_3:] aR²= 0.419

f3f2.P_Q.mdl <- lm(F3F2Bk ~ phar + qual, data = ps.ALL.avg.mid)
tidy(f3f2.P_Q.mdl)
glance(f3f2.P_Q.mdl)
#### [PSX-1_2_3:] aR²= 0.691

f3f2.PiQ.mdl <- lm(F3F2Bk ~ phar * qual, data = ps.ALL.avg.mid)
tidy(f3f2.PiQ.mdl)
glance(f3f2.PiQ.mdl)
#### [PSX-1_2_3:] aR²= 0.709

f3f2.PiB.mdl <- lm(F3F2Bk ~ phar * backness, data = ps.ALL.avg.mid)
tidy(f3f2.PiB.mdl)
glance(f3f2.PiB.mdl)
#### [PSX-1_2_3:] aR²= 0.699


## Fn ~ PHARYNGEALIZATION +/* LENGTH +/* QUALITY

f3.P_L.mdl <- lm(F3Bk ~ phar + long, data = ps.ALL.avg.mid)
tidy(f3.P_L.mdl)
glance(f3.P_L.mdl)
#### [PSX-1_2_3:] aR²= 0.273

f3.PiL.mdl <- lm(F3Bk ~ phar * long, data = ps.ALL.avg.mid)
tidy(f3.PiL.mdl)
glance(f3.PiL.mdl)
#### [PSX-1_2_3:] aR²= 0.277

f3.PiQ_L.mdl <- lm(F3Bk ~ phar * qual + long, data = ps.ALL.avg.mid)
tidy(f3.PiQ_L.mdl)
glance(f3.PiQ_L.mdl)
#### [PSX-1_2_3:] aR²= 0.443

f3.PiQiL.mdl <- lm(F3Bk ~ phar * qual * long, data = ps.ALL.avg.mid)
tidy(f3.PiQiL.mdl)
glance(f3.PiQiL.mdl)
#### [PSX-1_2_3:] aR²= 0.461

f3f2.PiQiL.mdl <- lm(F3F2Bk ~ phar * qual * long, data = ps.ALL.avg.mid)
tidy(f3f2.PiQiL.mdl)
glance(f3f2.PiQiL.mdl)
#### [PSX-1_2_3:] aR²= 0.735

f3f2.PiBiL.mdl <- lm(F3F2Bk ~ phar * backness * long, data = ps.ALL.avg.mid)
tidy(f3f2.PiBiL.mdl)
glance(f3f2.PiBiL.mdl)
#### [PSX-1_2_3:] aR²= 0.723



### Harmonicity ###

cpp.Q.mdl <- lm(CPP ~ qual, data = ps.ALL.avg.mid)
tidy(cpp.Q.mdl)
glance(cpp.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.0399

cpp.H.mdl <- lm(CPP ~ height, data = ps.ALL.avg.mid)
tidy(cpp.H.mdl)
glance(cpp.H.mdl)
#### [PSX-1_2_3:] aR²= 0.0386

cpp.P_Q_L.mdl <- lm(CPP ~ phar + qual + long, data = ps.ALL.avg.mid)
tidy(cpp.P_Q_L.mdl)
glance(cpp.P_Q_L.mdl)
#### [PSX-1_2_3:] aR²= 0.120

cpp.P_H_L.mdl <- lm(CPP ~ phar + height + long, data = ps.ALL.avg.mid)
tidy(cpp.P_H_L.mdl)
glance(cpp.P_H_L.mdl)
#### [PSX-1_2_3:] aR²= 0.118

cpp.PiQ_L.mdl <- lm(CPP ~ phar * qual + long, data = ps.ALL.avg.mid)
tidy(cpp.PiQ_L.mdl)
glance(cpp.PiQ_L.mdl)
#### [PSX-1_2_3:] aR²= 0.128

cpp.PiL_Q.mdl <- lm(CPP ~ phar * long + qual, data = ps.ALL.avg.mid)
tidy(cpp.PiL_Q.mdl)
glance(cpp.PiL_Q.mdl)
#### [PSX-1_2_3:] aR²= 0.123

cpp.QiL_P.mdl <- lm(CPP ~ qual * long + phar, data = ps.ALL.avg.mid)
tidy(cpp.QiL_P.mdl)
glance(cpp.QiL_P.mdl)
#### [PSX-1_2_3:] aR²= 0.126

cpp.PiQiL.mdl <- lm(CPP ~  phar * qual * long, data = ps.ALL.avg.mid)
tidy(cpp.PiQiL.mdl)
glance(cpp.PiQiL.mdl)
#### [PSX-1_2_3:] aR²= 0.142

cpp.PiHiL.mdl <- lm(CPP ~  phar * height * long, data = ps.ALL.avg.mid)
tidy(cpp.PiHiL.mdl)
glance(cpp.PiHiL.mdl)
#### [PSX-1_2_3:] aR²= 0.128


hnr.Q.mdl <- lm(HNR05 ~ qual, data = ps.ALL.avg.mid)
tidy(hnr.Q.mdl)
glance(hnr.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.00181

hnr.P.mdl <- lm(HNR05 ~ phar, data = ps.ALL.avg.mid)
tidy(hnr.P.mdl)
glance(hnr.P.mdl)
#### [PSX-1_2_3:] aR²= 0.00171

hnr.PiQiL.mdl <- lm(HNR05 ~ phar * qual * long, data = ps.ALL.avg.mid)
tidy(hnr.PiQiL.mdl)
glance(hnr.PiQiL.mdl)
#### [PSX-1_2_3:] aR²= 0.0541



## SPECTRAL SLOPE

## H1*-H2*

h1h2.Q.mdl <- lm(H1H2c ~ qual, data = ps.ALL.avg.mid)
tidy(h1h2.Q.mdl)
glance(h1h2.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.104

h1h2.P.mdl <- lm(H1H2c ~ phar, data = ps.ALL.avg.mid)
tidy(h1h2.P.mdl)
glance(h1h2.P.mdl)
#### [PSX-1_2_3:] aR²= 0.00341

h1h2.P_Q.mdl <- lm(H1H2c ~ phar + qual, data = ps.ALL.avg.mid)
tidy(h1h2.P_Q.mdl)
glance(h1h2.P_Q.mdl)
#### [PSX-1_2_3:] aR²= 0.105

h1h2.PiQ.mdl <- lm(H1H2c ~ phar * qual, data = ps.ALL.avg.mid)
tidy(h1h2.PiQ.mdl)
glance(h1h2.PiQ.mdl)
#### [PSX-1_2_3:] aR²= 0.109

h1h2.P_Q_L.mdl <- lm(H1H2c ~ phar + qual + long, data = ps.ALL.avg.mid)
tidy(h1h2.P_Q_L.mdl)
glance(h1h2.P_Q_L.mdl)
#### [PSX-1_2_3:] aR²= 0.121

h1h2.PiQiL.mdl <- lm(H1H2c ~ phar * qual * long, data = ps.ALL.avg.mid)
tidy(h1h2.PiQiL.mdl)
glance(h1h2.PiQiL.mdl)
#### [PSX-1_2_3:] aR²= 0.145


## H2K-H5K

h2kh5k.Q.mdl <- lm(H2KH5Ku ~ speaker + qual, data = ps.ALL.avg.mid)
tidy(h2kh5k.Q.mdl)
glance(h2kh5k.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.352

h2kh5k.P.mdl <- lm(H2KH5Ku ~ speaker + phar, data = ps.ALL.avg.mid)
tidy(h2kh5k.P.mdl)
glance(h2kh5k.P.mdl)
#### [PSX-1_2_3:] aR²= 0.116

h2kh5k.P_Q.mdl <- lm(H2KH5Ku ~ speaker + phar + qual, data = ps.ALL.avg.mid)
tidy(h2kh5k.P_Q.mdl)
glance(h2kh5k.P_Q.mdl)
#### [PSX-1_2_3:] aR²= 0.439

h2kh5k.PiQ.mdl <- lm(H2KH5Ku ~ speaker + phar * qual, data = ps.ALL.avg.mid)
tidy(h2kh5k.PiQ.mdl)
glance(h2kh5k.PiQ.mdl)
#### [PSX-1_2_3:] aR²= 0.444

h2kh5k.PiQ_L.mdl <- lm(H2KH5Ku ~ speaker + phar * qual + long, data = ps.ALL.avg.mid)
tidy(h2kh5k.PiQ_L.mdl)
glance(h2kh5k.PiQ_L.mdl)
#### [PSX-1_2_3:] aR²= 0.452

h2kh5k.PiQiL.mdl <- lm(H2KH5Ku ~ speaker + phar * (qual + long), data = ps.ALL.avg.mid)
tidy(h2kh5k.PiQiL.mdl)
glance(h2kh5k.PiQiL.mdl)
#### [PSX-1_2_3:] aR²= 0.464



## H1*-A2*

h1a2.Q.mdl <- lm(H1A2c ~ qual, data = ps.ALL.avg.mid)
tidy(h1a2.Q.mdl)
glance(h1a2.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.317

h1a2.P.mdl <- lm(H1A2c ~ phar, data = ps.ALL.avg.mid)
tidy(h1a2.P.mdl)
glance(h1a2.P.mdl)
#### [PSX-1_2_3:] aR²= 0.000279

h1a2.P_Q.mdl <- lm(H1A2c ~ phar + qual, data = ps.ALL.avg.mid)
tidy(h1a2.P_Q.mdl)
glance(h1a2.P_Q.mdl)
#### [PSX-1_2_3:] aR²= 0.317

h1a2.PiQ.mdl <- lm(H1A2c ~ phar * qual, data = ps.ALL.avg.mid)
tidy(h1a2.PiQ.mdl)
glance(h1a2.PiQ.mdl)
#### [PSX-1_2_3:] aR²= 0.323

h1a2.P_Q_L.mdl <- lm(H1A2c ~ phar + qual + long, data = ps.ALL.avg.mid)
tidy(h1a2.P_Q_L.mdl)
glance(h1a2.P_Q_L.mdl)
#### [PSX-1_2_3:] aR²= 

h1a2.PiQiL.mdl <- lm(H1A2c ~ phar * qual * long, data = ps.ALL.avg.mid)
tidy(h1a2.PiQiL.mdl)
glance(h1a2.PiQiL.mdl)
#### [PSX-1_2_3:] aR²= 



## H1*-A3*

h1a3.Q.mdl <- lm(H1A3c ~ qual, data = ps.ALL.avg.mid)
tidy(h1a3.Q.mdl)
glance(h1a3.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.00112

h1a3.P.mdl <- lm(H1A3c ~ phar, data = ps.ALL.avg.mid)
tidy(h1a3.P.mdl)
glance(h1a3.P.mdl)
#### [PSX-1_2_3:] aR²= 0.0542

h1a3.P_Q.mdl <- lm(H1A3c ~ phar + qual, data = ps.ALL.avg.mid)
tidy(h1a3.P_Q.mdl)
glance(h1a3.P_Q.mdl)
#### [PSX-1_2_3:] aR²= 0.0614

h1a3.PiQ.mdl <- lm(H1A3c ~ phar * qual, data = ps.ALL.avg.mid)
tidy(h1a3.PiQ.mdl)
glance(h1a3.PiQ.mdl)
#### [PSX-1_2_3:] aR²= 0.0685

h1a3.P_Q_L.mdl <- lm(H1A3c ~ phar + qual + long, data = ps.ALL.avg.mid)
tidy(h1a3.P_Q_L.mdl)
glance(h1a3.P_Q_L.mdl)
#### [PSX-1_2_3:] aR²= 0.0889

h1a3.PiQiL.mdl <- lm(H1A3c ~ phar * qual * long, data = ps.ALL.avg.mid)
tidy(h1a3.PiQiL.mdl)
glance(h1a3.PiQiL.mdl)
#### [PSX-1_2_3:] aR²= 0.137



## A2*-A3*

a2a3.Q.mdl <- lm(A2A3c ~ qual, data = ps.ALL.avg.mid)
tidy(a2a3.Q.mdl)
glance(a2a3.Q.mdl)
#### [PSX-1_2_3:] aR²= 0.340

a2a3.P.mdl <- lm(A2A3c ~ phar, data = ps.ALL.avg.mid)
tidy(a2a3.P.mdl)
glance(a2a3.P.mdl)
#### [PSX-1_2_3:] aR²= 0.0525

a2a3.P_Q.mdl <- lm(A2A3c ~ phar + qual, data = ps.ALL.avg.mid)
tidy(a2a3.P_Q.mdl)
glance(a2a3.P_Q.mdl)
#### [PSX-1_2_3:] aR²= 0.389

a2a3.PiQ.mdl <- lm(A2A3c ~ phar * qual, data = ps.ALL.avg.mid)
tidy(a2a3.PiQ.mdl)
glance(a2a3.PiQ.mdl)
#### [PSX-1_2_3:] aR²= 0.401

a2a3.P_Q_L.mdl <- lm(A2A3c ~ phar + qual + long, data = ps.ALL.avg.mid)
tidy(a2a3.P_Q_L.mdl)
glance(a2a3.P_Q_L.mdl)
#### [PSX-1_2_3:] aR²= 0.389

a2a3.PiQiL.mdl <- lm(A2A3c ~ phar * qual * long, data = ps.ALL.avg.mid)
tidy(a2a3.PiQiL.mdl)
glance(a2a3.PiQiL.mdl)
#### [PSX-1_2_3:] aR²= 0.419
