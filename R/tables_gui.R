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



glabel(container=.guiEnv$tables.tab.frame,"WARNING: Populating tables may take several minutes depending\non the number of samples and variables.\nNot recommended for very large datasets.")

###Open flag report window
gbutton("Open flagged sample report",container = .guiEnv$tables.tab.frame, handler = function(h,...) {
  
  
  popwin <- gwindow("Flagged sample report")
  popwin.frame <- gframe(container=popwin,horizontal=FALSE)
  
  ### Generate flagged report from flagged sample list
  ###frame to delete sample from flagged list
  .guiEnv$flag.sample.delete.frame <- ggroup(text = "Delete row from flagged sample list",container=popwin.frame, horizontal = TRUE,expand=FALSE)
  glabel("Row number",container = .guiEnv$flag.sample.delete.frame)
  .guiEnv$flag.sample.delete <- gedit(container = .guiEnv$flag.sample.delete.frame)
  #delete rows from flagged sample list
  gbutton("Delete",container=.guiEnv$flag.sample.delete.frame, handler = function(h,...)
  {
    #set row to delete
    rowdelete <- as.numeric(svalue(.guiEnv$flag.sample.delete))*-1
    #delete all flagged records matching records in row delete from flagged report
    .guiEnv$flagged.samples <- .guiEnv$flagged.samples[!(.guiEnv$flagged.samples$RECORD_NO %in% 
                                                           .guiEnv$flagged.report$RECORD_NO[as.numeric(svalue(.guiEnv$flag.sample.delete))]),]
    
    ###Refresh gdf table
    delete(popwin.frame,.guiEnv$flagged.report.edit)
    # Generate flagged report from flagged sample list
    .guiEnv$flagged.report <- .guiEnv$flagged.report[rowdelete,]
    #Put in gdf
    .guiEnv$flagged.report.edit <-gdf(items=.guiEnv$flagged.report,container=popwin.frame,expand=TRUE)
  })
  
  
  
  ###Button to save changes to gdf
  gbutton("Save changes",container=popwin.frame,handler=function(h,...){
    .guiEnv$saved.flagged.report <- as.data.frame(.guiEnv$flagged.report.edit[,])
    delete(popwin.frame,.guiEnv$flagged.report.edit)
    .guiEnv$flagged.report <- .guiEnv$saved.flagged.report 
    .guiEnv$flagged.report.edit <-gdf(items=.guiEnv$flagged.report,container=popwin.frame,expand=TRUE)
    
  })
  
  ###Button to export report
  gbutton("Export report",container=popwin.frame,handler=function(h,...){
  popwin <- gwindow("Save preferences")
  popwin.frame <- gframe(container=popwin,expand=TRUE,horizontal=FALSE)
  glabel("Filename",container = popwin.frame)
  export.file <- gfilebrowse(container = popwin.frame,text = "Select site ID file...",quote = FALSE)
  
  gbutton("Export report",container=popwin.frame,handler = function(...){
    write.csv(.guiEnv$flagged.report,file=svalue(export.file),row.names=FALSE)
    dispose(popwin)
  })
  })
  
  ###Button to refresh report for new flagged samples
  gbutton("Refresh (unsaved changes will be lost)",container=popwin.frame,handler=function(h,...){
    if(exists("saved.flagged.report",.guiEnv))
    {
      .guiEnv$flagged.report <- .guiEnv$saved.flagged.report
      ###Add in new flagged samples
      addFlags <- flagReport(qw.data = .guiEnv$qw.data,
                             flagged.samples = .guiEnv$flagged.samples)
      .guiEnv$flagged.report <- rbind(.guiEnv$flagged.report,addFlags[!(addFlags$RECORD_NO %in% .guiEnv$flagged.report$RECORD_NO),] )       
                         
    }else{.guiEnv$flagged.report <- flagReport(qw.data = .guiEnv$qw.data,
                                               flagged.samples = .guiEnv$flagged.samples)}
    
    ###delete old table and put in new one
    delete(popwin.frame,.guiEnv$flagged.report.edit)
    .guiEnv$flagged.report.edit <-gdf(items=.guiEnv$flagged.report,container=popwin.frame,expand=TRUE)
    
  })

###Checks for svaed report and generates a new one if not saved
  
  if(exists("saved.flagged.report",.guiEnv))
  {
    .guiEnv$flagged.report <- .guiEnv$saved.flagged.report
    ###Add in new flagged samples
    addFlags <- flagReport(qw.data = .guiEnv$qw.data,
                           flagged.samples = .guiEnv$flagged.samples)
    .guiEnv$flagged.report <- rbind(.guiEnv$flagged.report,addFlags[!(addFlags$RECORD_NO %in% .guiEnv$flagged.report$RECORD_NO),] )       
    
                       
  }else{.guiEnv$flagged.report <- flagReport(qw.data = .guiEnv$qw.data,
                                             flagged.samples = .guiEnv$flagged.samples)}
  
 
  ###Put in gdf
  .guiEnv$flagged.report.edit <-gdf(items=.guiEnv$flagged.report,container=popwin.frame,expand=TRUE)
  

  
})
}
