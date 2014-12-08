icbsumplot_gui <- function(...){

      .guiEnv$icbsum.mainGroup <- ggroup(label="Chargebalance vs sum(Cat/An)",container=.guiEnv$interactive.frame)
      .guiEnv$icbsum.vargroup <- gframe(container=.guiEnv$icbsum.mainGroup,expand=TRUE,horizontal=FALSE)
  

  visible(.guiEnv$icbsum.mainGroup) <- FALSE
  
  
  
  ###Parameter browser
  
  .guiEnv$icbsum.varsite.frame <- gframe(container=.guiEnv$icbsum.vargroup,expand=TRUE,horizontal=FALSE)
  .guiEnv$icbsum.site.selection <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = .guiEnv$icbsum.varsite.frame, expand = TRUE)
  .guiEnv$icbsum.plotparm <- gtable(items = c("sum cations","sum anions"),multiple=FALSE,container = .guiEnv$icbsum.varsite.frame, expand = TRUE, fill = TRUE)
  
  ###Refresh plot
  gbutton(text = "Refresh plot",container =.guiEnv$icbsum.vargroup,handler = function(h,...) {
    icbsumplot(qw.data = .guiEnv$qw.data,
               new.threshold = .guiEnv$new.threshold,
               icbsum.site.selection = svalue(.guiEnv$icbsum.site.selection),
               icbsum.plotparm = svalue(.guiEnv$icbsum.plotparm))
  })
  ###Save plot
  
  gbutton(text="Export Plot", container = .guiEnv$icbsum.vargroup,handler = function(h,...) {
  saveplot()
    }) 
    
    addHandlerClicked(.guiEnv$icbsum.site.selection,handler = function(h,...) {icbsumplot(qw.data = .guiEnv$qw.data,
                                                                               new.threshold = .guiEnv$new.threshold,
                                                                                icbsum.site.selection = svalue(.guiEnv$icbsum.site.selection),
                                                                                  icbsum.plotparm = svalue(.guiEnv$icbsum.plotparm))})
    addHandlerClicked(.guiEnv$icbsum.plotparm,handler = function(h,...) {icbsumplot(qw.data = .guiEnv$qw.data,
                                                                                    new.threshold = .guiEnv$new.threshold,
                                                                                    icbsum.site.selection = svalue(.guiEnv$icbsum.site.selection),
                                                                                    icbsum.plotparm = svalue(.guiEnv$icbsum.plotparm))})  

  
  
  

  
  visible(.guiEnv$icbsum.mainGroup) <- TRUE
  
}
