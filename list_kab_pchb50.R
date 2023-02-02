setwd('D:/')
rm(list = ls())
#library(officer)
#library(dplyr)
pch <- read.csv('pch_prob.2023.02.das.1_ver_2023.01.30.csv')
id_grid <- read.csv('ID_GRID_CHPROVKAB_INDO_2022.csv')
id_grid1 <- id_grid[c(1:4,7:10)]
colnames(id_grid1)[2] <- 'NOGRID'

gabung <- merge(x = pch[c(1,2,3,5)], y = id_grid1, by = 'NOGRID')
pch_50 <- gabung[gabung$b50>70,]
fix <- pch_50[order(pch_50$ID_PROV,pch_50$ID_KABKOT),]
# write.csv(fix, file = 'pchb50_a50persen.csv')

fix1 <- fix[c(10,11)]
fix2 <- unique(fix1)
# aa <- unique(fix1$ID_KABKOT)
# length(aa)
# write.csv(t(fix2), file = 'uniq1.csv', sep = ',')

prov <- unique(fix2$ID_PROV_INIT)
dtfr <- data.frame(matrix(ncol=2, nrow=0))
colnames(dtfr) <- c('prov','kab')
for (i in 1:length(prov)) {
  # i <- 1
  pr <- prov[i]
  ss <- fix2[fix2$ID_PROV_INIT==pr,]$ID_KABKOT
  ss1 <- paste(ss, collapse = ', ')
  dtfr <- rbind(dtfr,data.frame(prov=pr, kab=ss1))
}
write.csv(dtfr, file = 'coba.csv', row.names = F)
# writeLines(paste(c(unique(fix2$ID_KABKOT)), sep = ', '), con = 'aaa.txt', sep = ", ", useBytes = FALSE)
# writeLines(paste(c(unique(fix2$ID_KABKOT)), sep = ', '), con = stdout(), sep = ", ", useBytes = FALSE)
# sample_doc <- read_docx()
# sample_doc <- sample_doc %>% body_add_par("This is the first paragraph") 
# sample_doc <- sample_doc %>% body_add_par("This is the second paragraph")
# sample_doc <- sample_doc %>% body_add_par("This is the third paragraph")      
# print(sample_doc, target = "sample_file.docx")
