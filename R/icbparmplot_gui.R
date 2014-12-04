icbparmplot_gui <- function(...){
  ###These exist checks are so that the data is refreshed when the user does a new data pull
  ###Since the tables are dependent on the data, they need to be refreshed
  
  ## Set up main group, make global so can be deleted 
  if(exists("icbparm.mainGroup"))
  {
    if(!isExtant(icbparm.mainGroup))
    {
    icbparm.mainGroup <<- ggroup(label="Chargebalance-parameter",container=interactive.frame)
    }
  } else(icbparm.mainGroup <<- ggroup(label="Chargebalance-parameter",container=interactive.frame))
  
  #Check for existing tables and delete to refresh
  if(exists("icbparm.vargroup"))
  {
    if(isExtant(icbparm.vargroup))
    {
    delete(icbparm.mainGroup,icbparm.vargroup)
    }
    icbparm.vargroup <<- gframe(container=icbparm.mainGroup,expand=TRUE,horizontal=FALSE)
  }else(icbparm.vargroup <<- gframe(container=icbparm.mainGroup,expand=TRUE,horizontal=FALSE))
  
  


  visible(icbparm.mainGroup) <- FALSE

  
  ###Parameter browser

icbparm.varsite.frame <- gframe(container=icbparm.vargroup,expand=TRUE,horizontal=FALSE)
icbparm.site.selection <- gtable(items = na.omit(unique(qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = icbparm.varsite.frame, expand = TRUE)
icbparm.plotparm <- gtable(items = na.omit(unique(qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=FALSE,container = icbparm.varsite.frame, expand = TRUE, fill = TRUE)

###Refresh plot
gbutton(text = "Refresh plot",container =icbparm.vargroup,handler = function(h,...) {icbparmplot(icbparm.site.selection = svalue(icbparm.site.selection),
                                                                                                 icbparm.plotparm = svalue(icbparm.plotparm))})
  ###Save plot
  
  gbutton(text="Export Plot", container = icbparm.vargroup,handler = function(h,...) {
svaeplot()
  })
  
  
addHandlerClicked(icbparm.site.selection,handler = function(h,...) {icbparmplot(icbparm.site.selection = svalue(icbparm.site.selection),
                                                                                icbparm.plotparm = svalue(icbparm.plotparm))})
addHandlerClicked(icbparm.plotparm,handler = function(h,...) {icbparmplot(icbparm.site.selection = svalue(icbparm.site.selection),
                                                                          icbparm.plotparm = svalue(icbparm.plotparm))})   
  
  
  
  
  visible(icbparm.mainGroup) <- TRUE
  
}
