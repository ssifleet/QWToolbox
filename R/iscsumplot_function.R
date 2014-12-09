iscsumplot <- function(qw.data,
                       new.threshold,
                       iscsum.site.selection,
                       iscsum.plotparm
                       ) {
  
  ## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  medium.colors <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#D55E00")
  names(medium.colors) <- c("WS ","WG ","WSQ","WGQ","OAQ")
  
  ## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  qual.shapes <- c(19,0,2,5)
  names(qual.shapes) <- c("Complete","Incomplete")
  
  ##Sets up hline for +/- 5 andd 10 percent
  
    if(length(iscsum.site.selection) == 1)
    {
      maintitle <- str_wrap(unique(qw.data$PlotTable$STATION_NM[which(qw.data$PlotTable$SITE_NO == (iscsum.site.selection))]), width = 25)
    } else (maintitle <- "Multisite chargebalance plot")
    ylabel <- "mEQ/l"
    p1 <- ggplot(subset(plottable,SITE_NO %in% (svalue(.guiEnv$iscsum.site.selection)) & PARM_CD== "00095"))
    p1 <- p1 + geom_point(aes(x=RESULT_VA,y=sum_cat,shape = complete.chem, color = "Cations"),size=3)
    p1 <- p1 + geom_point(aes(x=RESULT_VA,y=sum_an,shape = complete.chem, color = "Anions"),size=3)
    p1 <- p1 + ylab(paste(ylabel,"\n")) + xlab("Specific conducatance")
    p1 <- p1 + labs(color='Sum ions')
    p1 <- p1 + scale_shape_manual("Chemistry status",values = qual.shapes)
    
    if(nrow(subset(qw.data$PlotTable,SITE_NO %in% iscsum.site.selection & PARM_CD== "00095" & RESULT_MD >= (Sys.time()-new.threshold))) > 0)
    {
      p1 <- p1 + geom_text(data=subset(qw.data$PlotTable,SITE_NO %in% iscsum.site.selection & 
                                         PARM_CD== "00095" &
                                         RESULT_MD >= (Sys.time()-new.threshold)),
                           aes(x=sum_cat,y=perc.diff,color = MEDIUM_CD,label="New",hjust=1.1),show_guide=F)      
    }else{}
    
    p1 <- p1 + theme_USGS() + ggtitle(maintitle)
    #p1 <- p1 + geom_hline(data = hline,aes(yintercept = yint,linetype=Imbalance),show_guide=TRUE) 
    
    print(p1)
  
}


#test <- subset(plottable,SITE_NO %in% (svalue(.guiEnv$iscsum.site.selection)) & PARM_CD== "00095")
