iparmplot_gui <- function(...){
  ###These exist checks are so that the data is refreshed when the user does a new data pull
  ###Since the tables are dependent on the data, they need to be refreshed
  
  ## Set up main group, make global so can be deleted 
  if(exists("iparm.mainGroup"))
  {
    if(!isExtant(iparm.mainGroup))
    {
    iparm.mainGroup <<- ggroup(label="Parameter-parameter",container=interactive.frame)
    }
  }else(iparm.mainGroup <<- ggroup(label="Parameter-parameter",container=interactive.frame))
  
  #Check for existing tables and delete to refresh
  if(exists("iparm.vargroup"))
  {
    if(isExtant(iparm.vargroup))
    {
    delete(iparm.mainGroup,iparm.vargroup)
    }
    iparm.vargroup <<- gframe(container=iparm.mainGroup,expand=TRUE,horizontal=FALSE)
  }else(iparm.vargroup <<- gframe(container=iparm.mainGroup,expand=TRUE,horizontal=FALSE))


  ###Hide window until fully built
  visible(iparm.mainGroup) <- FALSE
  
  ###Parameter selection frame
  iparm.varsite.frame <- gframe(container=iparm.vargroup,expand=TRUE,horizontal=FALSE)
  iparm.site.selection <- gtable(items = na.omit(unique(qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = iparm.varsite.frame, expand = TRUE)
  iparm.xparm <- gtable(items = na.omit(unique(qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=FALSE,container = iparm.varsite.frame, expand = TRUE, fill = TRUE)
  iparm.yparm <- gtable(items = na.omit(unique(qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=FALSE,container = iparm.varsite.frame, expand = TRUE, fill = TRUE)
  iparm.show.lm <- gcheckbox(text = "Add linear fit",checked=FALSE,use.togglebutton = TRUE,container =iparm.vargroup)
  
  gbutton(text = "Refresh plot",container =iparm.vargroup,handler = function(h,...) {iparmplot(iparm.site.selection= svalue(iparm.site.selection),
                                                                                               iparm.xparm = svalue(iparm.xparm),
                                                                                               iparm.yparm = svalue(iparm.yparm),
                                                                                               iparm.show.lm = svalue(iparm.show.lm))}) 
  

gbutton(text="Export Plot", container = iparm.vargroup,handler = function(h,...) {
  saveplot()
})

addHandlerClicked(iparm.xparm,handler = function(h,...) {iparmplot(iparm.site.selection= svalue(iparm.site.selection),
                                                                   iparm.xparm = svalue(iparm.xparm),
                                                                   iparm.yparm = svalue(iparm.yparm),
                                                                   iparm.show.lm = svalue(iparm.show.lm))})  
addHandlerClicked(iparm.yparm,handler = function(h,...) {iparmplot(iparm.site.selection= svalue(iparm.site.selection),
                                                                   iparm.xparm = svalue(iparm.xparm),
                                                                   iparm.yparm = svalue(iparm.yparm),
                                                                   iparm.show.lm = svalue(iparm.show.lm))})                  
addHandlerClicked(iparm.site.selection,handler = function(h,...) {iparmplot(iparm.site.selection= svalue(iparm.site.selection),
                                                                            iparm.xparm = svalue(iparm.xparm),
                                                                            iparm.yparm = svalue(iparm.yparm),
                                                                            iparm.show.lm = svalue(iparm.show.lm))})
  
  visible(iparm.mainGroup) <- TRUE

}
