saveplot <- function(...)
{
  ###Popup window
  saveGroup <- ggroup(container=gwindow(),horizontal=FALSE)
  ###User help
  ###Filename input
  iplot.filename <- gfilebrowse(container = saveGroup,text = "Select site ID file...",quote = FALSE)
  glabel(text="Filetype will be determined from extension.\n .pdf=pdf .svg=svg .jpeg=jpeg .png=png\n.bmp=bmp .svg=svg",container=saveGroup)
  
  ###Save or cancel buttons
  gbutton(text="Save",container = saveGroup,handler = function(h,...) {
    ggsave(filename=svalue(iplot.filename))
    dispose(saveGroup)
  })
  gbutton(text="Close",container = saveGroup,handler = function(h,...) {
    dispose(saveGroup)
  }) 
}