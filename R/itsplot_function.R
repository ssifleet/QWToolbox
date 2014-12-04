

itsplot <- function(its.site.selection,
                    its.plotparm,
                    its.begin.date.slider,
                    its.end.date.slider,
                    its.show.q,
                    its.show.smooth){
  ## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  medium.colors <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#D55E00")
  names(medium.colors) <- c("WS ","WG ","WSQ","WGQ","OAQ")
  ## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  qual.shapes <- c(19,0,2,5)
  names(qual.shapes) <- c("Sample","<",">","E")
  
  maintitle <- str_wrap(unique(qw.data$PlotTable$STATION_NM[which(qw.data$PlotTable$SITE_NO == (its.site.selection))]), width = 25)
  ylabel <- str_wrap(unique(qw.data$PlotTable$PARM_DS[which(qw.data$PlotTable$PARM_CD==(its.plotparm))]), width = 25)
  p1 <- ggplot(data=subset(qw.data$PlotTable,SITE_NO == (its.site.selection) & PARM_CD==(its.plotparm)),aes(x=SAMPLE_START_DT,y=RESULT_VA,shape = REMARK_CD, color = MEDIUM_CD))
  p1 <- p1 + geom_point(size=3)
  p1 <- p1 + ylab(paste(ylabel,"\n")) + xlab("Date")
  p1 <- p1 + scale_colour_manual("Medium code",values = medium.colors)
  p1 <- p1 + scale_shape_manual("Qualifier code",values = qual.shapes)
  p1 <- p1 + scale_x_datetime(limits=c(as.POSIXct((its.begin.date.slider)),as.POSIXct((its.end.date.slider))))
  p1 <- p1 + geom_text(aes(label=ifelse(RESULT_MD >= (Sys.time()-new.threshold),"New",""),hjust=1.1),show_guide=F)      
  p1 <- p1 + theme_USGS() + theme(axis.text.x = element_text(angle = 90)) + ggtitle(maintitle)
  if((its.show.smooth)==TRUE){
    p2 <- p1 + geom_smooth(data = subset(qw.data$PlotTable,SITE_NO == (its.site.selection) & PARM_CD==(its.plotparm) & REMARK_CD=="Sample" & MEDIUM_CD %in%(c("WS ","WG "))))
  } 
  if((its.show.q)==TRUE){ 
    p3ylabel <- str_wrap(unique(qw.data$PlotTable$PARM_DS[which(qw.data$PlotTable$PARM_CD=="00061")]), width = 25)
    p3 <- ggplot(data=subset(qw.data$PlotTable,SITE_NO == (its.site.selection) & PARM_CD=="00061" & MEDIUM_CD == "WS " & REMARK_CD == "Sample"),aes(x=SAMPLE_START_DT,y=RESULT_VA,shape = REMARK_CD, color = MEDIUM_CD))
    p3 <- p3 + geom_point(size=1) + geom_line()
    p3 <- p3 + ylab(paste(p3ylabel,"\n")) 
    p3 <- p3 + scale_colour_manual("Medium code",values = medium.colors)
    p3 <- p3 + scale_shape_manual("Qualifier code",values = qual.shapes)
    p3 <- p3 + scale_x_datetime(limits=c(as.POSIXct((its.begin.date.slider)),as.POSIXct((its.end.date.slider))))
    p3 <- p3 + theme_USGS() + theme(axis.text.x = element_text(angle = 90)) + ggtitle(maintitle)
    p3 <- p3 + theme(axis.text.x=element_blank(),
                     axis.title.x=element_blank(),
                     axis.ticks.x=element_blank(),
                     plot.margin = unit(c(1,0.5,-1,0.5), "lines"))
    if((its.show.smooth)==TRUE){
      p4 <- p1 + theme(plot.title=element_blank(),plot.margin = unit(c(-1,0.5,1,0.5), "lines")) + 
        geom_smooth(data = subset(qw.data$PlotTable,SITE_NO == (its.site.selection) & PARM_CD==(its.plotparm) & REMARK_CD=="Sample" & MEDIUM_CD %in%(c("WS ","WG "))))
    } else{p4 <- p1 + theme(plot.title=element_blank(), plot.margin = unit(c(-1,0.5,1,0.5),"lines"))}
    
    gp1<- ggplot_gtable(ggplot_build(p4))
    gp3<- ggplot_gtable(ggplot_build(p3))
    maxWidth = unit.pmax(gp1$widths[2:3], gp3$widths[2:3])
    gp1$widths[2:3] <- maxWidth
    gp3$widths[2:3] <- maxWidth
    grid.arrange(gp3, gp1)
  }
  if ((its.show.q)==FALSE && (its.show.smooth) == FALSE){
    print(p1) 
  }
  if ((its.show.q)==FALSE && (its.show.smooth) == TRUE){
    print(p2) 
  }


}