#' QWToolbox gui
#' Function to run the QWToolbox gui
#' @export

qwtoolbox <- function(...){
  
  ###Create an environment to hold objects and gui elements created inside hanlders. handlers are functions responding to user inputs (e.g. addHandlerClicked), but the objects they create need to be accessed everywhere
  
  .guiEnv <<- new.env()

  ###Initialize variables
  .guiEnv$siteIDs <- ""
  .guiEnv$pcodes <- ""
  .guiEnv$flagged.samples <- data.frame(RECORD_NO = character(),
                                        FLAG_WHERE = character())
  
  ##################
  ###Main window
  ##################
  
  .guiEnv$w <- gwindow("QWToolbox")
  
  ###This will eventually be used to save and load preferences for gui setup, such as site and pcode lists. For now those are edited outside the program in a CSV file
  
  ###Toolbar setup
  .guiEnv$tbl <- list()
  .guiEnv$tbl$Save <- list(icon="save",handler = function(...) 
    {
    popwin <- gwindow("Save preferences")
    popwin.frame <- gframe(container=popwin,expand=TRUE,horizontal=FALSE)
    glabel("SiteID filename",container = popwin.frame)
    .guiEnv$IDprefs.file <- gfilebrowse(container = popwin.frame,text = "Select site ID file...",quote = FALSE)
    
    gbutton("Save favorite site list",container=popwin.frame,handler = function(...){
      write.csv(.guiEnv$siteIDs,file=svalue(.guiEnv$IDprefs.file),row.names=FALSE,col.names=FALSE)
      })
    glabel("pCode filename",container = popwin.frame)
    .guiEnv$pCodeprefs.file <- gfilebrowse(container = popwin.frame,text = "Select site ID file...",quote = FALSE)
    
    gbutton("Save favorite pCode list",container=popwin.frame,handler = function(...){
      write.csv(.guiEnv$pcodes,file=svalue(.guiEnv$pCodeprefs.file),row.names=FALSE,col.names=FALSE)
    })
    })

  .guiEnv$tbl$Open <- list(icon="open",handler = function(...) 
  {
    popwin <- gwindow("Open preferences")
    popwin.frame <- gframe(container=popwin,expand=TRUE,horizontal=FALSE)
    glabel("SiteID filename",container = popwin.frame)
    .guiEnv$IDprefs.file <- gfilebrowse(container = popwin.frame,text = "Select site ID file...",quote = FALSE)
    
    gbutton("Open favorite site list",container=popwin.frame,handler = function(...){
      .guiEnv$siteIDs <- read.csv(file = svalue(.guiEnv$IDprefs.file), header=F,colClasses = "character")
      names(.guiEnv$siteIDs) <- "SiteIDs"
      delete(.guiEnv$fsite.frame,.guiEnv$favsites)
      .guiEnv$favsites <- gtable(items = .guiEnv$siteIDs,multiple=TRUE,container = .guiEnv$fsite.frame, expand = TRUE, fill = TRUE)
      })
    glabel("pCode filename",container = popwin.frame)
    .guiEnv$pCodeprefs.file <- gfilebrowse(container = popwin.frame,text = "Select site ID file...",quote = FALSE)
    
    gbutton("Open favorite pCode list",container=popwin.frame,handler = function(...){
      .guiEnv$pcodes <- read.csv(file=svalue(.guiEnv$pCodeprefs.file), header=F,colClasses = "character")
      names(.guiEnv$pcodes) <- "pCodes"
      delete(.guiEnv$fpcode.frame,.guiEnv$favpcodes)
      .guiEnv$favpcodes <- gtable(items = .guiEnv$pcodes,multiple=TRUE,container = .guiEnv$fpcode.frame, expand = TRUE, fill = TRUE)
      })
    
  })
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
  

}
