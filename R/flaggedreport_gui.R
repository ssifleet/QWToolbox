###Flagged report gui

flagged.report <- data.frame(
  SITE_NO = qw.data$DataTable$SITE_NO[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples)],
  STATION_NM = qw.data$DataTable$STATION_NM[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples)],
  SAMPLE_START_DT = qw.data$DataTable$SAMPLE_START_DT[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples)],
  MEDIUM_CD = qw.data$DataTable$MEDIUM_CD[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples)],
  RECORD_NO = qw.data$DataTable$RECORD_NO[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples)],
  LAB_NO = qw.data$DataTable$LAB_NO[which(qw.data$DataTable$RECORD_NO %in% .guiEnv$flagged.samples)]
)

  
