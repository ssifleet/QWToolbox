iparmplot_gui <- function(...){

    .guiEnv$iparm.mainGroup <- ggroup(label="Parameter-parameter",container=.guiEnv$interactive.frame)
    .guiEnv$iparm.vargroup <- gframe(container=.guiEnv$iparm.mainGroup,expand=TRUE,horizontal=FALSE)


  ###Hide window until fully built
  visible(.guiEnv$iparm.mainGroup) <- FALSE
  
  ###Parameter selection frame
  .guiEnv$iparm.varsite.frame <- gframe(container=.guiEnv$iparm.vargroup,expand=TRUE,horizontal=FALSE)
  .guiEnv$iparm.site.selection <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = .guiEnv$iparm.varsite.frame, expand = TRUE)
  .guiEnv$iparm.xparm <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=FALSE,container = .guiEnv$iparm.varsite.frame, expand = TRUE, fill = TRUE)
  .guiEnv$iparm.yparm <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=FALSE,container = .guiEnv$iparm.varsite.frame, expand = TRUE, fill = TRUE)
  .guiEnv$iparm.show.lm <- gcheckbox(text = "Add linear fit",checked=FALSE,use.togglebutton = TRUE,container =.guiEnv$iparm.vargroup)
  
  gbutton(text = "Refresh plot",container =.guiEnv$iparm.vargroup,handler = function(h,...) {iparmplot(qw.data = .guiEnv$qw.data,
                                                                                               new.threshold = .guiEnv$new.threshold,
                                                                                               iparm.site.selection= svalue(.guiEnv$iparm.site.selection),
                                                                                               iparm.xparm = svalue(.guiEnv$iparm.xparm),
                                                                                               iparm.yparm = svalue(.guiEnv$iparm.yparm),
                                                                                               iparm.show.lm = svalue(.guiEnv$iparm.show.lm))}) 
  
  
  ###Flag sample
  gbutton(text="Flag sample",container = .guiEnv$iparm.vargroup,handler = function(h,...) {
    ###Refresh plot so that viewport exists
    iparmplot(qw.data = .guiEnv$qw.data,
              new.threshold = .guiEnv$new.threshold,
              iparm.site.selection= svalue(.guiEnv$iparm.site.selection),
              iparm.xparm = svalue(.guiEnv$iparm.xparm),
              iparm.yparm = svalue(.guiEnv$iparm.yparm),
              iparm.show.lm = svalue(.guiEnv$iparm.show.lm))
    ###get a dataframe identical to the one used by the plot to pass to flagger function
    ###Subset data to parms and join by record number
    ###This is very ugly but I don't know a way to pair up the x-y data in a melted dataframe
    ###Subsetting by parm code does not work because you need the parmcodes matched up for the same record
    
    xpp.plot.data <- subset(.guiEnv$qw.data$PlotTable,SITE_NO %in% svalue(.guiEnv$iparm.site.selection) & PARM_CD==svalue(.guiEnv$iparm.xparm))
    ypp.plot.data <- subset(.guiEnv$qw.data$PlotTable,SITE_NO %in% svalue(.guiEnv$iparm.site.selection) & PARM_CD==svalue(.guiEnv$iparm.yparm))
    
    ###Assigned to global environment to make it work with ggplot2, I don't like doing this since it is not a persistant variable
    ###but this is hte fastest fix for now
    pp.plot.data <- join(xpp.plot.data[c("RECORD_NO","MEDIUM_CD","RESULT_VA","RESULT_MD")], ypp.plot.data[c("RECORD_NO","MEDIUM_CD","RESULT_VA","RESULT_MD")],by="RECORD_NO")
    names(pp.plot.data) <- c("RECORD_NO","MEDIUM_CD","RESULT_VA_X","RESULT_MD_X","MEDIUM_CD","RESULT_VA_Y","RESULT_MD_Y")
    remove(xpp.plot.data)
    remove(ypp.plot.data)
    
    data <- pp.plot.data
    x <- data$RESULT_VA_X
    y <- data$RESULT_VA_Y
    
    ###run flagger function. This returns the row index of the sample which is used to grab the record number
    row.index <- flagger(data=data,x=x,y=y)
    .guiEnv$flagged.samples <-  rbind(.guiEnv$flagged.samples,data.frame(RECORD_NO = data$RECORD_NO[row.index],FLAG_WHERE="parm-parm plot"))
    
  }) 
  
###Save plot

  gbutton(text="Export Plot", container = .guiEnv$iparm.vargroup,handler = function(h,...) {
  saveplot()
})

addHandlerClicked(.guiEnv$iparm.xparm,handler = function(h,...) {iparmplot(qw.data = .guiEnv$qw.data,
                                                                   new.threshold = .guiEnv$new.threshold,
                                                                   iparm.site.selection= svalue(.guiEnv$iparm.site.selection),
                                                                   iparm.xparm = svalue(.guiEnv$iparm.xparm),
                                                                   iparm.yparm = svalue(.guiEnv$iparm.yparm),
                                                                   iparm.show.lm = svalue(.guiEnv$iparm.show.lm))})  
addHandlerClicked(.guiEnv$iparm.yparm,handler = function(h,...) {iparmplot(qw.data = .guiEnv$qw.data,
                                                                   new.threshold = .guiEnv$new.threshold,
                                                                   iparm.site.selection= svalue(.guiEnv$iparm.site.selection),
                                                                   iparm.xparm = svalue(.guiEnv$iparm.xparm),
                                                                   iparm.yparm = svalue(.guiEnv$iparm.yparm),
                                                                   iparm.show.lm = svalue(.guiEnv$iparm.show.lm))})                  
addHandlerClicked(.guiEnv$iparm.site.selection,handler = function(h,...) {iparmplot(qw.data = .guiEnv$qw.data,
                                                                            new.threshold = .guiEnv$new.threshold,
                                                                            iparm.site.selection= svalue(.guiEnv$iparm.site.selection),
                                                                            iparm.xparm = svalue(.guiEnv$iparm.xparm),
                                                                            iparm.yparm = svalue(.guiEnv$iparm.yparm),
                                                                            iparm.show.lm = svalue(.guiEnv$iparm.show.lm))})
  
  visible(.guiEnv$iparm.mainGroup) <- TRUE

}
