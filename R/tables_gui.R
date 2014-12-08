tables_gui <- function(..)
{
.guiEnv$tables.tab.frame <- gframe(label="Tables",container=.guiEnv$nb,horizontal=FALSE,index=3)
.guiEnv$tables.pop <- gbutton("Populate tables",container = .guiEnv$tables.tab.frame, handler = function(h,...) {

  .guiEnv$tables.nb <- gnotebook(container=.guiEnv$tables.tab.frame,label="Tables",expand=TRUE)
  .guiEnv$data.table <- gtable(items=.guiEnv$qw.data$DataTable,container=.guiEnv$tables.nb,label="Data table")
  .guiEnv$cb.table <- gtable(items=.guiEnv$qw.data$BalanceDataTable,container=.guiEnv$tables.nb,label="Chargebalance table")
  .guiEnv$blank.table <-gtable(items=subset(.guiEnv$qw.data$DataTable,MEDIUM_CD == "OAQ"),container=.guiEnv$tables.nb,label="Blank table")
  
})
glabel(container=.guiEnv$tables.tab.frame,"WARNING: Populating tables may take several minutes depending\non the number of samples and variables.\nNot recommended for very large datasets.")
}