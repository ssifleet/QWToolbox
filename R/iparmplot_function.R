iparmplot <- function(qw.data,
                      new.threshold,
                      iparm.site.selection,
                      iparm.xparm,
                      iparm.yparm,
                      iparm.show.lm){
  
  lm_eqn = function(df){
    m = lm(RESULT_VA_Y ~ RESULT_VA_X, df);
    eq <- paste("y =",format(coef(m)[2], digits = 2),"x +",format(coef(m)[1], digits = 2),"\nr-squared =",format(summary(m)$r.squared, digits = 3))
    
  }
  
  ## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  medium.colors <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#D55E00")
  names(medium.colors) <- c("WS ","WG ","WSQ","WGQ","OAQ")
  if (length(iparm.site.selection) == 1)
  {
  maintitle <- str_wrap(unique(qw.data$PlotTable$STATION_NM[which(qw.data$PlotTable$SITE_NO == (iparm.site.selection))]), width = 25)
  } else (maintitle <- "Multisite plot")
  ###Get X and Y labels from NWIS parm name
  xlabel <- str_wrap(unique(qw.data$PlotTable$PARM_DS[which(qw.data$PlotTable$PARM_CD==(iparm.xparm))]), width = 25)
  ylabel <- str_wrap(unique(qw.data$PlotTable$PARM_DS[which(qw.data$PlotTable$PARM_CD==(iparm.yparm))]), width = 25)
  ###Subset data to parms and join by record number
  ###This is very ugly but I don't know a way to pair up the x-y data in a melted dataframe
  ###Subsetting by parm code does not work because you need the parmcodes matched up for the same record
  
  xpp.plot.data <- subset(qw.data$PlotTable,SITE_NO %in% (iparm.site.selection) & PARM_CD==(iparm.xparm))
  ypp.plot.data <- subset(qw.data$PlotTable,SITE_NO %in% (iparm.site.selection) & PARM_CD==(iparm.yparm))
  
  ###Assigned to global environment to make it work with ggplot2, I don't like doing this since it is not a persistant variable
  ###but this is hte fastest fix for now
  pp.plot.data <- join(xpp.plot.data[c("RECORD_NO","MEDIUM_CD","RESULT_VA","RESULT_MD")], ypp.plot.data[c("RECORD_NO","MEDIUM_CD","RESULT_VA","RESULT_MD")],by="RECORD_NO")
  names(pp.plot.data) <- c("RECORD_NO","MEDIUM_CD","RESULT_VA_X","RESULT_MD_X","MEDIUM_CD","RESULT_VA_Y","RESULT_MD_Y")
  remove(xpp.plot.data)
  remove(ypp.plot.data)
  
  ###Make the plot
  p1 <- ggplot(data=pp.plot.data,aes(x=RESULT_VA_X,y=RESULT_VA_Y,color = MEDIUM_CD))
  p1 <- p1 + geom_point(size=3)
  p1 <- p1 + ylab(paste(ylabel,"\n")) + xlab(paste("\n",xlabel))
  p1 <- p1 + scale_colour_manual("Medium code",values = medium.colors)

  ##Check for new samples and label them. Tried ifelse statement for hte label but it did no recognize new.threshol as a variable for some reason
  if(nrow(subset(pp.plot.data, RESULT_MD_X >= (Sys.time()-new.threshold) | RESULT_MD_Y >= (Sys.time()-new.threshold))) > 0)
  {
    p1 <- p1 + geom_text(data=subset(pp.plot.data, RESULT_MD_X >= (Sys.time()-new.threshold) | RESULT_MD_Y >= (Sys.time()-new.threshold)),
                         aes(x=RESULT_VA_X,y=RESULT_VA_Y,color = MEDIUM_CD,label="New",hjust=1.1),show_guide=F)      
  }else{}
  
  p1 <- p1 + theme_USGS() + ggtitle(maintitle)
  
  
  
  if((iparm.show.lm)==TRUE){
    p2 <- p1 + geom_smooth(data=subset(pp.plot.data, MEDIUM_CD %in%c("WS ","WG ")),method="lm",formula=y~x)
    p2 <- p2 + xlab(paste("\n",xlabel,"\n",lm_eqn(subset(pp.plot.data, MEDIUM_CD %in%c("WS ","WG ")))))
    print(p2)
  } else{print(p1)}  
}