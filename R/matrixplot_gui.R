matrixplot_gui <- function(...){

    .guiEnv$matrix.mainGroup <- ggroup(label="Matrix plot",container=.guiEnv$interactive.frame)
    .guiEnv$matrix.vargroup <- gframe("Parameters",container=.guiEnv$matrix.mainGroup,expand=TRUE,horizontal=FALSE)





  
  visible(.guiEnv$matrix.mainGroup) <- FALSE
  

  ###Parameter browser
  .guiEnv$matrix.site.selection <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = .guiEnv$matrix.vargroup, expand = TRUE)
  .guiEnv$matrix.plotparm <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=TRUE,container = .guiEnv$matrix.vargroup, expand = TRUE, fill = TRUE)

  ###Plotting handler for table
  gbutton("Make plot",container=.guiEnv$matrix.vargroup,handler = function(h,...) {

    matrixplot(qw.data = .guiEnv$qw.data,
               matrix.site.selection = svalue(.guiEnv$matrix.site.selection),
               matrix.plotparm = svalue(.guiEnv$matrix.plotparm))
    
  })
  
  
  
  visible(.guiEnv$matrix.mainGroup) <- TRUE
  

}










