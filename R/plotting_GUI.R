plotting_gui <- function(...)
{

##################
###Plotting Tab###
##################
##Main plotting frame
.guiEnv$plotting.frame <- gframe(container=.guiEnv$nb, label = "Plotting",horizontal=FALSE,expand=TRUE,index=2) 
###Display graphics device
gbutton(text="Open plot device", container=.guiEnv$plotting.frame,handler = function(h,...){
  ###Check for an open device and close it if one is open. Prevents multiple graphics devices opening
  if (!is.null(dev.list())) {
    dev.off()
  }
  win.graph(width = 7, height = 7, pointsize = 12)
})
.guiEnv$new.data.frame <- gframe("New data threshold (default is 1 month)",container=.guiEnv$plotting.frame,expand=FALSE)
.guiEnv$new.data.num <- gedit(container = .guiEnv$new.data.frame)
svalue(.guiEnv$new.data.num) <- 1
.guiEnv$new.data.mag <- gcombobox(c("Days","Weeks","Months","Years"),container=.guiEnv$new.data.frame)
svalue(.guiEnv$new.data.mag) <- "Months"

.guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24*30

gbutton("Set",container=.guiEnv$new.data.frame,handler = function(h,...){
  if(svalue(.guiEnv$new.data.mag)=="Days")
  {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24
  } else if (svalue(.guiEnv$new.data.mag)=="Weeks") {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24*7
  } else if (svalue(.guiEnv$new.data.mag)=="Months") {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24*30
  } else if (svalue(.guiEnv$new.data.mag)=="Years") {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24*365
  }
  
})
###Threshold for default

addHandlerChanged(.guiEnv$new.data.num,handler = function(h,...){
  if(svalue(.guiEnv$new.data.mag)=="Days")
  {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24
  } else if (svalue(.guiEnv$new.data.mag)=="Weeks") {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24*7
  } else if (svalue(.guiEnv$new.data.mag)=="Months") {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24*30
  } else if (svalue(.guiEnv$new.data.mag)=="Years") {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24*365
  }
})
addHandlerChanged(.guiEnv$new.data.mag,handler = function(h,...){
  if(svalue(.guiEnv$new.data.mag)=="Days")
  {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24
  } else if (svalue(.guiEnv$new.data.mag)=="Weeks") {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24*7
  } else if (svalue(.guiEnv$new.data.mag)=="Months") {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24*30
  } else if (svalue(.guiEnv$new.data.mag)=="Years") {
    .guiEnv$new.threshold <- as.numeric(svalue(.guiEnv$new.data.num)) * 60*60*24*365
  }
})
##################################################################################################################
###Interactive plotting pane
################################################################################################################

.guiEnv$interactive.frame <- gnotebook(container=.guiEnv$plotting.frame,expand=TRUE)  



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

}
