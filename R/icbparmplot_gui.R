icbparmplot_gui <- function(...){

    .guiEnv$icbparm.mainGroup <- ggroup(label="Chargebalance-parameter",container=.guiEnv$interactive.frame)
    .guiEnv$icbparm.vargroup <- gframe(container=.guiEnv$icbparm.mainGroup,expand=TRUE,horizontal=FALSE)
  
  


  visible(.guiEnv$icbparm.mainGroup) <- FALSE

  
  ###Parameter browser

  .guiEnv$icbparm.varsite.frame <- gframe(container=.guiEnv$icbparm.vargroup,expand=TRUE,horizontal=FALSE)
  .guiEnv$icbparm.site.selection <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = .guiEnv$icbparm.varsite.frame, expand = TRUE)
  .guiEnv$icbparm.plotparm <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=FALSE,container = .guiEnv$icbparm.varsite.frame, expand = TRUE, fill = TRUE)

###Refresh plot
gbutton(text = "Refresh plot",container =.guiEnv$icbparm.vargroup,handler = function(h,...) {icbparmplot(qw.data = .guiEnv$qw.data,
                                                                                                          new.threshold = .guiEnv$new.threshold,
                                                                                                       icbparm.site.selection = svalue(.guiEnv$icbparm.site.selection),
                                                                                                          icbparm.plotparm = svalue(.guiEnv$icbparm.plotparm))})
 
###Flag sample 
gbutton(text="Flag sample",container = .guiEnv$icbparm.vargroup,handler = function(h,...) {
  ###Refresh plot so that viewport exists
  icbparmplot(qw.data = .guiEnv$qw.data,
              new.threshold = .guiEnv$new.threshold,
              icbparm.site.selection = svalue(.guiEnv$icbparm.site.selection),
              icbparm.plotparm = svalue(.guiEnv$icbparm.plotparm))
  ###get a dataframe identical to the one used by the plot to pass to flagger function
  data <- subset(.guiEnv$qw.data$PlotTable,SITE_NO %in% svalue((.guiEnv$icbparm.site.selection)) & PARM_CD==svalue((.guiEnv$icbparm.plotparm)))
  x <- data$RESULT_VA
  y <- data$perc.diff
  
  ###run flagger function. This returns the row index of the sample which is used to grab the record number
  row.index <- flagger(data=data,x=x,y=y)
  .guiEnv$flagged.samples <-  rbind(.guiEnv$flagged.samples,data.frame(RECORD_NO = data$RECORD_NO[row.index],FLAG_WHERE="Charge-parm"))
  
}) 

###Save plot
  
  gbutton(text="Export Plot", container = .guiEnv$icbparm.vargroup,handler = function(h,...) {
svaeplot()
  })
  
  
addHandlerClicked(.guiEnv$icbparm.site.selection,handler = function(h,...) {icbparmplot(qw.data = .guiEnv$qw.data,
                                                                                        new.threshold = .guiEnv$new.threshold,
                                                                                        icbparm.site.selection = svalue(.guiEnv$icbparm.site.selection),
                                                                                        icbparm.plotparm = svalue(.guiEnv$icbparm.plotparm))})
addHandlerClicked(.guiEnv$icbparm.plotparm,handler = function(h,...) {icbparmplot(qw.data = .guiEnv$qw.data,
                                                                                  new.threshold = .guiEnv$new.threshold,
                                                                                  icbparm.site.selection = svalue(.guiEnv$icbparm.site.selection),
                                                                                  icbparm.plotparm = svalue(.guiEnv$icbparm.plotparm))})   
  
  
  
  
  visible(.guiEnv$icbparm.mainGroup) <- TRUE
  
}
