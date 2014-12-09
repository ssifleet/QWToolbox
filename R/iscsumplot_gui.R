iscsumplot_gui <- function(...){

      .guiEnv$iscsum.mainGroup <- ggroup(label="Ions vs conductance",container=.guiEnv$interactive.frame)
      .guiEnv$iscsum.vargroup <- gframe(container=.guiEnv$iscsum.mainGroup,expand=TRUE,horizontal=FALSE)
  

  visible(.guiEnv$iscsum.mainGroup) <- FALSE
  
  
  
  ###Parameter browser
  
  .guiEnv$iscsum.varsite.frame <- gframe(container=.guiEnv$iscsum.vargroup,expand=TRUE,horizontal=FALSE)
  .guiEnv$iscsum.site.selection <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = .guiEnv$iscsum.varsite.frame, expand = TRUE)
  .guiEnv$iscsum.plotparm <- gtable(items = c("sum cations","sum anions"),multiple=FALSE,container = .guiEnv$iscsum.varsite.frame, expand = TRUE, fill = TRUE)
  
  ###Refresh plot
  gbutton(text = "Refresh plot",container =.guiEnv$iscsum.vargroup,handler = function(h,...) {
    iscsumplot(qw.data = .guiEnv$qw.data,
               new.threshold = .guiEnv$new.threshold,
               iscsum.site.selection = svalue(.guiEnv$iscsum.site.selection),
               iscsum.plotparm = svalue(.guiEnv$iscsum.plotparm))
  })
  ###Save plot
  
  gbutton(text="Export Plot", container = .guiEnv$iscsum.vargroup,handler = function(h,...) {
  saveplot()
    }) 
    
    addHandlerClicked(.guiEnv$iscsum.site.selection,handler = function(h,...) {iscsumplot(qw.data = .guiEnv$qw.data,
                                                                               new.threshold = .guiEnv$new.threshold,
                                                                                iscsum.site.selection = svalue(.guiEnv$iscsum.site.selection),
                                                                                  iscsum.plotparm = svalue(.guiEnv$iscsum.plotparm))})
    addHandlerClicked(.guiEnv$iscsum.plotparm,handler = function(h,...) {iscsumplot(qw.data = .guiEnv$qw.data,
                                                                                    new.threshold = .guiEnv$new.threshold,
                                                                                    iscsum.site.selection = svalue(.guiEnv$iscsum.site.selection),
                                                                                    iscsum.plotparm = svalue(.guiEnv$iscsum.plotparm))})  

  
  
  

  
  visible(.guiEnv$iscsum.mainGroup) <- TRUE
  
}
