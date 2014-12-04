iseasonalbox_gui <- function(...){
  ###These exist checks are so that the data is refreshed when the user does a new data pull
  ###Since the tables are dependent on the data, they need to be refreshed
  
  if(exists("iseasonalbox.mainGroup"))
  {
    if(!isExtant(iseasonalbox.mainGroup))
      {
      iseasonalbox.mainGroup <<- ggroup(label="Seasonal boxplot",container=interactive.frame)
      }
  } else(iseasonalbox.mainGroup <<- ggroup(label="Seasonal boxplot",container=interactive.frame))

  
  if(exists("iseasonalbox.vargroup"))
    {
      if(isExtant(iseasonalbox.vargroup))
        {
        delete(iseasonalbox.mainGroup,iseasonalbox.vargroup)
        }
        iseasonalbox.vargroup <<- gframe("Parameters",container=iseasonalbox.mainGroup,expand=TRUE,horizontal=FALSE)
    }else(iseasonalbox.vargroup <<- gframe("Parameters",container=iseasonalbox.mainGroup,expand=TRUE,horizontal=FALSE))


  ## Set up main group, make global so can be deleted 

  
  visible(iseasonalbox.mainGroup) <- FALSE
  
  ###Parameter browser
  
  ###make global so can check if exists and delete for refresh of tables
  
  ###Local to function
  iseasonalbox.varsite.frame <- gframe(container=iseasonalbox.vargroup,expand=TRUE,horizontal=FALSE)
  iseasonalbox.site.selection <- gtable(items = na.omit(unique(qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = iseasonalbox.varsite.frame, expand = TRUE)
  iseasonalbox.plotparm <- gtable(items = na.omit(unique(qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=FALSE,container = iseasonalbox.varsite.frame, expand = TRUE, fill = TRUE)
  iseasonalbox.show.points <- gcheckbox(text = "Show sample points",checked=FALSE,use.togglebutton = TRUE,container =iseasonalbox.vargroup)
  iseasonalbox.log.scale <- gcheckbox(text = "Log10 scale",checked=FALSE,use.togglebutton = TRUE,container =iseasonalbox.vargroup)
  
  gbutton(text = "Refresh plot",container =iseasonalbox.vargroup,handler = function(h,...) {iseasonalbox(iseasonalbox.site.selection = svalue(iseasonalbox.site.selection),
                                                                                                         iseasonalbox.plotparm = svalue(iseasonalbox.plotparm),
                                                                                                         iseasonalbox.show.points = svalue(iseasonalbox.show.points),
                                                                                                         iseasonalbox.log.scale = svalue(iseasonalbox.log.scale))})
  
  ###Save plot
  
  gbutton(text="Export Plot", container = iseasonalbox.vargroup,handler = function(h,...) {
    saveplot()
  })
  
  addHandlerClicked(iseasonalbox.plotparm,handler = function(h,...) {iseasonalbox(iseasonalbox.site.selection = svalue(iseasonalbox.site.selection),
                                                                                  iseasonalbox.plotparm = svalue(iseasonalbox.plotparm),
                                                                                  iseasonalbox.show.points = svalue(iseasonalbox.show.points),
                                                                                  iseasonalbox.log.scale = svalue(iseasonalbox.log.scale))})
  addHandlerClicked(iseasonalbox.site.selection,handler = function(h,...) {iseasonalbox(iseasonalbox.site.selection = svalue(iseasonalbox.site.selection),
                                                                                        iseasonalbox.plotparm = svalue(iseasonalbox.plotparm),
                                                                                        iseasonalbox.show.points = svalue(iseasonalbox.show.points),
                                                                                        iseasonalbox.log.scale = svalue(iseasonalbox.log.scale))})
  
  visible(iseasonalbox.mainGroup) <- TRUE
  
  
}
