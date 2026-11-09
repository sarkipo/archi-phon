library(tidyverse)
library(broom)
library(conflicted)
library(emuR)
library(lme4)
library(MuMIn)

conflict_prefer("slice", "dplyr")
conflict_prefer("filter", "dplyr")


## define convenience functions

class_phar <- function(sound)
{
  case_when(
    str_detect(sound,"\u02e4") ~ "Phar",
    .default = "Plain"
  )
}

class_long <- function(sound)
{
  case_when(
    str_detect(sound,"\u02d0") ~ "Long",
    .default = "Short"
  )
}

class_quality <- function(sound)
{
  first_char <- str_sub(sound,1,1) %>% str_to_upper()
}

class_height <- function(sound)
{
  first_char <- str_sub(sound,1,1) %>% str_to_upper()
  case_when(
    first_char == "A" ~ "Low",
    first_char == "E" ~ "Mid",
    first_char == "I" ~ "High",
    first_char == "O" ~ "Mid",
    first_char == "U" ~ "High",
    .default = "Unknown"
  )
}

class_backness <- function(sound)
{
  first_char <- str_sub(sound,1,1) %>% str_to_upper()
  case_when(
    first_char == "A" ~ "Central",
    first_char == "E" ~ "Front",
    first_char == "I" ~ "Front",
    first_char == "O" ~ "Back",
    first_char == "U" ~ "Back",
    .default = "Unknown"
  )
}

zscore <- function(input)
{
  (input - mean(input))/sd(input)
}

label2var <- function(label)
{
  case_when(
    label == "H" ~ "height",
    label == "B" ~ "backness",
    label == "Q" ~ "qual",
    label == "L" ~ "long",
    label == "P" ~ "phar",
    label == "S" ~ "speaker",
    label == "W" ~ "wordRussian"
  )
}

labels2vars <- function(labels)
{
  str_replace_all(labels,"[A-Za-z]+",label2var)
}


## compose formulas from short labels
formulate <- function(.labels, .response)
{
  reformulate(labels2vars(.labels), response = .response)
}


## compare two models from the list with anova
## if comp_with is 0, use only one model
apply_anova <- function(.mdllist,.model_num,.comp_with){
  if (.comp_with == 0) { anova(.mdllist[[.model_num]]) }
  else {
    anova(.mdllist[[.model_num]],.mdllist[[.comp_with]],test="Chisq")
  }
}



## build regression models according to the formulas
## get summaries (AIC, BIC, LogLik, R2...)
## test nested models pairwise with anova LogLik test
## write to tibble
build_models <- function(.resp,.fflist,.data,.model_num,.comp_with){
  ## models
  mdllist <- sapply(.fflist,
                    function(x) lmer(formulate(x,.resp),data = .data, REML = FALSE)
  )
  
  ## summaries
  fullfml <- lapply(mdllist, function(x) x@call$formula)
  sumlist <- lapply(mdllist, summary)
  AIClist <- lapply(sumlist, function(x) x$AIC)
  R2m <- lapply(mdllist, function(x) r.squaredGLMM(x)[1])
  R2c <- lapply(mdllist, function(x) r.squaredGLMM(x)[2])
  
  ## apply LogLik test with anova and only report Chisq, Df and p-value
  anova_list <- lapply(.model_num, function(x) apply_anova(mdllist,x,.comp_with[x])) %>%
    tibble() %>% rename(anova = ".") %>%
    unnest_wider(anova) %>%
    unnest_wider(Chisq, names_sep = "_") %>%
    unnest_wider(Df, names_sep = "_") %>%
    unnest_wider(`Pr(>Chisq)`, names_sep = "_") %>%
    select(ends_with("_2")) %>%
    rename_with(~ str_remove(.x, "_2"))
  
  mdl.df <- tibble(.fflist,fullfml,AIClist,R2m,R2c,.model_num,.comp_with,anova_list,mdllist,sumlist) %>%
    unnest_wider(AIClist) %>%
    rename(formula = .fflist, model = mdllist, summary = sumlist, model_num = .model_num, compare_with = .comp_with)
}
