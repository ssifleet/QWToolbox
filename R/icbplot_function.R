icbplot <- function(qw.data,
                    new.threshold,
                    icb.site.selection,
                    icb.begin.date.slider,
                    icb.end.date.slider,
                    icb.show.smooth){
  ## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  medium.colors <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#D55E00")
  names(medium.colors) <- c("WS ","WG ","WSQ","WGQ","OAQ")
  
  ## Sets shape to qualifier code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  qual.shapes <- c(19,0,2,5)
  names(qual.shapes) <- c("Complete","Incomplete")
  
  ###setup the hline from charge balance
  hline <- data.frame(yint=c(-5,5,-10,10),Imbalance=c("+/- 5%","+/- 5%","+/- 10%","+/- 10%"))
  if (length(icb.site.selection) == 1)
  {
    maintitle <- str_wrap(unique(qw.data$PlotTable$STATION_NM[which(qw.data$PlotTable$SITE_NO == (icb.site.selection))]), width = 25)
  } else (maintitle <- "Multisite chargebalance plot")
  
  ylabel <- "Charge balance Percent difference\n( [sum(cat)-sum(an)]/[tot. charge] * 100 )"
  p1 <- ggplot(data=subset(qw.data$PlotTable,SITE_NO %in% (icb.site.selection) & !duplicated(RECORD_NO) == TRUE ),aes(x=SAMPLE_START_DT,y=perc.diff,shape = complete.chem, color = MEDIUM_CD))
  p1 <- p1 + geom_point(size=3)
  p1 <- p1 + ylab(paste(ylabel,"\n")) + xlab("Date")
  p1 <- p1 + scale_colour_manual("Medium code",values = medium.colors)
  p1 <- p1 + scale_shape_manual("Chemistry status",values = qual.shapes)
  p1 <- p1 + scale_x_datetime(limits=c(as.POSIXct((icb.begin.date.slider)),as.POSIXct((icb.end.date.slider))))
  
  if(nrow(subset(qw.data$PlotTable,SITE_NO %in% icb.site.selection & !duplicated(RECORD_NO) == TRUE & RESULT_MD >= (Sys.time()-new.threshold))) > 0)
  {
    p1 <- p1 + geom_text(data=subset(qw.data$PlotTable,SITE_NO == icb.site.selection & 
                                       !duplicated(RECORD_NO) == TRUE &
                                       RESULT_MD >= (Sys.time()-new.threshold)),
                         aes(x=SAMPLE_START_DT,y=perc.diff,color = MEDIUM_CD,label="New",hjust=1.1),show_guide=F)      
  }else{}
  
  p1 <- p1 + theme_USGS() + theme(axis.text.x = element_text(angle = 90)) + ggtitle(maintitle)
  p1 <- p1 + geom_hline(data = hline,aes(yintercept = yint,linetype=Imbalance),show_guide=TRUE) 
  
  if((icb.show.smooth)==TRUE){
    p2 <- p1 + geom_smooth(data=subset(qw.data$PlotTable,SITE_NO %in% (icb.site.selection) & !duplicated(RECORD_NO) == TRUE  & MEDIUM_CD == c("WS ","WG ")))
    print(p2)
  } else{print(p1)}
}