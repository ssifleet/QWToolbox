NWISuploadR_gui <- function(...)
{

##################
####Upload Tab
##################

##############################
###Setup the main window frame
##############################
.guiEnv$tab4 <- gframe(container=.guiEnv$nb, label = "Non-NWQL data upload",index=4)
.guiEnv$tab4A <- gframe("Batch file generator",container=.guiEnv$tab4, horizontal = FALSE,expand=TRUE)

###User inputs for data files and output filenames
glabel("Data filename",container = .guiEnv$tab4A)
.guiEnv$lab.file <- gfilebrowse(container = .guiEnv$tab4A,text = "Select lab data file...",quote = FALSE)


glabel("pcode filename",container = .guiEnv$tab4A)
.guiEnv$pcode.file <- gfilebrowse(container = .guiEnv$tab4A,text = "Select pcode data file...",quote = FALSE)

glabel("QWresult filename",container = .guiEnv$tab4A)
.guiEnv$qwresult.name <- gfilebrowse(container = .guiEnv$tab4A,text = "QWresult filename...",quote = FALSE)
svalue(.guiEnv$qwresult.name) <- "qwresult"

glabel("QWsample filename",container = .guiEnv$tab4A)
.guiEnv$qwsample.name <- gfilebrowse(container = .guiEnv$tab4A,text = "QWsample filename...",quote = FALSE)
svalue(.guiEnv$qwsample.name) <- "qwsample"

###Checkbox for weahter or not to censor the data
.guiEnv$do.censor <- gcheckbox("Check to censor data to reporting limit",checked=TRUE,container = .guiEnv$tab4A)

#############################
###Setup qwsample type frames
#############################

###QWSample from NWIS
.guiEnv$nwis.qwsample.frame <- gframe(container=.guiEnv$tab4,horizontal=FALSE,use.scrollwindow = FALSE, expand=TRUE)
.guiEnv$nwis.qwsample <- ggroup(container=.guiEnv$nwis.qwsample.frame,horizontal=FALSE,use.scrollwindow = TRUE, expand=TRUE)

###QWSample from file
.guiEnv$file.qwsample.frame <- gframe(container=.guiEnv$tab4,horizontal=FALSE,use.scrollwindow = FALSE, expand=TRUE)
.guiEnv$file.qwsample <- ggroup(container=.guiEnv$file.qwsample.frame,horizontal=FALSE,use.scrollwindow = TRUE, expand=TRUE)

###Manual QWSample generator
.guiEnv$man.qwsample.frame <- gframe(container=.guiEnv$tab4,horizontal=FALSE,use.scrollwindow = FALSE, expand=TRUE)
.guiEnv$man.qwsample <- ggroup(container=.guiEnv$man.qwsample.frame,horizontal=FALSE,use.scrollwindow = TRUE, expand=TRUE)

###Set initial frame visbibilty to NWIS QWSample, hide others
visible(.guiEnv$nwis.qwsample) <- TRUE
visible(.guiEnv$file.qwsample) <- FALSE
visible(.guiEnv$man.qwsample.frame) <- FALSE

###A radio button for selecting the type of QWSample file, this will show or hide the pains depending on selection
.guiEnv$qwsample.method <- gradio(container =.guiEnv$tab4A, c("Generate QWsample from NWIS (logged in samples only)",
                            "Generate QWSample from file",
                            "Generate QWsample manually"),
                          selected = 1, horizontal = FALSE,index=TRUE,
                          handler = function(h,...) {
                            if(svalue(.guiEnv$qwsample.method, index=TRUE) == 1) {
                              visible(.guiEnv$nwis.qwsample) <- TRUE
                              visible(.guiEnv$file.qwsample) <- FALSE
                              visible(.guiEnv$man.qwsample.frame) <- FALSE
                              } else if (svalue(.guiEnv$qwsample.method,index=TRUE) == 2 ){
                                visible(.guiEnv$nwis.qwsample) <- FALSE
                                visible(.guiEnv$file.qwsample) <- TRUE
                                visible(.guiEnv$man.qwsample.frame) <- FALSE
                              }else if (svalue(.guiEnv$qwsample.method,index=TRUE) == 3 ){
                                visible(.guiEnv$nwis.qwsample) <- FALSE
                                visible(.guiEnv$file.qwsample) <- FALSE
                                visible(.guiEnv$man.qwsample.frame) <- TRUE
                              }
                          })


########################################################################################
###All the inputs for the NWIS qw sample generator
############################################################################

glabel("Only for adding data\n to existing samples",container = .guiEnv$nwis.qwsample)
glabel("Server name (DSN)",container = .guiEnv$nwis.qwsample)
.guiEnv$server <- gedit(container = .guiEnv$nwis.qwsample,initial.msg="e.g. NWISCO")

###Date inputs
glabel("Begin date",container = .guiEnv$nwis.qwsample)
.guiEnv$qwsample.begindate <- gcalendar(text = "yyyy-mm-dd", format = "%Y-%m-%d", handler=NULL, 
                       action=NULL, container = .guiEnv$nwis.qwsample) 
glabel("End date",container = .guiEnv$nwis.qwsample)
.guiEnv$qwsample.enddate <- gcalendar(text = "yyyy-mm-dd", format = "%Y-%m-%d", handler=NULL, 
                     action=NULL, container = .guiEnv$nwis.qwsample)

###Button to execut upload function
.guiEnv$nwis.batchfiles <- gbutton("Generate batch files", container = .guiEnv$nwis.qwsample,
                           handler = function(h,...){
                             #Assign input values
                             
                             if (svalue(.guiEnv$do.censor)){ ###Have to set the censor logical htis way because it does not read it as a logive using svalue method
                               censor <- TRUE
                             } else (.guiEnv$censor <- FALSE)

                             if(!is.na(svalue(.guiEnv$qwsample.begindate)) && !is.na(svalue(.guiEnv$qwsample.enddate))) 
                             {
                               .guiEnv$qwsample.begin.date = as.POSIXct(.guiEnv$svalue(qwsample.begindate))
                               .guiEnv$qwsample.end.date = as.POSIXct(svalue(.guiEnv$qwsample.enddate))
                             } else{.guiEnv$qwsample.begin.date = NA
                                    .guiEnv$qwsample.end.date =NA}
                             ###Execute function
                             nwisupload(qwsampletype = 1, ###This tells hte function which QWSample file to generate, it is different for each qwsample pane
                                        DSN = svalue(.guiEnv$server),
                                        labfile = svalue(.guiEnv$lab.file),
                                        pcodefile = svalue(.guiEnv$pcode.file),
                                        qwsamplefile = svalue(.guiEnv$qwsample.file),
                                        qwresultname = svalue(.guiEnv$qwresult.name),
                                        qwsamplename = svalue(.guiEnv$qwsample.name),
                                        qwsample.begin.date= .guiEnv$qwsample.begin.date,
                                        qwsample.end.date = .guiEnv$qwsample.end.date,
                                        censor = .guiEnv$censor,
                                        agencycode = svalue(.guiEnv$agency.code),
                                        labid = svalue(.guiEnv$lab.id),
                                        projectcode = svalue(.guiEnv$project.code),
                                        aquifercode = svalue(.guiEnv$aquifer.code),
                                        analysisstatus = svalue(.guiEnv$analysis.status),
                                        analysissource = svalue(.guiEnv$analysis.source),
                                        hydrologiccond = svalue(.guiEnv$hydrologic.cond),
                                        hydrologicevent = svalue(.guiEnv$hydrologic.event),
                                        tissue = svalue(.guiEnv$tissue.code),
                                        bodypart = svalue(.guiEnv$body.part),
                                        labcomment = svalue(.guiEnv$lab.comment),    
                                        fieldcomment = svalue(.guiEnv$field.comment),
                                        timedatum = svalue(.guiEnv$time.datum),
                                        datumreliability = svalue(.guiEnv$datum.reliability),
                                        colagencycode = svalue(.guiEnv$colagency.code)) 
                           }
)

#################################################################
###All the inputs for the File qw sample generator
#################################################################

glabel("This tab is for uploading\n data with a user-generated\n qwsample file.\n\n This can be direct output from\n NWIS-QWData or user supplied.\n It must be tab-delimeted\n with no header.\n\nFilename of tab-delimeted\n QWsample file, including\n extenstion if applicable",container = .guiEnv$file.qwsample)
#glabel("filename of tab-delimeted\n QWsample file, including\n extenstion if applicable",container = file.qwsample)
.guiEnv$qwsample.file <- gfilebrowse(container = .guiEnv$file.qwsample,text = "qwsample file...",quote = FALSE)
###Button to execute upload function
.guiEnv$file.batchfiles <- gbutton("Generate batch files", container = .guiEnv$file.qwsample,
                           handler = function(h,...){
                             #Assign input values
                             
                             if (svalue(.guiEnv$do.censor)){ ###Have to set the censor logical htis way because it does not read it as a logive using svalue method
                               .guiEnv$censor <- TRUE
                             } else (.guiEnv$censor <- FALSE)

                             
                             ###Execute function
                             nwisupload(qwsampletype = 2,###This tells hte function which QWSample file to generate, it is different for each qwsample pane
                                        DSN = svalue(.guiEnv$server),
                                        labfile = svalue(.guiEnv$lab.file),
                                        pcodefile = svalue(.guiEnv$pcode.file),
                                        qwsamplefile = svalue(.guiEnv$qwsample.file),
                                        qwresultname = svalue(.guiEnv$qwresult.name),
                                        qwsamplename = svalue(.guiEnv$qwsample.name),
                                        censor = .guiEnv$censor,
                                        agencycode = svalue(.guiEnv$agency.code),
                                        labid = svalue(.guiEnv$lab.id),
                                        projectcode = svalue(.guiEnv$project.code),
                                        aquifercode = svalue(.guiEnv$aquifer.code),
                                        analysisstatus = svalue(.guiEnv$analysis.status),
                                        analysissource = svalue(.guiEnv$analysis.source),
                                        hydrologiccond = svalue(.guiEnv$hydrologic.cond),
                                        hydrologicevent = svalue(.guiEnv$hydrologic.event),
                                        tissue = svalue(.guiEnv$tissue.code),
                                        bodypart = svalue(.guiEnv$body.part),
                                        labcomment = svalue(.guiEnv$lab.comment),    
                                        fieldcomment = svalue(.guiEnv$field.comment),
                                        timedatum = svalue(.guiEnv$time.datum),
                                        datumreliability = svalue(.guiEnv$datum.reliability),
                                        colagencycode = svalue(.guiEnv$colagency.code)) 
                           }
)

#######################################################################################
###All the inputs for the manual qwsample generator
######################################################################################

glabel("Agency code",container = .guiEnv$man.qwsample )
.guiEnv$agency.code <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Labratory ID",container = .guiEnv$man.qwsample )
.guiEnv$lab.id <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Project code",container = .guiEnv$man.qwsample )
.guiEnv$project.code <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Aquifer code",container = .guiEnv$man.qwsample )
.guiEnv$aquifer.code <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Analysis status",container = .guiEnv$man.qwsample )
.guiEnv$analysis.status <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Analysis source",container = .guiEnv$man.qwsample )
.guiEnv$analysis.source <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Hydrologic condition",container = .guiEnv$man.qwsample )
.guiEnv$hydrologic.cond <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is A")
svalue(.guiEnv$hydrologic.cond) <- "A"

glabel("Hydrologic event",container = .guiEnv$man.qwsample )
.guiEnv$hydrologic.event <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is 9")
svalue(.guiEnv$hydrologic.event) <- "9"

glabel("Tissue",container = .guiEnv$man.qwsample )
.guiEnv$tissue.code <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Body part",container = .guiEnv$man.qwsample )
.guiEnv$body.part <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Lab comment",container = .guiEnv$man.qwsample )
.guiEnv$lab.comment <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Field comment",container = .guiEnv$man.qwsample )
.guiEnv$field.comment <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Time datum",container = .guiEnv$man.qwsample )
.guiEnv$time.datum <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Datum reliability",container = .guiEnv$man.qwsample )
.guiEnv$datum.reliability <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is blank")

glabel("Collecting agency code",container = .guiEnv$man.qwsample )
.guiEnv$colagency.code <- gedit(container = .guiEnv$man.qwsample,initial.msg="default is USGS")
svalue(.guiEnv$colagency.code) <- "USGS"


.guiEnv$man.batchfiles <- gbutton("Generate batch files", container = .guiEnv$man.qwsample,
                          handler = function(h,...){
                            #Assign input values
                            
                            if (svalue(.guiEnv$do.censor)){ ###Have to set the censor logical htis way because it does not read it as a logive using svalue method
                              .guiEnv$censor <- TRUE
                            } else (.guiEnv$censor <- FALSE)
  
                            ###Execute function
                            nwisupload(qwsampletype = 3,###This tells hte function which QWSample file to generate, it is different for each qwsample pane
                                       DSN = svalue(.guiEnv$server),
                                       labfile = svalue(.guiEnv$lab.file),
                                       pcodefile = svalue(.guiEnv$pcode.file),
                                       qwsamplefile = svalue(.guiEnv$qwsample.file),
                                       qwresultname = svalue(.guiEnv$qwresult.name),
                                       qwsamplename = svalue(.guiEnv$qwsample.name),
                                       censor = .guiEnv$censor,
                                       agencycode = svalue(.guiEnv$agency.code),
                                       labid = svalue(.guiEnv$lab.id),
                                       projectcode = svalue(.guiEnv$project.code),
                                       aquifercode = svalue(.guiEnv$aquifer.code),
                                       analysisstatus = svalue(.guiEnv$analysis.status),
                                       analysissource = svalue(.guiEnv$analysis.source),
                                       hydrologiccond = svalue(.guiEnv$hydrologic.cond),
                                       hydrologicevent = svalue(.guiEnv$hydrologic.event),
                                       tissue = svalue(.guiEnv$tissue.code),
                                       bodypart = svalue(.guiEnv$body.part),
                                       labcomment = svalue(.guiEnv$lab.comment),    
                                       fieldcomment = svalue(.guiEnv$field.comment),
                                       timedatum = svalue(.guiEnv$time.datum),
                                       datumreliability = svalue(.guiEnv$datum.reliability),
                                       colagencycode = svalue(.guiEnv$colagency.code)) 
                          }
)
}