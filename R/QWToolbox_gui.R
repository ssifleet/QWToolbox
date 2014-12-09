#' QWToolbox gui
#' Function to run the QWToolbox gui
#' @export


qwtoolbox <- function(...){
###Create an environment to hold objects and gui elements created inside hanlders. handlers are functions responding to user inputs (e.g. addHandlerClicked), but the objects they create need to be accessed everywhere
  
.guiEnv <<- new.env()
  
###Initialize variables
preferences()
  
##################
###Main window
##################

.guiEnv$w <- gwindow("Toolkit example")
visible(.guiEnv$w) <- FALSE #Hide the GUI until its fully built

###Toolbar setup
.guiEnv$tbl <- list()
.guiEnv$tbl$Save <- list(icon="save",handler = function(...) print("save"))
.guiEnv$tbl$Open <- list(icon="open",handler = function(...) print("open"))
.guiEnv$tbl$New <- list(icon="new",handler = function(...) print("new"))
.guiEnv$tbl$Quit <- list(icon="close",handler = function(...) print("quit"))
.guiEnv$tb <- gtoolbar(.guiEnv$tbl, container=.guiEnv$w)

###Notebook
.guiEnv$nb <- gnotebook(container=.guiEnv$w)

###################
###Data import Tab
###################

dataImport_gui()

###################
###Plotting tab
###################

plotting_gui()

###################
###Tables tab
###################

tables_gui()

###################
###DQI Tab
###################



#####################
###Data Upload tab
#####################
NWISuploadR_gui()


visible(.guiEnv$w) <- TRUE

}
