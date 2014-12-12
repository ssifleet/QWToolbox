tables_gui <- function(..)
{
.guiEnv$tables.tab.frame <- gframe(label="Tables",container=.guiEnv$nb,horizontal=FALSE,index=3)
gbutton("Populate tables",container = .guiEnv$tables.tab.frame, handler = function(h,...) {
  
  popwin <- gwindow()
  glabel("POPULATING TABLES, MAY TAKE SEVERAL MINUTES DEPENDING ON DATA SIZE",container = popwin)
  
  .guiEnv$tables.nb <- gnotebook(container=.guiEnv$tables.tab.frame,label="Tables",expand=TRUE)
  .guiEnv$data.table <- gtable(items=.guiEnv$qw.data$DataTable,container=.guiEnv$tables.nb,label="Data table")
  .guiEnv$cb.table <- gtable(items=.guiEnv$qw.data$BalanceDataTable,container=.guiEnv$tables.nb,label="Chargebalance table")
  .guiEnv$blank.table <-gtable(items=subset(.guiEnv$qw.data$DataTable,MEDIUM_CD == "OAQ"),container=.guiEnv$tables.nb,label="Blank table")

  dispose(popwin)
  })

###Popup to tell user to wait for data import


glabel(container=.guiEnv$tables.tab.frame,"WARNING: Populating tables may take several minutes depending\non the number of samples and variables.\nNot recommended for very large datasets.")
gbutton("Generate flagged sample report",container = .guiEnv$tables.tab.frame, handler = function(h,...) {
  popwin <- gwindow("Flagged sample report")
  .guiEnv$flagged.report <- flagReport(qw.data = .guiEnv$qw.data,
                               flagged.samples = .guiEnv$flagged.samples)
  .guiEnv$flagged.report <-gdf(items=.guiEnv$flagged.report,container=popwin)
  
  
})
}