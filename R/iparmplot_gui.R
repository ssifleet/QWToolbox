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
