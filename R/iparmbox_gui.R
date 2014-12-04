iparmbox_gui <- function(...){
  ###These exist checks are so that the data is refreshed when the user does a new data pull
  ###Since the tables are dependent on the data, they need to be refreshed
  
  if(exists("iparmbox.mainGroup"))
  {
    if(!isExtant(iparmbox.mainGroup))
    {
      iparmbox.mainGroup <<- ggroup(label="Parameter boxplot",container=interactive.frame)
    }
  } else(iparmbox.mainGroup <<- ggroup(label="Parameter boxplot",container=interactive.frame))
  
  
  if(exists("iparmbox.vargroup"))
  {
    if(isExtant(iparmbox.vargroup))
    {
      delete(iparmbox.mainGroup,iparmbox.vargroup)
    }
    iparmbox.vargroup <<- gframe("Parameters",container=iparmbox.mainGroup,expand=TRUE,horizontal=FALSE)
  }else(iparmbox.vargroup <<- gframe("Parameters",container=iparmbox.mainGroup,expand=TRUE,horizontal=FALSE))
  
  
  ## Set up main group, make global so can be deleted 
  
  
  visible(iparmbox.mainGroup) <- FALSE
  
  ###Parameter browser
  
  ###make global so can check if exists and delete for refresh of tables
  
  ###Local to function
  iparmbox.varsite.frame <- gframe(container=iparmbox.vargroup,expand=TRUE,horizontal=FALSE)
  iparmbox.site.selection <- gtable(items = na.omit(unique(qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = iparmbox.varsite.frame, expand = TRUE)
  iparmbox.plotparm <- gtable(items = na.omit(unique(qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=TRUE,container = iparmbox.varsite.frame, expand = TRUE, fill = TRUE)
  iparmbox.show.points <- gcheckbox(text = "Show sample points",checked=FALSE,use.togglebutton = TRUE,container =iparmbox.vargroup)
  iparmbox.log.scale <- gcheckbox(text = "Log10 scale",checked=FALSE,use.togglebutton = TRUE,container =iparmbox.vargroup)
  
  gbutton(text = "Refresh plot",container =iparmbox.vargroup,handler = function(h,...) {iparmbox(iparmbox.site.selection = svalue(iparmbox.site.selection),
                                                                                                         iparmbox.plotparm = svalue(iparmbox.plotparm),
                                                                                                         iparmbox.show.points = svalue(iparmbox.show.points),
                                                                                                         iparmbox.log.scale = svalue(iparmbox.log.scale))})
  
  ###Save plot
  
  gbutton(text="Export Plot", container = iparmbox.vargroup,handler = function(h,...) {
    saveplot()
  })
  
  addHandlerClicked(iparmbox.plotparm,handler = function(h,...) {iparmbox(iparmbox.site.selection = svalue(iparmbox.site.selection),
                                                                                  iparmbox.plotparm = svalue(iparmbox.plotparm),
                                                                                  iparmbox.show.points = svalue(iparmbox.show.points),
                                                                          iparmbox.log.scale = svalue(iparmbox.log.scale))})
  addHandlerClicked(iparmbox.site.selection,handler = function(h,...) {iparmbox(iparmbox.site.selection = svalue(iparmbox.site.selection),
                                                                                        iparmbox.plotparm = svalue(iparmbox.plotparm),
                                                                                        iparmbox.show.points = svalue(iparmbox.show.points),
                                                                                iparmbox.log.scale = svalue(iparmbox.log.scale))})
  
  visible(iparmbox.mainGroup) <- TRUE
  
  
}
