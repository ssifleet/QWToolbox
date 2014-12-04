##################
###Plotting Tab###
##################
##Main plotting frame
plotting.frame <- gframe(container=nb, label = "Plotting",horizontal=FALSE,expand=TRUE) 
###Display graphics device
gbutton(text="Open plot device", container=plotting.frame,handler = function(h,...){
  ###Check for an open device and close it if one is open. Prevents multiple graphics devices opening
  if (!is.null(dev.list())) {
    dev.off()
  }
  win.graph(width = 7, height = 7, pointsize = 12)
})
new.data.frame <- gframe("New data threshold (default is 1 month)",container=plotting.frame,expand=FALSE)
new.data.num <- gedit(container = new.data.frame)
svalue(new.data.num) <- 1
new.data.mag <- gcombobox(c("Days","Weeks","Months","Years"),container=new.data.frame)
svalue(new.data.mag) <- "Months"
gbutton("Set",container=new.data.frame,handler = function(h,...){
  if(svalue(new.data.mag)=="Days")
  {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24
  } else if (svalue(new.data.mag)=="Weeks") {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24*7
  } else if (svalue(new.data.mag)=="Months") {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24*30
  } else if (svalue(new.data.mag)=="Years") {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24*365
  }
  
})
###Threshold for default
new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24*30
addHandlerChanged(new.data.num,handler = function(h,...){
  if(svalue(new.data.mag)=="Days")
  {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24
  } else if (svalue(new.data.mag)=="Weeks") {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24*7
  } else if (svalue(new.data.mag)=="Months") {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24*30
  } else if (svalue(new.data.mag)=="Years") {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24*365
  }
})
addHandlerChanged(new.data.mag,handler = function(h,...){
  if(svalue(new.data.mag)=="Days")
  {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24
  } else if (svalue(new.data.mag)=="Weeks") {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24*7
  } else if (svalue(new.data.mag)=="Months") {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24*30
  } else if (svalue(new.data.mag)=="Years") {
    new.threshold <<- as.numeric(svalue(new.data.num)) * 60*60*24*365
  }
})
##################################################################################################################
###Interactive plotting pane
################################################################################################################

interactive.frame <- gnotebook(container=plotting.frame,expand=TRUE)  
visible(interactive.frame) <- TRUE

###################
####Time series####
###################

########################
###Batch Book pane
########################

###Parent frame
#batch.frame <- gframe("Batch plotting",container=plotting.frame,expand=TRUE,horizontal=FALSE)  

###Output options frame
#batch.output.frame <- gframe(container=batch.frame,expand=TRUE,horizontal=FALSE)
#glabel(text="Select directory for batch ouput files",container=batch.output.frame)
#iplot.filename <- gfilebrowse(container = batch.output.frame,text = "Select site ID file...",quote = FALSE)###Directory input
#glabel(text="Select a plot file format (default is pdf)",container=batch.output.frame)
#plot.file.format <- gcombobox(c("pdf","svg","jpeg","png","bmp","svg"), container=batch.output.frame)


