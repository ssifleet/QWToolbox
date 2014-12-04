icbsumplot_gui <- function(...){
  ###These exist checks are so that the data is refreshed when the user does a new data pull
  ###Since the tables are dependent on the data, they need to be refreshed
  
  
  ## Set up main group, make global so can be deleted 
  if(exists("icbsum.mainGroup"))
  {
    if(!isExtant(icbsum.mainGroup))
    {
      icbsum.mainGroup <<- ggroup(label="Chargebalance vs sum(Cat/An)",container=interactive.frame)
    }
  }else(icbsum.mainGroup <<- ggroup(label="Chargebalance vs sum(Cat/An)",container=interactive.frame))
  
  
  if(exists("icbsum.vargroup"))
  {
    if(isExtant(icbsum.vargroup))
    {
    delete(icbsum.mainGroup,icbsum.vargroup)
    }
    icbsum.vargroup <<- gframe(container=icbsum.mainGroup,expand=TRUE,horizontal=FALSE)
  }else(icbsum.vargroup <<- gframe(container=icbsum.mainGroup,expand=TRUE,horizontal=FALSE))
  

  visible(icbsum.mainGroup) <- FALSE
  
  
  
  ###Parameter browser
  
  icbsum.varsite.frame <- gframe(container=icbsum.vargroup,expand=TRUE,horizontal=FALSE)
  icbsum.site.selection <- gtable(items = na.omit(unique(qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = icbsum.varsite.frame, expand = TRUE)
  icbsum.plotparm <- gtable(items = c("sum cations","sum anions"),multiple=FALSE,container = icbsum.varsite.frame, expand = TRUE, fill = TRUE)
  
  ###Save plot
  
  gbutton(text="Export Plot", container = icbsum.vargroup,handler = function(h,...) {
  saveplot()
    }) 
    
    addHandlerClicked(icbsum.site.selection,handler = function(h,...) {icbsumplot(icbsum.site.selection = svalue(icbsum.site.selection),
                                                                                  icbsum.plotparm = svalue(icbsum.plotparm))})
    addHandlerClicked(icbsum.plotparm,handler = function(h,...) {icbsumplot(icbsum.site.selection = svalue(icbsum.site.selection),
                                                                            icbsum.plotparm = svalue(icbsum.plotparm))})  

  
  
  

  
  visible(icbsum.mainGroup) <- TRUE
  
}
