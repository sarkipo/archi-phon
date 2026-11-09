ps.ALL.avg %>% 
  filter(qual == "I") %>%
  group_by(speaker,phar,long) %>%
  summarise(across(c(F1,F2,F3),median))

tokens <- ps.ALL.avg.mid %>% 
  group_by(speaker,qual,phar) %>%
  summarise(n = n()) %>%
  pivot_wider(names_from = c("speaker","phar"), values_from = "n")
write_tsv(tokens,"tokens.tsv")

sum.h2kh5k <- ps.ALL.avg %>% 
  group_by(speaker,qual,long,phar) %>%
  summarise(H2KH5Ku = median(H2KH5Ku))
