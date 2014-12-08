itsplot_gui <- function (...){
  ###These exist checks are so that the data is refreshed when the user does a new data pull
  ###Since the tables are dependent on the data, they need to be refreshed
  
  ## Set up main group
  .guiEnv$its.mainGroup <- ggroup(label="Timeseries",container=.guiEnv$interactive.frame)
  .guiEnv$its.vargroup <<- gframe(container=.guiEnv$its.mainGroup,expand=TRUE,horizontal=FALSE)


visible(.guiEnv$its.mainGroup) <- FALSE

  
  ###Parameter browser
  
  ###Make globala so can be checked for exist and deleteded to refresh tables
  
  

.guiEnv$its.varsite.frame <- gframe(container=.guiEnv$its.vargroup,expand=TRUE,horizontal=FALSE)
.guiEnv$its.site.selection <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = .guiEnv$its.varsite.frame, expand = TRUE)
.guiEnv$its.plotparm <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=FALSE,container = .guiEnv$its.varsite.frame, expand = TRUE, fill = TRUE)
  glabel("Begin Date",container=.guiEnv$its.vargroup)
.guiEnv$its.begin.date.slider <- gslider(from = as.Date(min(.guiEnv$qw.data$PlotTable$SAMPLE_START_DT)),to=as.Date(max(.guiEnv$qw.data$PlotTable$SAMPLE_START_DT)),by=1,container=.guiEnv$its.vargroup)
  glabel("End Date",container=.guiEnv$its.vargroup)
.guiEnv$its.end.date.slider <- gslider(from = as.Date(min(.guiEnv$qw.data$PlotTable$SAMPLE_START_DT)),to=as.Date(max(.guiEnv$qw.data$PlotTable$SAMPLE_START_DT)),value=as.Date(max(.guiEnv$qw.data$PlotTable$SAMPLE_START_DT)),by=1,container=.guiEnv$its.vargroup)
  

  ###Option to add smooth
.guiEnv$its.show.smooth <- gcheckbox(text = "Add loess smooth",checked=FALSE,use.togglebutton = TRUE,container =.guiEnv$its.vargroup)
  ###Option to add hydrograph
.guiEnv$its.show.q <- gcheckbox(text = "Show instantaneous hydrograph",checked=FALSE,use.togglebutton = TRUE,container =.guiEnv$its.vargroup)
  
  ###Refresh plot
  gbutton(text = "Refresh plot",container =.guiEnv$its.vargroup,handler = function(h,...) {
    itsplot(qw.data = .guiEnv$qw.data,
            new.threshold = .guiEnv$new.threshold,
            its.site.selection = svalue(.guiEnv$its.site.selection),
            its.plotparm = svalue(.guiEnv$its.plotparm),
            its.begin.date.slider = svalue(.guiEnv$its.begin.date.slider),
            its.end.date.slider = svalue(.guiEnv$its.end.date.slider),
            its.show.q = svalue(.guiEnv$its.show.q),
            its.show.smooth = svalue(.guiEnv$its.show.smooth))
  })
    
    
  ###Save plot
  
  gbutton(text="Export Plot", container = .guiEnv$its.vargroup,handler = function(h,...) {
    saveplot()
  })
  
addHandlerClicked(.guiEnv$its.plotparm,handler = function(h,...) {itsplot(qw.data = .guiEnv$qw.data,
                                                                          new.threshold = .guiEnv$new.threshold,
                                                                          its.site.selection = svalue(.guiEnv$its.site.selection),
                                                                          its.plotparm = svalue(.guiEnv$its.plotparm),
                                                                          its.begin.date.slider = svalue(.guiEnv$its.begin.date.slider),
                                                                          its.end.date.slider = svalue(.guiEnv$its.end.date.slider),
                                                                          its.show.q = svalue(.guiEnv$its.show.q),
                                                                          its.show.smooth = svalue(.guiEnv$its.show.smooth))})
addHandlerClicked(.guiEnv$its.site.selection,handler = function(h,...) {itsplot(qw.data = .guiEnv$qw.data,
                                                                                new.threshold = .guiEnv$new.threshold,
                                                                                its.site.selection = svalue(.guiEnv$its.site.selection),
                                                                                its.plotparm = svalue(.guiEnv$its.plotparm),
                                                                                its.begin.date.slider = svalue(.guiEnv$its.begin.date.slider),
                                                                                its.end.date.slider = svalue(.guiEnv$its.end.date.slider),
                                                                                its.show.q = svalue(.guiEnv$its.show.q),
                                                                                its.show.smooth = svalue(.guiEnv$its.show.smooth))})

  visible(.guiEnv$its.mainGroup) <- TRUE

}


