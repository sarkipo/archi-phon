## Read PraatSauce data

ps.PSX.src <- read_tsv("../../praatsauce/praatsauce-PSX-1_2_3-FT.tsv")
ps.JSP.src <- read_tsv("../../praatsauce/praatsauce-JSP-1_2-FT.tsv")
ps.HDK.src <- read_tsv("../../praatsauce/praatsauce-HDK-1_2-FT.tsv")

## add speaker, restore time bins, 
## filter out undefined/0 pitch, cast all as numeric (those with "undefined" are imported as char)
ps.PSX.bins <- ps.PSX.src %>%
  mutate(speaker = factor(str_extract(file, "archi-phon-2006-([A-Z]{3})-", group = 1))) %>%
  group_by(speaker,file,intervaldID) %>%
  mutate(timebin_11 = ntile(t,11)) %>%
  filter(f0 != "--undefined--" & f0 != 0 & soe != "--undefined--") %>%
  mutate(across(t:soe, ~ as.numeric(.x)))

ps.JSP.bins <- ps.JSP.src %>%
  mutate(speaker = factor(str_extract(file, "archi-phon-2006-([A-Z]{3})-", group = 1))) %>%
  group_by(speaker,file,intervaldID) %>%
  mutate(timebin_11 = ntile(t,11)) %>%
  filter(f0 != "--undefined--" & f0 != 0 & soe != "--undefined--") %>%
  mutate(across(t:soe, ~ as.numeric(.x)))

ps.HDK.bins <- ps.HDK.src %>%
  mutate(speaker = factor(str_extract(file, "archi-phon-2006-([A-Z]{3})-", group = 1))) %>%
  group_by(speaker,file,intervaldID) %>%
  mutate(timebin_11 = ntile(t,11)) %>%
  filter(f0 != "--undefined--" & f0 != 0 & soe != "--undefined--") %>%
  mutate(across(t:soe, ~ as.numeric(.x)))

ps.ALL.bins <- bind_rows(ps.PSX.bins, ps.JSP.bins, ps.HDK.bins) %>%
  ## chop off file extension otherwise no match with FT segmentation
  mutate(file = str_remove(file, ".wav"))


## summarize errors
ps.PSX.err <- ps.PSX.src %>%
  mutate(speaker = factor(str_extract(file, "archi-phon-2006-([A-Z]{3})-", group = 1))) %>%
  group_by(file,intervaldID) %>%
  mutate(totalPoints = n()) %>%
  filter(f0 == "--undefined--" | f0 == 0 | soe == "--undefined--") %>%
  select(file:F3,soe,totalPoints) %>%
  mutate(across(c(f0,soe), ~ as.character(.x)))

ps.JSP.err <- ps.JSP.src %>%
  mutate(speaker = factor(str_extract(file, "archi-phon-2006-([A-Z]{3})-", group = 1))) %>%
  group_by(file,intervaldID) %>%
  mutate(totalPoints = n()) %>%
  filter(f0 == "--undefined--" | f0 == 0 | soe == "--undefined--") %>%
  select(file:F3,soe,totalPoints) %>%
  mutate(across(c(f0,soe), ~ as.character(.x)))

ps.HDK.err <- ps.HDK.src %>%
  mutate(speaker = factor(str_extract(file, "archi-phon-2006-([A-Z]{3})-", group = 1))) %>%
  group_by(file,intervaldID) %>%
  mutate(totalPoints = n()) %>%
  filter(f0 == "--undefined--" | f0 == 0 | soe == "--undefined--") %>%
  select(file:F3,soe,totalPoints) %>%
  mutate(across(c(f0,soe), ~ as.character(.x)))

ps.ALL.err <- bind_rows(ps.PSX.err, ps.JSP.err, ps.HDK.err)



## Read FT segmentation, get Russian translations as word IDs
segm.PSX.src <- read_csv("../../fasttrack/segmentation_information-PSX-1_2_3.csv")
segm.HDK.src <- read_csv("../../fasttrack/segmentation_information-HDK-1_2.csv")
segm.JSP.src <- read_csv("../../fasttrack/segmentation_information-JSP-1_2.csv")

segm.ALL.src <- bind_rows(segm.PSX.src, segm.JSP.src, segm.HDK.src)


