add.descr <- function(data.in){
  phar <- ifelse(grepl("\u02e4", as.character(data.in$phone)), TRUE, FALSE)
  long <- ifelse(grepl("\u02d0", as.character(data.in$phone)), TRUE, FALSE)
  stress <- ifelse(grepl("\u0301", as.character(data.in$phone)), TRUE, FALSE)
  grps <- paste0(data.in$vowel,ifelse(phar==TRUE,"+ph",""))
  data.ph <- cbind(data.in, phar)
  data.lg <- cbind(data.ph, long)
  data.str <- cbind(data.lg, stress)
  data.out <- cbind(data.str, grps)
}

data.src <- read.delim("archi-formants-sum-corr.txt", encoding="UTF-8")
data.all <- add.descr(data.src)
data.a <- data.all[data.all$status != "Drop",]

data.b <- data.a[data.a$stress==T,]
data.P <- data.b[data.b$speaker=="PSX",]
data.H <- data.b[data.b$speaker=="HDK",]
data.J <- data.b[data.b$speaker=="JSP",]

data.i <- read.delim("archi-formants-int-sum.txt", encoding = "UTF-8")
data.i <- add.descr(data.i)

#spk <- c("PSX","JSP","HDK")
#sound <- c("archi-phon-2006-PSX-1-vowels","archi-sample","archi-sample")
#textgrid <- c("archi-sample.TextGrid","archi-sample.TextGrid","archi-sample.TextGrid")
#files.ls <- cbind(spk,sound)