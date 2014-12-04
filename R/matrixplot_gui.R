matrixplot_gui <- function(...){
  ###These exist checks are so that the data is refreshed when the user does a new data pull
  ###Since the tables are dependent on the data, they need to be refreshed
  
  ## Set up main group, make global so can be deleted 
if(exists("matrix.mainGroup"))
{
  if(!isExtant(matrix.mainGroup))
  {
    matrix.mainGroup <<- ggroup(label="Matrix plot",container=interactive.frame)
  }
}else(matrix.mainGroup <<- ggroup(label="Matrix plot",container=interactive.frame))

if(exists("matrix.vargroup"))
{
  if(isExtant(matrix.vargroup))
  {
  delete(matrix.mainGroup,matrix.vargroup)
  }
  matrix.vargroup <<- gframe("Parameters",container=matrix.mainGroup,expand=TRUE,horizontal=FALSE)
}else(matrix.vargroup <<- gframe("Parameters",container=matrix.mainGroup,expand=TRUE,horizontal=FALSE))





  
  visible(matrix.mainGroup) <- FALSE
  

  ###Parameter browser
  matrix.site.selection <- gtable(items = na.omit(unique(qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = matrix.vargroup, expand = TRUE)
  matrix.plotparm <- gtable(items = na.omit(unique(qw.data$PlotTable[c("PARM_CD","PARM_NM","PARM_SEQ_GRP_CD")])),multiple=TRUE,container = matrix.vargroup, expand = TRUE, fill = TRUE)

  ###Plotting handler for table
  gbutton("Make plot",container=matrix.vargroup,handler = function(h,...) {

    matrixplot(matrix.site.selection = svalue(matrix.site.selection),
               matrix.plotparm = svalue(matrix.plotparm))
    
  })
  
  
  
  visible(matrix.mainGroup) <- TRUE
  

}