## quick & dirty fix for NAs
segm.ALL.sel <- segm.ALL.src %>%
  select(inputfile,outputfile,vowel,duration,start,end,word,comment1) %>%
  replace_na(list(comment1 = "-")) %>%
  rename(wordRussian = comment1, file = inputfile) %>% mutate(
    outputfile = factor(outputfile),
    wordRussian = factor(wordRussian)
  )

## report NAs
segm.ALL.err <- segm.ALL.src %>%
  select(inputfile,outputfile,vowel,duration,start,end,word,comment1) %>%
  filter(is.na(comment1)) %>%
  rename(wordRussian = comment1, file = inputfile) %>% 
  mutate(outputfile = factor(outputfile))


by <- join_by(file,between(t,start,end))
ps.ALL.segm <- inner_join(ps.ALL.bins, segm.ALL.sel, by)


## report match errors
ps.ALL.err_segm <- anti_join(ps.ALL.bins, segm.ALL.sel, by) %>%
  group_by(speaker,file,label,intervaldID) %>%
  summarise(tmin = min(t), tmax = max(t))


## Add vowel features, bark frequencies, An-diff
## ungroup in order to standardise
ps.ALL.raw <- ps.ALL.segm %>% ungroup() %>% mutate(
  file = factor(file),
  phar = factor(class_phar(label), levels = c("Plain","Phar")),
  long = factor(class_long(label), levels = c("Short","Long")),
  qual = factor(class_quality(label), levels = c("A", "E", "I", "O", "U")),
  height = factor(class_height(label), levels = c("Low","Mid","High")),
  backness = factor(class_backness(label), levels = c("Central","Front","Back")),
  logDuration = log10(duration),
  logDuration_z = zscore(logDuration),
## formants
  F3F2 = F3 - F2,
  F1Bk = bark(F1),
  F1_z = zscore(F1Bk),
  F2Bk = bark(F2),
  F2_z = zscore(F2Bk),
  F3Bk = bark(F3),
  F3_z = zscore(F3Bk),
  F3F2Bk = F3Bk - F2Bk,
  F2F1_z = zscore(F2Bk - F1Bk),
  F3F2_z = zscore(F3F2Bk),
## spectral slope
  H4K_z = zscore(H4c),
  H2K_z = zscore(H2Ku),
  H5K_z = zscore(H5Ku),
  H1H2_z = zscore(H1H2c),
  H2H4_z = zscore(H2H4c),
  H4H2K = H4c - H2Ku,
  H4H2K_z = zscore(H4H2K),
  H2KH5K_z = zscore(H2KH5Ku),
  H1A1_z = zscore(H1A1c),
  H1A2_z = zscore(H1A2c),
  H1A3_z = zscore(H1A3c),
  A3_z = zscore(A3c),
  A1A2c = A1c - A2c,
  A1A2_z = zscore(A1A2c),
  A1A3c = A1c - A3c,
  A1A3_z = zscore(A1A3c),
  A2A3c = A2c - A3c,
  A2A3_z = zscore(A2A3c),
## harmonicity
  CPP_z = zscore(CPP),
  HNR05_z = zscore(HNR05),
  HNR15_z = zscore(HNR15),
  HNR25_z = zscore(HNR25),
  HNR35_z = zscore(HNR35),
## varia
  logF0 = log10(f0),
  f0_z = zscore(log10(f0)),
  F1F0_z = zscore(F1Bk - bark(f0)),
  intensity_z = zscore(intensity),
  soe_z = zscore(soe)
)

## drop first and last bin, regroup into three bins, medianize all values per bin
ps.ALL.avg <- ps.ALL.raw %>% 
  filter(timebin_11 > 1 & timebin_11 < 11)  %>%
  mutate(timebin_3 = ntile(timebin_11,3)) %>%
  select(!timebin_11) %>%
  group_by(speaker,file,intervaldID,timebin_3) %>%
  summarise(
    label = first(label), 
    across(where(is.factor),first),
    across(where(is.numeric),median)
    )

## take only the middle of the three bins
ps.ALL.avg.mid <- ps.ALL.avg %>% 
  filter(timebin_3 == 2) %>%
  select(!timebin_3)
