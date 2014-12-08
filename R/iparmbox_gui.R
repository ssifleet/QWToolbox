iparmbox_gui <- function(...){
###Setup main group

  .guiEnv$iparmbox.mainGroup <- ggroup(label="Parameter boxplot",container=.guiEnv$interactive.frame)
  .guiEnv$iparmbox.vargroup <- gframe("Parameters",container=.guiEnv$iparmbox.mainGroup,expand=TRUE,horizontal=FALSE)
  
  visible(.guiEnv$iparmbox.mainGroup) <- FALSE
  
  ###Parameter browser

  .guiEnv$iparmbox.varsite.frame <- gframe(container=.guiEnv$iparmbox.vargroup,expand=TRUE,horizontal=FALSE)
  .guiEnv$iparmbox.site.selection <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = .guiEnv$iparmbox.varsite.frame, expand = TRUE)
  .guiEnv$iparmbox.plotparm <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=TRUE,container = .guiEnv$iparmbox.varsite.frame, expand = TRUE, fill = TRUE)
  .guiEnv$iparmbox.show.points <- gcheckbox(text = "Show sample points",checked=FALSE,use.togglebutton = TRUE,container =.guiEnv$iparmbox.vargroup)
  .guiEnv$iparmbox.log.scale <- gcheckbox(text = "Log10 scale",checked=FALSE,use.togglebutton = TRUE,container =.guiEnv$iparmbox.vargroup)
  
  gbutton(text = "Refresh plot",container =.guiEnv$iparmbox.vargroup,handler = function(h,...) {iparmbox(qw.data = .guiEnv$qw.data,
                                                                                                         iparmbox.site.selection = svalue(.guiEnv$iparmbox.site.selection),
                                                                                                         new.threshold = .guiEnv$new.threshold,
                                                                                                         iparmbox.plotparm = svalue(.guiEnv$iparmbox.plotparm),
                                                                                                         iparmbox.show.points = svalue(.guiEnv$iparmbox.show.points),
                                                                                                         iparmbox.log.scale = svalue(.guiEnv$iparmbox.log.scale))})
  
  ###Save plot
  
  gbutton(text="Export Plot", container = .guiEnv$iparmbox.vargroup,handler = function(h,...) {
    saveplot()
  })
  
  addHandlerClicked(.guiEnv$iparmbox.plotparm,handler = function(h,...) {iparmbox(qw.data = .guiEnv$qw.data,
                                                                                  iparmbox.site.selection = svalue(.guiEnv$iparmbox.site.selection),
                                                                                  new.threshold = .guiEnv$new.threshold,
                                                                                  iparmbox.plotparm = svalue(.guiEnv$iparmbox.plotparm),
                                                                                  iparmbox.show.points = svalue(.guiEnv$iparmbox.show.points),
                                                                                  iparmbox.log.scale = svalue(.guiEnv$iparmbox.log.scale))})
  addHandlerClicked(.guiEnv$iparmbox.site.selection,handler = function(h,...) {iparmbox(qw.data = .guiEnv$qw.data,
                                                                                        iparmbox.site.selection = svalue(.guiEnv$iparmbox.site.selection),
                                                                                        new.threshold = .guiEnv$new.threshold,
                                                                                        iparmbox.plotparm = svalue(.guiEnv$iparmbox.plotparm),
                                                                                        iparmbox.show.points = svalue(.guiEnv$iparmbox.show.points),
                                                                                        iparmbox.log.scale = svalue(.guiEnv$iparmbox.log.scale))})
  
  visible(.guiEnv$iparmbox.mainGroup) <- TRUE
  
  
}
