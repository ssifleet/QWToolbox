dataImport_gui <- function(...){
  


##################
####Data import Tab
##################

##############################
###Setup the main window frame
##############################
.guiEnv$outerdatatab <- gframe(container=.guiEnv$nb,horizontal=FALSE, label = "Data import",index=1)
.guiEnv$datatab <- gframe("Discrete QW Data",container=.guiEnv$outerdatatab,expand=TRUE) 
.guiEnv$date.frame <- gframe(container=.guiEnv$outerdatatab,expand=FALSE)
.guiEnv$server.frame <- gframe(container=.guiEnv$outerdatatab,expand=FALSE)
########################
###Universal inputs
########################

###Date inputs
glabel("Begin date",container = .guiEnv$date.frame)
.guiEnv$begindate <- gcalendar(text = "yyyy-mm-dd", format = "%Y-%m-%d", handler=NULL, 
                       action=NULL, container = .guiEnv$date.frame)

glabel("End date",container = .guiEnv$date.frame)
.guiEnv$enddate <- gcalendar(text = "yyyy-mm-dd", format = "%Y-%m-%d", handler=NULL, 
                     action=NULL, container = .guiEnv$date.frame)

###Compute charge balance option
.guiEnv$calc.balance <- gcheckbox("Calculate charge balance?",checked=FALSE,container=.guiEnv$date.frame)

if(exists("do.calc.balance",envir=.guiEnv))
{
  svalue(.guiEnv$calc.balance) <- .guiEnv$do.calc.balance
  }else{}

svalue(.guiEnv$calc.balance) <- TRUE
###Server inputs
glabel("NWIS server\nname",container = .guiEnv$server.frame)
.guiEnv$dlserver.name <- gedit(container = .guiEnv$server.frame,initial.msg = "e.g. NWISCO") 

glabel("Environmental database\nnumber",container = .guiEnv$server.frame)
.guiEnv$env.db.num <- gedit(container = .guiEnv$server.frame,initial.msg = "e.g. 01") 

glabel("QA database\nnumber",container = .guiEnv$server.frame)
.guiEnv$qa.db.num <- gedit(container = .guiEnv$server.frame,initial.msg = "e.g. 02") 

gbutton(text="Import data", container=.guiEnv$outerdatatab,handler = function(h,...){
            
          ###Site ID input by method
          if(svalue(.guiEnv$siteid.method, index=TRUE) == 1)
               {
                .guiEnv$STAIDS <- svalue(.guiEnv$sitenumber)
                } else if(svalue(.guiEnv$siteid.method, index=TRUE) == 2)
                {
                  .guiEnv$STAIDS <- svalue(.guiEnv$favsites)
                } else if(svalue(.guiEnv$siteid.method, index=TRUE) == 3)
                {
                  .guiEnv$STAIDS <- (scan(svalue(.guiEnv$ID.file),what="character"))
                }
            
            ###pcode input by method
            if(svalue(.guiEnv$pcode.method, index=TRUE) == 1)
            {
              .guiEnv$parm.group.check <- TRUE
              if(svalue(.guiEnv$parm.group,index=TRUE) != 1)
              {
                .guiEnv$dl.parms <- nwis.parm.groups[svalue(.guiEnv$parm.group,index=TRUE)]
              } else {.guiEnv$dl.parms <- "All"}
            } else if(svalue(.guiEnv$pcode.method, index=TRUE) == 2)
            {
              .guiEnv$dl.parms <- svalue(.guiEnv$favpcodes)
              .guiEnv$parm.group.check <- FALSE
            } else if(svalue(.guiEnv$pcode.method, index=TRUE) == 3)
            {
              .guiEnv$dl.parms <- scan(svalue(.guiEnv$parmfile),what="character")
              .guiEnv$parm.group.check <- FALSE
            }
            
            ###Check for valid date range
            if(!is.na(svalue(.guiEnv$begindate)) && !is.na(svalue(.guiEnv$enddate))) 
              {
              .guiEnv$begin.date = as.POSIXct(svalue(.guiEnv$begindate))
              .guiEnv$end.date = as.POSIXct(svalue(.guiEnv$enddate))
            } else{.guiEnv$begin.date = svalue(.guiEnv$begindate)
                   .guiEnv$end.date =svalue(.guiEnv$enddate)}
          
          ###Popup to tell user to wait for data import
          popwin <- gwindow()
          glabel("PLEASE WAIT, DATA IMPORT IN PROGRESS",container = popwin)
          
            ###Run the NWIS puller function to get data out of NWIS internal
          .guiEnv$qw.data <-NWISPullR(DSN = svalue(.guiEnv$dlserver.name),
                                      env.db = svalue(.guiEnv$env.db.num),
                                      qa.db = svalue(.guiEnv$qa.db.num),
                                      STAIDS = .guiEnv$STAIDS,
                                      dl.parms = .guiEnv$dl.parms,
                                      parm.group.check = .guiEnv$parm.group.check,
                                      begin.date = as.POSIXct(svalue(.guiEnv$begindate)),
                                     end.date = as.POSIXct(svalue(.guiEnv$enddate)))
          ###close popup
          dispose(popwin)
          
          ###Grab svalue of chargebalanceb efore close
          .guiEnv$do.calc.balance <- svalue(.guiEnv$calc.balance)
          delete(.guiEnv$w,.guiEnv$nb)
          rm("nb",envir=.guiEnv)
          
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
          ###UPLOAD TAB
          ###################
         NWISuploadR_gui()
          #####Load up plotting gui tabs  
                  
          itsplot_gui()
          iseasonalbox_gui()
          iparmbox_gui()
          iparmplot_gui()
          matrixplot_gui()
            ###Check for ion balanace and run funciton
            if(svalue(.guiEnv$calc.balance) == TRUE){
              
              ###Popup to tell user to wait for charge balance
              popwin <- gwindow()
              glabel("PLEASE WAIT, CALCULATING CHARGE BALANCE",container = popwin)
              
              ###Run ion balance function
              .guiEnv$chargebalance.table <- ionbalance(qw.data = .guiEnv$qw.data)
              ###Join charge balance table to plot table
              .guiEnv$qw.data$PlotTable <- join(.guiEnv$qw.data$PlotTable,.guiEnv$chargebalance.table[!duplicated(.guiEnv$chargebalance.table$RECORD_NO), ],by="RECORD_NO")
              ####Dcast the charge balance table and make a balance data table
              .guiEnv$qw.data$BalanceDataTable <- dcast(.guiEnv$chargebalance.table, RECORD_NO + sum_cat + sum_an +perc.diff + complete.chem ~ Element,value.var = "charge")
              ####Add in site meta data
              .guiEnv$qw.data$BalanceDataTable <- join(.guiEnv$qw.data$DataTable[c("SITE_NO","STATION_NM","SAMPLE_START_DT","SAMPLE_END_DT","MEDIUM_CD","RECORD_NO")],.guiEnv$qw.data$BalanceDataTable,by="RECORD_NO")
            
              dispose(popwin)
            
            icbplot_gui()
            iscsumplot_gui()
            icbparmplot_gui()
            
            }

          })
###################
###Site info pane
###################
.guiEnv$datatabA <- gframe("Site info",container=.guiEnv$datatab, horizontal = FALSE,expand=TRUE) 

###A radio button for selecting the type of site input, this will show or hide the pains depending on selection
.guiEnv$siteid.method <- gradio(container =.guiEnv$datatabA, c("Single site ID",
                                               "Favorite site list",
                                               "Site IDs from file"),
                        selected = 1, horizontal = FALSE,index=TRUE,
                        handler = function(h,...) {
                          if(svalue(.guiEnv$siteid.method, index=TRUE) == 1) {
                            visible(.guiEnv$num.frame) <- TRUE
                            visible(.guiEnv$fsite.frame) <- FALSE
                            visible(.guiEnv$IDfile.frame) <- FALSE
                          } else if (svalue(.guiEnv$siteid.method,index=TRUE) == 2 ){
                            visible(.guiEnv$num.frame) <- FALSE
                            visible(.guiEnv$fsite.frame) <- TRUE
                            visible(.guiEnv$IDfile.frame) <- FALSE
                          } else if (svalue(.guiEnv$siteid.method,index=TRUE) == 3 ){
                            visible(.guiEnv$num.frame) <- FALSE
                            visible(.guiEnv$fsite.frame) <- FALSE
                            visible(.guiEnv$IDfile.frame) <- TRUE
                          }
                          
                        })

###Input for 1 site
.guiEnv$num.frame <- gframe("Single site input",container=.guiEnv$datatabA, horizontal = FALSE,expand=FALSE)
glabel("Site number",container = .guiEnv$num.frame)
.guiEnv$sitenumber <- gedit(container = .guiEnv$num.frame) 

###Input for multiple sites using an editable "favorites" table

.guiEnv$fsite.frame <- gframe("Favorite sites",container=.guiEnv$datatabA, horizontal = FALSE,expand=TRUE,multiple=TRUE)

###Fav sites gtable, this uses input from a csv file containing site ids (pcodes) to populate the table. 
###When "saving preferences"save preferences", the favsites gtable will need to be written to a csv file that is then loaded up when "open preferences" is used

###Button for editing favorites  table
gbutton("Edit favorites",horizontal = FALSE,container=.guiEnv$fsite.frame, 
        handler =  function(h,...) {
          .guiEnv$popwin <- gwindow("Edit favorites")
          .guiEnv$edit.sites <- gdf(container = .guiEnv$popwin, items=.guiEnv$siteIDs,expand=TRUE) ###gdf editor for pcodes table object. This must be 
          gbutton("Update table",horizontal = FALSE,container=.guiEnv$popwin, 
                  handler =  function(h,...) {
                    delete(.guiEnv$fsite.frame,.guiEnv$favsites)
                    .guiEnv$siteIDs <- as.character(.guiEnv$edit.sites[,1])
                    .guiEnv$favsites <- gtable(items = .guiEnv$siteIDs,multiple=TRUE,container = .guiEnv$fsite.frame, expand = TRUE, fill = TRUE)
                    dispose(.guiEnv$popwin) 
                  }
          )
        }
)

###The favorites gtable
.guiEnv$favsites <- gtable(items = .guiEnv$siteIDs,multiple=TRUE,container = .guiEnv$fsite.frame, expand = TRUE, fill = TRUE)

###Input for multiple sites from a CSV file

.guiEnv$IDfile.frame <- gframe("Site IDs from file",container=.guiEnv$datatabA, horizontal = FALSE,expand=FALSE)
glabel("Site ID file",container = .guiEnv$IDfile.frame)
.guiEnv$ID.file <- gfilebrowse(container = .guiEnv$IDfile.frame,text = "Select site ID file...",quote = FALSE)



###Set initial frame visbibilty to NWIS QWSample, hide others
visible(.guiEnv$num.frame) <- TRUE
visible(.guiEnv$fsite.frame) <- FALSE
visible(.guiEnv$IDfile.frame) <- FALSE




########################
###Parameters pane
########################

.guiEnv$datatabB <- gframe("Parameter info",container=.guiEnv$datatab, horizontal = FALSE,expand=TRUE) 

.guiEnv$pcode.method <- gradio(container =.guiEnv$datatabB, c("NWIS parameter groups",
                                               "Favorite pcode list",
                                               "pcodes from file"),
                        selected = 1, horizontal = FALSE,index=TRUE,
                        handler = function(h,...) {
                          if(svalue(.guiEnv$pcode.method, index=TRUE) == 1) {
                            visible(.guiEnv$parm.group.frame) <- TRUE
                            visible(.guiEnv$fpcode.frame) <- FALSE
                            visible(.guiEnv$pfile.frame) <- FALSE
                          } else if (svalue(.guiEnv$pcode.method,index=TRUE) == 2 ){
                            visible(.guiEnv$parm.group.frame) <- FALSE
                            visible(.guiEnv$fpcode.frame) <- TRUE
                            visible(.guiEnv$pfile.frame) <- FALSE
                          } else if (svalue(.guiEnv$pcode.method,index=TRUE) == 3 ){
                            visible(.guiEnv$parm.group.frame) <- FALSE
                            visible(.guiEnv$fpcode.frame) <- FALSE
                            visible(.guiEnv$pfile.frame) <- TRUE
                          }
                          
                        })


###Select paramaters by NWIS pcode group
.guiEnv$parm.group.frame <- gframe("NWIS parameter groups",container=.guiEnv$datatabB, horizontal = FALSE,expand=FALSE)
glabel("Parameter groups",container = .guiEnv$parm.group.frame )

###Engish parameter groups, indexed so do not change order
.guiEnv$parm.group <- gcombobox(c("All" , "physical", "cations", "anions", "nutrients",
                     "microbiological", "biological", "metals", "nonmetals", "pesticides",
                     "pcbs" ,"other organics" ,"radio chemicals", "stable isotopes", "sediment",
                     "population/community"), container=.guiEnv$parm.group.frame)

###NWIS Parameter group codes, these are indexed the same as above so do not change order
.guiEnv$nwis.parm.groups <- c("INF", "PHY", "INM", "INN", "NUT", "MBI", "BIO", "IMM", "IMN", "TOX",
  "OPE", "OPC", "OOT", "RAD", "XXX", "SED", "POP")

###Input for multiple pcodes using an editable "favorites" table

.guiEnv$fpcode.frame <- gframe("Favorite pcodes",container=.guiEnv$datatabB, horizontal = FALSE,expand=TRUE)

###Fav pcodes gtable, this uses input from a csv file containing site ids (pcodes) to populate the table. 
###When "saving preferences"save preferences", the favpcodes gtable will need to be written to a csv file that is then loaded up when "open preferences" is used

###Button for editing favorites  table
gbutton("Edit favorites",horizontal = FALSE,container=.guiEnv$fpcode.frame, 
        handler =  function(h,...) {
          .guiEnv$popwin <- gwindow("Edit favorites")
          .guiEnv$edit.pcodes <- gdf(container = .guiEnv$popwin, items=.guiEnv$pcodes,expand=TRUE) ###gdf editor for pcodes table object. This must be 
          gbutton("Update table",horizontal = FALSE,container=.guiEnv$popwin, 
                  handler =  function(h,...) {
                    delete(.guiEnv$fpcode.frame,favpcodes)
                    .guiEnv$pcodes <- as.character(.guiEnv$edit.pcodes[,1])
                    .guiEnv$favpcodes <- gtable(items = .guiEnv$pcodes,multiple=TRUE,container = fpcode.frame, expand = TRUE, fill = TRUE)
                    dispose(.guiEnv$popwin) 
                  }
          )
        }
)

###The favorites gtable
.guiEnv$favpcodes <- gtable(items = .guiEnv$pcodes,multiple=TRUE,container = .guiEnv$fpcode.frame, expand = TRUE, fill = TRUE)


###Read in pcodes from a file
.guiEnv$pfile.frame <- gframe("Read pcodes from file",container=.guiEnv$datatabB, horizontal = FALSE,expand=FALSE)
glabel("parameter code file",container = .guiEnv$pfile.frame )
.guiEnv$parmfile <- gfilebrowse(container = .guiEnv$pfile.frame,text = "Select pcode file...",quote = FALSE)



###Set initial frame visbibilty to NWIS QWSample, hide others
visible(.guiEnv$parm.group.frame) <- TRUE
visible(.guiEnv$pfile.frame) <- FALSE
visible(.guiEnv$fpcode.frame) <- FALSE


########################
###Non-NWIS data import, not included in version 1.0
########################

#datatabC <- gframe("Non-NWIS data import",container=datatab, horizontal = FALSE,expand=TRUE)  
#glabel("Import non-NWIS data file \n see documentation for file format",container = datatabC)
#nonnwisfile <- gedit(container = datatabC,initial.msg = "filename including csv extension")
#gbutton(text="Import non-NWIS data", container=datatabC)

}
