###############Just started adding .guiEnv$ to this section!


iseasonalbox_gui <- function(...){
  ###These exist checks are so that the data is refreshed when the user does a new data pull
  ###Since the tables are dependent on the data, they need to be refreshed
 
  .guiEnv$iseasonalbox.mainGroup <- ggroup(label="Seasonal boxplot",container=.guiEnv$interactive.frame)
  .guiEnv$iseasonalbox.vargroup <- gframe("Parameters",container=.guiEnv$iseasonalbox.mainGroup,expand=TRUE,horizontal=FALSE)


  ## Set up main group, make global so can be deleted 

  
  visible(.guiEnv$iseasonalbox.mainGroup) <- FALSE
  
  ###Parameter browser
  
  ###make global so can check if exists and delete for refresh of tables
  
  ###Local to function
  .guiEnv$iseasonalbox.varsite.frame <- gframe(container=.guiEnv$iseasonalbox.vargroup,expand=TRUE,horizontal=FALSE)
  .guiEnv$iseasonalbox.site.selection <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = .guiEnv$iseasonalbox.varsite.frame, expand = TRUE)
  .guiEnv$iseasonalbox.plotparm <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=FALSE,container = .guiEnv$iseasonalbox.varsite.frame, expand = TRUE, fill = TRUE)
  .guiEnv$iseasonalbox.show.points <- gcheckbox(text = "Show sample points",checked=FALSE,use.togglebutton = TRUE,container =.guiEnv$iseasonalbox.vargroup)
  .guiEnv$iseasonalbox.log.scale <- gcheckbox(text = "Log10 scale",checked=FALSE,use.togglebutton = TRUE,container =.guiEnv$iseasonalbox.vargroup)
  
  gbutton(text = "Refresh plot",container =.guiEnv$iseasonalbox.vargroup,handler = function(h,...) {iseasonalbox(qw.data = .guiEnv$qw.data,
                                                                                                                 new.threshold = .guiEnv$new.threshold,
                                                                                                                 iseasonalbox.site.selection = svalue(.guiEnv$iseasonalbox.site.selection),
                                                                                                                 iseasonalbox.plotparm = svalue(.guiEnv$iseasonalbox.plotparm),
                                                                                                                 iseasonalbox.show.points = svalue(.guiEnv$iseasonalbox.show.points),
                                                                                                                 iseasonalbox.log.scale = svalue(.guiEnv$iseasonalbox.log.scale))})
  
  ###Save plot
  
  gbutton(text="Export Plot", container = .guiEnv$iseasonalbox.vargroup,handler = function(h,...) {
    saveplot()
  })
  
  addHandlerClicked(.guiEnv$iseasonalbox.plotparm,handler = function(h,...) {iseasonalbox(qw.data = .guiEnv$qw.data,
                                                                                  new.threshold = .guiEnv$new.threshold,
                                                                                  iseasonalbox.site.selection = svalue(.guiEnv$iseasonalbox.site.selection),
                                                                                  iseasonalbox.plotparm = svalue(.guiEnv$iseasonalbox.plotparm),
                                                                                  iseasonalbox.show.points = svalue(.guiEnv$iseasonalbox.show.points),
                                                                                  iseasonalbox.log.scale = svalue(.guiEnv$iseasonalbox.log.scale))})
  addHandlerClicked(.guiEnv$iseasonalbox.site.selection,handler = function(h,...) {iseasonalbox(qw.data = .guiEnv$qw.data,
                                                                                                new.threshold = .guiEnv$new.threshold,
                                                                                                iseasonalbox.site.selection = svalue(.guiEnv$iseasonalbox.site.selection),
                                                                                                iseasonalbox.plotparm = svalue(.guiEnv$iseasonalbox.plotparm),
                                                                                                iseasonalbox.show.points = svalue(.guiEnv$iseasonalbox.show.points),
                                                                                                iseasonalbox.log.scale = svalue(.guiEnv$iseasonalbox.log.scale))})
  
  visible(.guiEnv$iseasonalbox.mainGroup) <- TRUE
  
  
}
