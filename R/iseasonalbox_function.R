iseasonalbox <- function(iseasonalbox.site.selection,
                         iseasonalbox.plotparm,
                         iseasonalbox.show.points,
                         iseasonalbox.log.scale){

medium.colors <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#D55E00")
names(medium.colors) <- c("WS ","WG ","WSQ","WGQ","OAQ")
## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
qual.shapes <- c(19,0,2,5)
names(qual.shapes) <- c("Sample","<",">","E")

if(length(iseasonalbox.site.selection) == 1)
{
  maintitle <- str_wrap(unique(qw.data$PlotTable$STATION_NM[which(qw.data$PlotTable$SITE_NO == (iseasonalbox.site.selection))]), width = 25)
}else (maintitle <- "Multi Site boxplot")
ylabel <- str_wrap(unique(qw.data$PlotTable$PARM_DS[which(qw.data$PlotTable$PARM_CD==(iseasonalbox.plotparm))]), width = 25)
p1 <- ggplot(data=subset(qw.data$PlotTable,SITE_NO %in% (iseasonalbox.site.selection) & PARM_CD==(iseasonalbox.plotparm) & MEDIUM_CD %in%(c("WG ","WS ","OAQ"))),aes(x=SAMPLE_MONTH,y=RESULT_VA, color=MEDIUM_CD))
p1 <- p1 + geom_boxplot()
p1 <- p1 + scale_x_discrete("Month", breaks=levels(qw.data$PlotTable$SAMPLE_MONTH), drop=FALSE)
p1 <- p1 + scale_color_manual("Medium code",values = medium.colors)
p1 <- p1 + scale_shape_manual("Qualifier code",values = qual.shapes)
p1 <- p1 + ylab(paste(ylabel,"\n"))
p1 <- p1 + theme_USGS() + ggtitle(maintitle)
if(iseasonalbox.log.scale == TRUE)
{
  p1 <- p1 + scale_y_log10()
}
if((iseasonalbox.show.points)==TRUE){
  p2 <- p1 + geom_point(aes(color = MEDIUM_CD,shape=REMARK_CD),size=3) + geom_text(aes(label=ifelse(RESULT_MD >= (Sys.time()-new.threshold),"New",""),hjust=1.1),show_guide=F)      
  print(p2)
} else{print(p1)}

}