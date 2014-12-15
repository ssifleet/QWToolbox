ionbalance <- function(qw.data) {

###QWData ion balance factors and priorities
ion.balance.data <- read.csv("Data/ionbalance.csv",header=TRUE,colClasses=c("character","character","numeric","character"))

###List of unique records
ionbalance.records <- unique(qw.data$PlotTable$RECORD_NO)
chargebalance.table <- data.frame()

###Start loop here to go through records list


#Calculate charges for each element based on QWData priority table
##MAke dataframe


for(i in 1:length(ionbalance.records))
{
  ion.charges <- as.data.frame(c("Ca", "Mg", "Na", "K", "Fe", "Mn", "Cl", "SO4", "F", "Alk_maj","NO2NO3"))
  names(ion.charges) <- "Element"
  ion.charges$Element <- as.character(ion.charges$Element)
  ion.charges$sign <- c("Cat","Cat","Cat","Cat","Cat","Cat","An","An","An","An","An")
  ion.charges$charge <- ""
  
element <- "Ca"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {ion.charges$charge[which(ion.charges$Element == element)] <- 0}




element <- "Mg"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {ion.charges$charge[which(ion.charges$Element == element)] <- 0}


element <- "Na"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {ion.charges$charge[which(ion.charges$Element == element)] <- 0}


element <- "K"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {ion.charges$charge[which(ion.charges$Element == element)] <- 0}


element <- "Fe"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {ion.charges$charge[which(ion.charges$Element == element)] <- 0}


element <- "Mn"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {ion.charges$charge[which(ion.charges$Element == element)] <- 0}

element <- "Cl"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {ion.charges$charge[which(ion.charges$Element == element)] <- 0}


element <- "SO4"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {ion.charges$charge[which(ion.charges$Element == element)] <- 0}


element <- "F"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {ion.charges$charge[which(ion.charges$Element == element)] <- 0}

####Need special calculation for Alkalinity and NO3
####If missing alk valuesm alk can be calculated by HCO3, CO32-, and OH
element <- "Alk_maj"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {
  element <- "HCO3"
  sub.ion.balance.data <- subset(ion.balance.data, Element == element)
  priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]
  
  if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                 qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  
  hco3.charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  hco3.charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  hco3.ion.charge <- hco3.charge.conc*hco3.charge.factor
  } else(hco3.ion.charge <- 0)
  
  element <- "CO3"
  sub.ion.balance.data <- subset(ion.balance.data, Element == element)
  priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]
  if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                 qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
    
    co3.charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                           qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
    co3.charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
    co3.ion.charge <- co3.charge.conc*co3.charge.factor
  } else(co3.ion.charge <- 0)
  
  element <- "OH"
  sub.ion.balance.data <- subset(ion.balance.data, Element == element)
  priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]
  
  if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                 qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
    
    oh.charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                           qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
    oh.charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
    oh.ion.charge <- oh.charge.conc*oh.charge.factor
  } else(oh.ion.charge <- 0)
  
  ion.charges$charge[which(ion.charges$Element == "Alk_maj")] <- hco3.ion.charge + co3.ion.charge + oh.ion.charge
  
}

####Need special calculation for Alkalinity and NO3
####If missing NO3 + NO2 values can be calculated by NO2 and NO3
element <- "NO2NO3"
sub.ion.balance.data <- subset(ion.balance.data, Element == element)
priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]

if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                               qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
  charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                     qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
  charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
  ion.charges$charge[which(ion.charges$Element == element)] <- charge.conc*charge.factor
} else {
  
  element <- "NO2"
  sub.ion.balance.data <- subset(ion.balance.data, Element == element)
  priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]
  
  if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                 qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
    
    no2.charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                            qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
    no2.charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
    no2.ion.charge <- no2.charge.conc*no2.charge.factor
  } else(no2.ion.charge <- 0)
  
  element <- "NO3"
  sub.ion.balance.data <- subset(ion.balance.data, Element == element)
  priority.test<-sub.ion.balance.data$PARM_CD%in%qw.data$PlotTable$PARM_CD[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])]
  
  if (length(qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                 qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]) != 0){
    
    no3.charge.conc <- qw.data$PlotTable$RESULT_VA[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i] & 
                                                           qw.data$PlotTable$PARM_CD==sub.ion.balance.data$PARM_CD[which(priority.test)])]
    no3.charge.factor <- sub.ion.balance.data$factor[which(priority.test)]
    no3.ion.charge <- no3.charge.conc*no3.charge.factor
  } else(no3.ion.charge <- 0)
  
 
  ion.charges$charge[which(ion.charges$Element == "NO2NO3")] <- no2.ion.charge + no3.ion.charge
  
}


ion.charges$sum_cat <- sum(as.numeric(ion.charges$charge[which(ion.charges$sign == "Cat")]))
ion.charges$sum_an <- sum(as.numeric(ion.charges$charge[which(ion.charges$sign == "An")]))
ion.charges$perc.diff <- (ion.charges$sum_cat-ion.charges$sum_an)/(ion.charges$sum_cat+ion.charges$sum_an)*100


ion.charges$RECORD_NO <- unique(qw.data$PlotTable$RECORD_NO[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])])
ion.charges$RECORD_NO <- unique(qw.data$PlotTable$RECORD_NO[which(qw.data$PlotTable$RECORD_NO == ionbalance.records[i])])
if(0 %in% ion.charges$charge[which(ion.charges$Element != "F" &
                                     ion.charges$Element != "Fe"&
                                     ion.charges$Element != "Mn")])
{
ion.charges$complete.chem <- "Incomplete"
} else {ion.charges$complete.chem <- "Complete"}

###Stack it all up to make a long charge balance table

chargebalance.table <- rbind(ion.charges,chargebalance.table)
}
#qw.data$PlotTable <- join(qw.data$PlotTable,chargebalance.table,by="RECORD_NO")
#qw.data$BalanceDataTable <- dcast(chargebalance.table, RECORD_NO + sum_cat + sum_an +perc.diff + complete.chem ~ Element,value.var = "charge")
#qw.data$BalanceDataTable <- join(qw.data$DataTable[c("SITE_NO","STATION_NM","SAMPLE_START_DT","SAMPLE_END_DT","MEDIUM_CD","RECORD_NO")],qw.data$BalanceDataTable,by="RECORD_NO")
return(chargebalance.table)
}