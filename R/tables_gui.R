tables.tab.frame <- gframe(label="Tables",container=nb,horizontal=FALSE)
tables.pop <- gbutton("Populate tables",container = tables.tab.frame, handler = function(h,...) {
  if(exists("tables.nb"))
  {
    if(isExtant(tables.nb))
    {
      delete(tables.tab.frame,tables.nb)
    }
  }
  tables.nb <<- gnotebook(container=tables.tab.frame,label="Tables",expand=TRUE)
  data.table <- gtable(items=qw.data$DataTable,container=tables.nb,label="Data table")
  cb.table <- gtable(items=qw.data$BalanceDataTable,container=tables.nb,label="Chargebalance table")
  blank.table <-gtable(items=subset(qw.data$DataTable,MEDIUM_CD == "OAQ"),container=tables.nb,label="Blank table")
  
})
glabel(container=tables.tab.frame,"WARNING: Populating tables may take several minutes depending\non the number of samples and variables.\nNot recommended for very large datasets.")