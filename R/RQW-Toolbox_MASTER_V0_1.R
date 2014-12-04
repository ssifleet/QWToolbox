###Source misc
source("R/libraries.r")
source("R/preferences.r")


##################
###Main window
##################

w <- gwindow("Toolkit example")
visible(w) <- FALSE #Hide the GUI until its fully built

###Toolbar setup
tbl <- list()
tbl$Save <- list(icon="save",handler = function(...) print("save"))
tbl$Open <- list(icon="open",handler = function(...) print("open"))
tbl$New <- list(icon="new",handler = function(...) print("new"))
tbl$Quit <- list(icon="close",handler = function(...) print("quit"))
tb <- gtoolbar(tbl, container=w)

###Notebook
nb <- gnotebook(container=w)

###################
###Data import Tab
###################

source("R/Dataimport_GUI.R")

###################
###Plotting tab
###################
source("R/plotting_GUI.R")
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
source("R/NWISUploadR_GUI_V1.r")


###Source gui functions
source("R/itsplot_gui.r")
source("R/iseasonalbox_gui.r")
source("R/matrixplot_gui.r")
source("R/iparmplot_gui.r")
source("R/icbplot_gui.r")
source("R/icbparmplot_gui.r")
source("R/icbsumplot_gui.r")
source("R/iparmbox_gui.r")
source("R/saveplot.r")
###Source plot functions
source("R/theme_usgs.r")
source("R/itsplot_function.r")
source("R/iseasonalbox_function.r")
source("R/matrixplot_function.r")
source("R/iparmplot_function.r")
source("R/icbplot_function.r")
source("R/icbparmplot_function.r")
source("R/icbsumplot_function.r")
source("R/iparmbox_function.r")
###Source data functions
source("R/NWISUploadRV1_4(20141201).r")
source("R/NWIS_PullR(20141201).r")
source("R/ionbalance.r")

visible(w) <- TRUE

