icbplot_gui <- function(...){
  ###These exist checks are so that the data is refreshed when the user does a new data pull
  ###Since the tables are dependent on the data, they need to be refreshed
  
  ## Set up main group, make global so can be deleted 
  if(exists("icb.mainGroup"))
  {
    if(!isExtant(icb.mainGroup))
    {
      icb.mainGroup <<- ggroup(label="Chargebalance timeseries",container=interactive.frame)
    }
  }else(icb.mainGroup <<- ggroup(label="Chargebalance timeseries",container=interactive.frame))
  
  #Check for existing tables and delete to refresh
  if(exists("icb.vargroup"))
  {
    if(isExtant(icb.vargroup))
    {
    delete(icb.mainGroup,icb.vargroup)
    }
    icb.vargroup <<- gframe(container=icb.mainGroup,expand=TRUE,horizontal=FALSE)
  }else(icb.vargroup <<- gframe(container=icb.mainGroup,expand=TRUE,horizontal=FALSE))
  



  visible(icb.mainGroup) <- FALSE
  
  
  ###Parameter browser
  icb.varsite.frame <- gframe(container=icb.vargroup,expand=TRUE,horizontal=FALSE)
  icb.site.selection <- gtable(items = na.omit(unique(qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = icb.varsite.frame, expand = TRUE)
  
  glabel("Begin Date",container=icb.vargroup)
  icb.begin.date.slider <- gslider(from = as.Date(min(qw.data$PlotTable$SAMPLE_START_DT)),to=as.Date(max(qw.data$PlotTable$SAMPLE_START_DT)),by=1,container=icb.vargroup)
  glabel("End Date",container=icb.vargroup)
  icb.end.date.slider <- gslider(from = as.Date(min(qw.data$PlotTable$SAMPLE_START_DT)),to=as.Date(max(qw.data$PlotTable$SAMPLE_START_DT)),value=as.Date(max(qw.data$PlotTable$SAMPLE_START_DT)),by=1,container=icb.vargroup)
  
  
  ###Option to add smooth
  icb.show.smooth <- gcheckbox(text = "Add loess smooth",checked=FALSE,use.togglebutton = TRUE,container =icb.vargroup)
  
  ###refresh plot
  gbutton(text = "Refresh plot",container =icb.vargroup,handler = function(h,...) {icbplot(icb.site.selection = svalue(icb.site.selection),
                                                                                           icb.begin.date.slider = svalue(icb.begin.date.slider),
                                                                                           icb.end.date.slider = svalue(icb.end.date.slider),
                                                                                           icb.show.smooth = svalue(icb.show.smooth))})
          

  gbutton(text="Export Plot", container = icb.vargroup,handler = function(h,...) {
saveplot()
  })
  
addHandlerClicked(icb.site.selection,handler = function(h,...) {icbplot(icb.site.selection = svalue(icb.site.selection),
                                                                        icb.begin.date.slider = svalue(icb.begin.date.slider),
                                                                        icb.end.date.slider = svalue(icb.end.date.slider),
                                                                        icb.show.smooth = svalue(icb.show.smooth))})


  visible(icb.mainGroup) <- TRUE
  

}