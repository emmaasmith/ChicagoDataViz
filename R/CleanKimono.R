data = read.csv("Data/GeneralMayorResults.csv", header=F, stringsAsFactors=F)
data = data[-c(1,3),]
data = data[,c(7, 8, 1, 2, 5, 6, 3, 4, 9:12)]
names(data) = as.character(unlist(data[1,]))
names(data)[names(data)=="Votes Cast"] <- "Votes_Cast"
data = data[grep("[0-9]+", data$Votes_Cast),]
data$Ward = 0
ward.num = 0
ward.fn = function(row.num){
  prec.num = as.numeric(data[row.num, "Pct"])
  if(prec.num == 1){
    ward.num <<- ward.num + 1
  }
  data[row.num, "Ward"] = ward.num 
}
data$Ward = sapply(1:2069, function(v) {ward.fn(v)})
data$WP = sapply(1:2069, function(v) {paste(data[v,"Ward"], "_", data[v,"Pct"], sep="")})

data2 = read.csv("Data/GeneralRegisteredVoters.csv", header=F, stringsAsFactors=F)
names(data2) = as.character(unlist(data2[2,]))
data2 = data2[-c(1:3),]
data2 = data2[grep("[0-9]+", data2$Pct),]
data$RegVot = data2$Voters


data4 = read.csv("Data/RunoffResults.csv", header=F, stringsAsFactors=F)
data4 = data4[,c(3:4, 1:2, 5:6)]
names(data4) = c("Pct", "Run_Votes_Cast", "Run_Emanuel", "Run_Emanuel_Pct", "Run_Garcia", "Run_Garcia_Pct")
data4 = data4[-c(1:3),]
data4 = data4[grep("[0-9]+", data4$Pct),]
data$Run_Votes_Cast = data4$Run_Votes_Cast
data$Run_Emanuel = data4$Run_Emanuel
data$Run_Emanuel_Pct = data4$Run_Emanuel_Pct
data$Run_Garcia = data4$Run_Garcia
data$Run_Garcia_Pct = data4$Run_Garcia_Pct

data5 = read.csv("Data/RunoffRegisteredVoters.csv", header=F, stringsAsFactors=F)
names(data5) = c("Pct", "Run_RegVot")
data5 = data5[-c(1:3),]
data5 = data5[grep("[0-9]+", data5$Pct),]
data$Run_RegVot = data5$Run_RegVot


data6 = read.csv("Data/ObamaResults.csv", header=F, stringsAsFactors=F)
data6 = data6[,c(3:4, 1:2, 5:6, 8:10, 7)]
names(data6) = c("Pct", "Ob_Votes_Cast", "Ob_Obama", "Ob_Obama_Pct", "Ob_Romney", "Ob_Romney_Pct", 
                 "Ob_Johnson", "Ob_Johnson_Pct", "Ob_Stein", "Ob_Stein_Pct")
data6 = data6[-c(1:3),]
data6 = data6[grep("[0-9]+", data6$Pct),]
ward.num = 0
ward.fn2 = function(row.num){
  prec.num = as.numeric(data6[row.num, "Pct"])
  if(prec.num == 1){
    ward.num <<- ward.num + 1
  }
  data6[row.num, "Ward"] = ward.num 
}
data6$Ward = sapply(1:2034, function(v) {ward.fn2(v)})
data6$WP = sapply(1:2034, function(v) {paste(data6[v,"Ward"], "_", data6[v,"Pct"], sep="")})

data7 = read.csv("Data/ObamaRegisteredVoters.csv", header=F, stringsAsFactors=F)
names(data7) = c("Pct", "Obama_RegVot")
data7 = data7[-c(1:3),]
data7 = data7[grep("[0-9]+", data7$Pct),]
data6$Obama_RegVot = data7$Obama_RegVot

data8 = read.csv("Data/SchoolPolicy.csv", header=F, stringsAsFactors=F)
names(data8) = c("Pct", "School_Votes", "School_Yes", "School_No")
data8 = data8[,c(1:4)]
data8 = data8[-c(1:2),]
data8 = data8[grep("[0-9]+", data8$Pct),]
data$School_Votes = data8$School_Votes
data$School_Yes = data8$School_Yes
data$School_No = data8$School_No

data9 = read.csv("Data/GovernorResults.csv", header=F, stringsAsFactors=F)
names(data9) = c("Pct", "Governor_Votes", "Quinn", "Rauner", "Grimm")
data9 = data9[,c(1:5)]
data9 = data9[grep("[0-9]+", data9$Pct),]
data$Governor_Votes = data9$Governor_Votes
data$Quinn = data9$Quinn
data$Rauner = data9$Rauner
data$Grimm = data9$Grimm








fulldata = merge(data, data6, by.x="WP", by.y="WP", all.x=T)
fulldata = fulldata[,c(1, 14, 2:13, 15:28, 30:38, 40)]
colnames(fulldata)[2] = "Ward"
colnames(fulldata)[3] = "Pct"






write.csv(fulldata, "RoughData/FullOldElections.csv")















