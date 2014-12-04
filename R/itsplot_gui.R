itsplot_gui <- function (...){
  ###These exist checks are so that the data is refreshed when the user does a new data pull
  ###Since the tables are dependent on the data, they need to be refreshed
  
  ## Set up main group, make global so can be checked for exist and deleteded to refresh tables  
  if(exists("its.mainGroup"))
  {
    if(!isExtant(its.mainGroup))
    {
      its.mainGroup <<- ggroup(label="Timeseries",container=interactive.frame)
    }
  }else(its.mainGroup <<- ggroup(label="Timeseries",container=interactive.frame))
  
#Check for existing tables and delete to refresh
if(exists("its.vargroup"))
{
  if(isExtant(its.vargroup))
    {
      delete(its.mainGroup,its.vargroup)
    }
  its.vargroup <<- gframe(container=its.mainGroup,expand=TRUE,horizontal=FALSE)
}else(its.vargroup <<- gframe(container=its.mainGroup,expand=TRUE,horizontal=FALSE))


visible(its.mainGroup) <- FALSE

  
  ###Parameter browser
  
  ###Make globala so can be checked for exist and deleteded to refresh tables
  
  

  its.varsite.frame <- gframe(container=its.vargroup,expand=TRUE,horizontal=FALSE)
  its.site.selection <- gtable(items = na.omit(unique(qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=FALSE,container = its.varsite.frame, expand = TRUE)
  its.plotparm <- gtable(items = na.omit(unique(qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=FALSE,container = its.varsite.frame, expand = TRUE, fill = TRUE)
  glabel("Begin Date",container=its.vargroup)
  its.begin.date.slider <- gslider(from = as.Date(min(qw.data$PlotTable$SAMPLE_START_DT)),to=as.Date(max(qw.data$PlotTable$SAMPLE_START_DT)),by=1,container=its.vargroup)
  glabel("End Date",container=its.vargroup)
  its.end.date.slider <- gslider(from = as.Date(min(qw.data$PlotTable$SAMPLE_START_DT)),to=as.Date(max(qw.data$PlotTable$SAMPLE_START_DT)),value=as.Date(max(qw.data$PlotTable$SAMPLE_START_DT)),by=1,container=its.vargroup)
  

  ###Option to add smooth
  its.show.smooth <- gcheckbox(text = "Add loess smooth",checked=FALSE,use.togglebutton = TRUE,container =its.vargroup)
  ###Option to add hydrograph
  its.show.q <- gcheckbox(text = "Show instantaneous hydrograph",checked=FALSE,use.togglebutton = TRUE,container =its.vargroup)
  
  ###Refresh plot
  gbutton(text = "Refresh plot",container =its.vargroup,handler = function(h,...) {
   itsplot(its.site.selection = svalue(its.site.selection),
           its.plotparm = svalue(its.plotparm),
           its.begin.date.slider = svalue(its.begin.date.slider),
           its.end.date.slider = svalue(its.end.date.slider),
           its.show.q = svalue(its.show.q),
           its.show.smooth = svalue(its.show.smooth))
  })
    
    
  ###Save plot
  
  gbutton(text="Export Plot", container = its.vargroup,handler = function(h,...) {
    saveplot()
  })
  
addHandlerClicked(its.plotparm,handler = function(h,...) {itsplot(its.site.selection = svalue(its.site.selection),
                                                                 its.plotparm = svalue(its.plotparm),
                                                                 its.begin.date.slider = svalue(its.begin.date.slider),
                                                                 its.end.date.slider = svalue(its.end.date.slider),
                                                                 its.show.q = svalue(its.show.q),
                                                                 its.show.smooth = svalue(its.show.smooth))})
addHandlerClicked(its.site.selection,handler = function(h,...) {itsplot(its.site.selection = svalue(its.site.selection),
                                                                       its.plotparm = svalue(its.plotparm),
                                                                       its.begin.date.slider = svalue(its.begin.date.slider),
                                                                       its.end.date.slider = svalue(its.end.date.slider),
                                                                       its.show.q = svalue(its.show.q),
                                                                       its.show.smooth = svalue(its.show.smooth))})

  visible(its.mainGroup) <- TRUE
  
}
