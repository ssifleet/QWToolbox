###Clear environment, this should not be neccesary once built into package. Right now, for some reason the reactive gui elements (e.g. itsplot_gui) fail when started with an old environment
rm(list = ls())

###Create an environment to hold objects and gui elements created inside hanlders. handlers are functions responding to user inputs (e.g. addHandlerClicked), but the objects they create need to be accessed everywhere
.guiEnv <- new.env()

###Source misc
source("R/libraries.r")
source("R/preferences_function.r")
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

source("R/Dataimport_GUI.R")
dataImport_gui()
###################
###Plotting tab
###################
source("R/plotting_GUI.R")
plotting_gui()
###################
###Tables tab
###################
source("R/tables_gui.r")

###################
###DQI Tab
###################



#####################
###Data Upload tab
#####################
#source("R/NWISUploadR_GUI_V1.r")


###Source gui functions
source("R/itsplot_gui.r")
source("R/iseasonalbox_gui.r")
source("R/matrixplot_gui.r")
source("R/iparmplot_gui.r")
source("R/icbplot_gui.r")
source("R/icbparmplot_gui.r")
source("R/iscsumplot_gui.r")
source("R/iparmbox_gui.r")
source("R/saveplot_function.r")
###Source plot functions
source("R/theme_usgs_function.r")
source("R/itsplot_function.r")
source("R/iseasonalbox_function.r")
source("R/matrixplot_function.r")
source("R/iparmplot_function.r")
source("R/icbplot_function.r")
source("R/icbparmplot_function.r")
source("R/iscsumplot_function.r")
source("R/iparmbox_function.r")
source("R/flagger_function.r")
###Source data functions
source("R/NWISUploadR_function.r")
source("R/NWIS_PullR_function.r")
source("R/ionbalance_function.r")

visible(.guiEnv$w) <- TRUE

