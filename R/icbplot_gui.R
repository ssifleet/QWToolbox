icbplot_gui <- function(...){

      .guiEnv$icb.mainGroup <- ggroup(label="Chargebalance timeseries",container=.guiEnv$interactive.frame)
      .guiEnv$icb.vargroup <- gframe(container=.guiEnv$icb.mainGroup,expand=TRUE,horizontal=FALSE)
  



  visible(.guiEnv$icb.mainGroup) <- FALSE
  
  
  ###Parameter browser
  .guiEnv$icb.varsite.frame <- gframe(container=.guiEnv$icb.vargroup,expand=TRUE,horizontal=FALSE)
  .guiEnv$icb.site.selection <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = .guiEnv$icb.varsite.frame, expand = TRUE)
  
  glabel("Begin Date",container=.guiEnv$icb.vargroup)
  .guiEnv$icb.begin.date.slider <- gslider(from = as.Date(min(.guiEnv$qw.data$PlotTable$SAMPLE_START_DT)),to=as.Date(max(.guiEnv$qw.data$PlotTable$SAMPLE_START_DT)),by=1,container=.guiEnv$icb.vargroup)
  glabel("End Date",container=.guiEnv$icb.vargroup)
  .guiEnv$icb.end.date.slider <- gslider(from = as.Date(min(.guiEnv$qw.data$PlotTable$SAMPLE_START_DT)),to=as.Date(max(.guiEnv$qw.data$PlotTable$SAMPLE_START_DT)),value=as.Date(max(.guiEnv$qw.data$PlotTable$SAMPLE_START_DT)),by=1,container=.guiEnv$icb.vargroup)
  
  
  ###Option to add smooth
  .guiEnv$icb.show.smooth <- gcheckbox(text = "Add loess smooth",checked=FALSE,use.togglebutton = TRUE,container =.guiEnv$icb.vargroup)
  
  ###refresh plot
  gbutton(text = "Refresh plot",container =.guiEnv$icb.vargroup,handler = function(h,...) {icbplot(qw.data = .guiEnv$qw.data,
                                                                                          new.threshold = .guiEnv$new.threshold,
                                                                                           icb.site.selection = svalue(.guiEnv$icb.site.selection),
                                                                                           icb.begin.date.slider = svalue(.guiEnv$icb.begin.date.slider),
                                                                                           icb.end.date.slider = svalue(.guiEnv$icb.end.date.slider),
                                                                                           icb.show.smooth = svalue(.guiEnv$icb.show.smooth))})
          

  ###Flag sample 
  gbutton(text="Flag sample",container = .guiEnv$icb.vargroup,handler = function(h,...) {
    ###Refresh plot so that viewport exists
    icbplot(qw.data = .guiEnv$qw.data,
            new.threshold = .guiEnv$new.threshold,
            icb.site.selection = svalue(.guiEnv$icb.site.selection),
            icb.begin.date.slider = svalue(.guiEnv$icb.begin.date.slider),
            icb.end.date.slider = svalue(.guiEnv$icb.end.date.slider),
            icb.show.smooth = svalue(.guiEnv$icb.show.smooth))
    ###get a dataframe identical to the one used by the plot to pass to flagger function
    data <- subset(.guiEnv$qw.data$PlotTable,SITE_NO %in% 
                     svalue(.guiEnv$icb.site.selection) & 
                     !duplicated(RECORD_NO) == TRUE
                   )     
    x <- as.numeric(data$SAMPLE_START_DT)
    y <- data$perc.diff
    
    ###run flagger function. This returns the row index of the sample which is used to grab the record number
    row.index <- flagger(data=data,x=x,y=y)
    .guiEnv$flagged.samples <-  rbind(.guiEnv$flagged.samples,data.frame(RECORD_NO = data$RECORD_NO[row.index],FLAG_WHERE="Charge-timeseries"))
    
  }) 
  
  ##Save plot
  
  gbutton(text="Export Plot", container = .guiEnv$icb.vargroup,handler = function(h,...) {
saveplot()
  })
  
addHandlerClicked(.guiEnv$icb.site.selection,handler = function(h,...) {icbplot(qw.data = .guiEnv$qw.data,
                                                                new.threshold = .guiEnv$new.threshold,
                                                                icb.site.selection = svalue(.guiEnv$icb.site.selection),
                                                                        icb.begin.date.slider = svalue(.guiEnv$icb.begin.date.slider),
                                                                        icb.end.date.slider = svalue(.guiEnv$icb.end.date.slider),
                                                                        icb.show.smooth = svalue(.guiEnv$icb.show.smooth))})


  visible(.guiEnv$icb.mainGroup) <- TRUE
  

}