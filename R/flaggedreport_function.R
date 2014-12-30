###Flagged report function
flagReport <- function(qw.data,flagged.samples)
{
###Make sample meta data frame
flagged.report <- data.frame(
  SITE_NO = qw.data$DataTable$SITE_NO[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples$RECORD_NO)],
  STATION_NM = qw.data$DataTable$STATION_NM[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples$RECORD_NO)],
  SAMPLE_START_DT = qw.data$DataTable$SAMPLE_START_DT[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples$RECORD_NO)],
  MEDIUM_CD = qw.data$DataTable$MEDIUM_CD[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples$RECORD_NO)],
  RECORD_NO = qw.data$DataTable$RECORD_NO[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples$RECORD_NO)],
  LAB_NO = qw.data$DataTable$LAB_NO[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples$RECORD_NO)],
  stringsAsFactors = FALSE
  )

###Add in plot flags
flagged.report <- merge(flagged.report, dcast(flagged.samples,RECORD_NO~FLAG_WHERE),by="RECORD_NO")

flagged.report$Notes <- ""
flagged.report$Rerun.submitted <- ""
return(flagged.report)
}

  
