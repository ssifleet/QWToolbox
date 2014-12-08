iparmbox <- function(qw.data,
                      new.threshold,
                     iparmbox.site.selection,
                         iparmbox.plotparm,
                         iparmbox.show.points,
                     iparmbox.log.scale){
  
  medium.colors <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#D55E00")
  names(medium.colors) <- c("WS ","WG ","WSQ","WGQ","OAQ")
  ## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  qual.shapes <- c(19,0,2,5)
  names(qual.shapes) <- c("Sample","<",">","E")
  if(length(iparmbox.site.selection) == 1)
  {
  maintitle <- str_wrap(unique(qw.data$PlotTable$STATION_NM[which(qw.data$PlotTable$SITE_NO == (iparmbox.site.selection))]), width = 25)
  }else (maintitle <- "Multi Site boxplot")
  ylabel <- "Concentration"
  p1 <- ggplot(data=subset(qw.data$PlotTable,SITE_NO %in% (iparmbox.site.selection) & PARM_CD%in%(iparmbox.plotparm) & MEDIUM_CD %in%(c("WG ","WS ","OAQ"))),aes(x=PARM_NM,y=RESULT_VA, color=MEDIUM_CD))
  p1 <- p1 + geom_boxplot()
  p1 <- p1 + scale_colour_manual("Medium code",values = medium.colors)
  p1 <- p1 + scale_shape_manual("Qualifier code",values = qual.shapes)
  p1 <- p1 + ylab(paste(ylabel,"\n"))
  p1 <- p1 + theme_USGS() + ggtitle(maintitle)
  p1 <- p1 + theme(axis.text.x = element_text(angle = 90))
  p1 <- p1 + scale_x_discrete("Analyte")
  if(iparmbox.log.scale == TRUE)
  {
    p1 <- p1 + scale_y_log10()
  }
  if((iparmbox.show.points)==TRUE){
    p2 <- p1 + geom_point(aes(color = MEDIUM_CD,shape=REMARK_CD),size=3)
    if(nrow(subset(qw.data$PlotTable,SITE_NO %in% (iparmbox.site.selection) & PARM_CD==(iparmbox.plotparm) & MEDIUM_CD %in%(c("WG ","WS ","OAQ")) & RESULT_MD >= (Sys.time()-new.threshold))) > 0)
    {
      p2 <- p2 + geom_text(data=subset(qw.data$PlotTable,SITE_NO %in% (iparmbox.site.selection) & PARM_CD==(iparmbox.plotparm) & MEDIUM_CD %in%(c("WG ","WS ","OAQ")) & RESULT_MD >= (Sys.time()-new.threshold)),
                           aes(x=PARM_NM,y=RESULT_VA,color = MEDIUM_CD,label="New",hjust=1.1),show_guide=F)      
    }else{}
    print(p2)
  } else{print(p1)}
  
}