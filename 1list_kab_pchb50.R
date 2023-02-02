setwd('D:/')
rm(list = ls())
load('ID_GRID.RData')

pch <- read.csv('pch_prob.2023.02.das.1_ver_2023.01.30.csv')
gabung <- merge(x = pch[c(1,2,3,5)], y = id_grid2, by = 'NOGRID')

pch_50 <- gabung[gabung$b50>70,]
fix <- pch_50[order(pch_50$ID_PROV,pch_50$ID_KABKOT),]
fix1 <- fix[c('ID_PROV','ID_KABKOT','BBMKG')]
fix2 <- unique(fix1)
# id_grid2[id_grid2$ID_PROV_INIT=='BABEL',]

prov <- unique(fix2$ID_PROV)
dtfr <- data.frame(matrix(ncol=2, nrow=0))
colnames(dtfr) <- c('BBMKG','kab')
for (i in 1:length(prov)) {
  # i <- 1
  pr <- prov[i]
  bbmkg <- fix2[fix2$ID_PROV==pr,'BBMKG'][1]
  ss <- fix2[fix2$ID_PROV==pr,]$ID_KABKOT
  ss1 <- paste0(pr,': ',paste(ss, collapse = ', '))
  dtfr <- rbind(dtfr,data.frame(BBMKG=bbmkg, kab=ss1))
}

lbal <- unique(dtfr$BBMKG)
dtfr1 <- data.frame(matrix(ncol=2, nrow=0))
colnames(dtfr1) <- c('BBMKG','kab')
for (j in 1:length(lbal)) {
  # j <- 1 #####
  lbbm <- lbal[j]
  kabs <- paste(dtfr[dtfr$BBMKG==lbbm,]$kab, collapse = '; ')
  dtfr1 <- rbind(dtfr1,data.frame(BBMKG=lbbm, kab=kabs))
}
write.csv(dtfr1, file = 'coba.csv', row.names = F)