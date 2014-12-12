iscsumplot_gui <- function(...){

      .guiEnv$iscsum.mainGroup <- ggroup(label="Ions vs conductance",container=.guiEnv$interactive.frame)
      .guiEnv$iscsum.vargroup <- gframe(container=.guiEnv$iscsum.mainGroup,expand=TRUE,horizontal=FALSE)
  

  visible(.guiEnv$iscsum.mainGroup) <- FALSE
  
  
  
  ###Parameter browser
  
  .guiEnv$iscsum.varsite.frame <- gframe(container=.guiEnv$iscsum.vargroup,expand=TRUE,horizontal=FALSE)
  .guiEnv$iscsum.site.selection <- gtable(items = na.omit(unique(.guiEnv$qw.data$PlotTable[c("SITE_NO","STATION_NM")])),multiple=TRUE,container = .guiEnv$iscsum.varsite.frame, expand = TRUE)
  .guiEnv$iscsum.plotparm <- gtable(items = c("sum cations","sum anions","Both"),multiple=FALSE,container = .guiEnv$iscsum.varsite.frame, expand = TRUE, fill = TRUE)
  
  ###Refresh plot
  gbutton(text = "Refresh plot",container =.guiEnv$iscsum.vargroup,handler = function(h,...) {
    iscsumplot(qw.data = .guiEnv$qw.data,
               new.threshold = .guiEnv$new.threshold,
               iscsum.site.selection = svalue(.guiEnv$iscsum.site.selection),
               iscsum.plotparm = svalue(.guiEnv$iscsum.plotparm))
  })
  
  ###Flag sample 
 gbutton(text="Flag sample",container = .guiEnv$iscsum.vargroup,handler = function(h,...) {
    ###Refresh plot so that viewport exists
   if(svalue(.guiEnv$iscsum.plotparm) != "Both")
   {
            iscsumplot(qw.data = .guiEnv$qw.data,
                   new.threshold = .guiEnv$new.threshold,
                   iscsum.site.selection = svalue(.guiEnv$iscsum.site.selection),
                   iscsum.plotparm = svalue(.guiEnv$iscsum.plotparm))
    ###get a dataframe identical to the one used by the plot to pass to flagger function
             data <- subset(.guiEnv$qw.data$PlotTable,SITE_NO %in% 
                     (svalue(.guiEnv$iscsum.site.selection)) & 
                     PARM_CD== "00095")
              x <- data$RESULT_VA
            if(svalue(.guiEnv$iscsum.plotparm) == "sum anions")
              {
                  y <- data$sum_an
              }else if(svalue(.guiEnv$iscsum.plotparm) == "sum cations")
              {
                y <- data$sum_cat
              }
       
    ###run flagger function. This returns the row index of the sample which is used to grab the record number
    row.index <- flagger(data=data,x=x,y=y)
    .guiEnv$flagged.samples <-  rbind(.guiEnv$flagged.samples,data.frame(RECORD_NO = data$RECORD_NO[row.index],FLAG_WHERE="sum/Sc plot"))
   }
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
