icbsumplot <- function(icbsum.site.selection,
                       icbsum.plotparm
                       ) {
  
  ## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  medium.colors <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#D55E00")
  names(medium.colors) <- c("WS ","WG ","WSQ","WGQ","OAQ")
  
  ## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  qual.shapes <- c(19,0,2,5)
  names(qual.shapes) <- c("Complete","Incomplete")
  
  ##Sets up hline for +/- 5 andd 10 percent
  hline <- data.frame(yint=c(-5,5,-10,10),Imbalance=c("+/- 5%","+/- 5%","+/- 10%","+/- 10%"))
  
  if((icbsum.plotparm) == "sum cations"){
    if(length(icbsum.site.selection) == 1)
    {
      maintitle <- str_wrap(unique(qw.data$PlotTable$STATION_NM[which(qw.data$PlotTable$SITE_NO == (icbsum.site.selection))]), width = 25)
    } else (maintitle <- "Multisite chargebalance plot")
    ylabel <- "Charge balance Percent difference\n( [sum(cat)-sum(an)]/[tot. charge] * 100 )"
    p1 <- ggplot(data=subset(qw.data$PlotTable,SITE_NO %in% (icbsum.site.selection) & !duplicated(RECORD_NO) == TRUE ),aes(x=sum_cat,y=perc.diff,shape = complete.chem, color = MEDIUM_CD))
    p1 <- p1 + geom_point(size=3)
    p1 <- p1 + ylab(paste(ylabel,"\n")) + xlab("sum of cations (milliequivalents)")
    p1 <- p1 + scale_y_continuous(limits=c(-100,100))
    p1 <- p1 + scale_colour_manual("Medium code",values = medium.colors)
    p1 <- p1 + scale_shape_manual("Chemistry status",values = qual.shapes)
    p1 <- p1 + geom_text(aes(label=ifelse(RESULT_MD >= (Sys.time()-new.threshold),"New",""),hjust=1.1),show_guide=F)      
    p1 <- p1 + theme_USGS() + ggtitle(maintitle)
    p1 <- p1 + geom_hline(data = hline,aes(yintercept = yint,linetype=Imbalance),show_guide=TRUE) 
    
    print(p1)
  } else if ((icbsum.plotparm) == "sum anions") {
    if(length(icbsum.site.selection) == 1)
    {
      maintitle <- str_wrap(unique(qw.data$PlotTable$STATION_NM[which(qw.data$PlotTable$SITE_NO == (icbsum.site.selection))]), width = 25)
    } else (maintitle <- "Multisite chargebalance plot")
    ylabel <- "Charge balance Percent difference\n( [sum(cat)-sum(an)]/[tot. charge] * 100 )"
    p1 <- ggplot(data=subset(qw.data$PlotTable,SITE_NO %in% (icbsum.site.selection) & !duplicated(RECORD_NO) == TRUE ),aes(x=sum_an,y=perc.diff,shape = complete.chem, color = MEDIUM_CD))
    p1 <- p1 + geom_point(size=3)
    p1 <- p1 + ylab(paste(ylabel,"\n")) + xlab("sum of anions (milliequivalents)")
    p1 <- p1 + scale_y_continuous(limits=c(-100,100))
    p1 <- p1 + scale_colour_manual("Medium code",values = medium.colors)
    p1 <- p1 + scale_shape_manual("Chemistry status",values = qual.shapes)
    p1 <- p1 + geom_text(aes(label=ifelse(RESULT_MD >= (Sys.time()-new.threshold),"New",""),hjust=1.1),show_guide=F)      
    p1 <- p1 + theme_USGS() + ggtitle(maintitle)
    p1 <- p1 + geom_hline(data = hline,aes(yintercept = yint,linetype=Imbalance),show_guide=TRUE) 
    
    print(p1)
  }
}