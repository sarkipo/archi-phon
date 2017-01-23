for (sp in c("HDK","PSX","JSP")){
  for (v in c("a","e","i","o","u")){
    cat(sp, "\t", v, "\t", 
        nrow(data.all[data.all$speaker==sp & 
        data.all$vowel==v & 
        data.all$stress==TRUE & 
        data.all$phar==FALSE,]), "\n")
    cat(sp, "\t", v, "?\t", 
        nrow(data.all[data.all$speaker==sp & 
        data.all$vowel==v & 
        data.all$stress==TRUE & 
        data.all$phar==TRUE,]), "\n")
  }  
}
