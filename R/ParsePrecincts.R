prec = read.csv("Data/PRECINCTS_2012.csv")
dem = read.csv("RoughData/Census_by_Precinct_Edited.csv", header=TRUE)
dem2 = read.csv("RoughData/2011_by_Precinct.csv", header=TRUE, stringsAsFactors=FALSE)

full = merge(prec, dem, by.x="FULL_TEXT", by.y="Precinct.Code", all=TRUE, sort=TRUE)
full = full[-length(full$FULL_TEXT),]
full= full[,c(1, 6:18, 20:37)]

names(full) = c("FULL_TEXT", "Ward", "Precinct", "Emanuel_Tot", "Emanuel_Pct", "Wilson_Tot", "Wilson_Pct", "Fioretti_Tot", "Fioretti_Pct", 
                "Garcia_Tot", "Garcia_Pct", "Walls_Tot", "Walls_Pct", "Voting_Tot", "C_White_Tot", "C_White_Pct",
                "C_AA_Tot", "C_AA_Pct", "C_Hispanic_Tot", "C_Hispanic_Pct", "C_Asian_Tot", "C_Asian_Pct", "C_NA_Tot", "C_NA_Pct",
                "C_Hawaiian_Tot", "C_Hawaiian_Pct", "C_Other_Tot", "C_Other_Pct", "C_Multi_Tot", "C_Multi_Pct", "C_Tot", "Maj")


full[,4] = gsub(",", "", full[,4])
full[,5] = gsub("%", "", full[,5])
full[,6] = gsub(",", "", full[,6])
full[,7] = gsub("%", "", full[,7])
full[,8] = gsub(",", "", full[,8])
full[,9] = gsub("%", "", full[,9])
full[,10] = gsub(",", "", full[,10])
full[,11] = gsub("%", "", full[,11])
full[,12] = gsub(",", "", full[,12])
full[,13] = gsub("%", "", full[,13])
full[,14] = gsub(",", "", full[,14])
full[,15] = gsub(",", "", full[,15])
full[,16] = gsub("%", "", full[,16])
full[,17] = gsub(",", "", full[,17])
full[,18] = gsub("%", "", full[,18])
full[,19] = gsub(",", "", full[,19])
full[,20] = gsub("%", "", full[,20])
full[,21] = gsub(",", "", full[,21])
full[,22] = gsub("%", "", full[,22])
full[,23] = gsub(",", "", full[,23])
full[,24] = gsub("%", "", full[,24])
full[,25] = gsub(",", "", full[,25])
full[,26] = gsub("%", "", full[,26])
full[,27] = gsub(",", "", full[,27])
full[,28] = gsub("%", "", full[,28])
full[,29] = gsub(",", "", full[,29])
full[,30] = gsub("%", "", full[,30])
full[,31] = gsub(",", "", full[,31])
full[,30] = gsub("#DIV/0!", "0", full[,30])
full[,28] = gsub("#DIV/0!", "0", full[,28])
full[,26] = gsub("#DIV/0!", "0", full[,26])
full[,24] = gsub("#DIV/0!", "0", full[,24])
full[,22] = gsub("#DIV/0!", "0", full[,22])
full[,20] = gsub("#DIV/0!", "0", full[,20])
full[,18] = gsub("#DIV/0!", "0", full[,18])
full[,16] = gsub("#DIV/0!", "0", full[,16])

create.tots = function(rownum){
  if(is.na(full[rownum, "C_Tot"])){
    full[rownum, "C_White_Tot"] + full[rownum, "C_Hispanic_Tot"] + full[rownum, "C_Asian_Tot"] + full[rownum, "C_NA_Tot"] 
    + full[rownum, "C_Hawaiian_Tot"] + full[rownum, "C_Other_Tot"] + full[rownum, "C_Multi_Tot"] 
  } else{
    full[rownum, "C_Tot"]
  }
}

create.pcts = function(rownum, colnum){
  if(is.na(full[rownum, colnum])){
    full[rownum, colnum-1] / full[rownum, "C_Tot"] 
  } else{
    full[rownum, colnum]
  }
}

#full2 = full

full[,1:(length(full)-1)] = apply(full[,1:(length(full)-1)], 2, function(x) {as.numeric(x)})
full$C_Tot = sapply(1:2069, function(v) {create.tots(v)})
full$C_White_Tot = sapply(1:2069, function(v) {create.pcts(v, 16)})
full$C_AA_Pct = sapply(1:2069, function(v) {create.pcts(v, 18)})
full$C_Hispanic_Pct = sapply(1:2069, function(v) {create.pcts(v, 20)})
full$C_Asian_Pct = sapply(1:2069, function(v) {create.pcts(v, 22)})
full$C_NA_Pct = sapply(1:2069, function(v) {create.pcts(v, 24)})
full$C_Hawaiian_Pct = sapply(1:2069, function(v) {create.pcts(v, 26)})
full$C_Other_Pct = sapply(1:2069, function(v) {create.pcts(v, 28)})
full$C_Multi_Pct = sapply(1:2069, function(v) {create.pcts(v, 30)})


#Data from 2011 vs 2015
full$RoughTurnout = full$Voting_Tot / full$C_Tot


dem2$Other_Tot2011 = 0
dem2[,4] = as.numeric(dem2[,4])
dem2[,6] = as.numeric(dem2[,6])
dem2[,8] = as.numeric(dem2[,8])
dem2[,10] = as.numeric(dem2[,10])
dem2[,12] = as.numeric(dem2[,12])
dem2[,14] = as.numeric(dem2[,14])
dem2$Other_Tot2011 = sapply(1:length(dem2$Ward), function(x) {dem2[x,6] + dem2[x,8] + 
                                                                dem2[x,10] + dem2[x,12] + dem2[x,14]})
dem2 = dem2[c(3:5, 16, 36)]
names(dem2) = c("FULL_TEXT", "Emanuel2011_Tot", "Emanuel2011_Pct", "Overall2011_Tot", "Other2011_Tot")
dem2[,3] = gsub("%", "", dem2[,3])
dem2[,3] = as.numeric(dem2[,3])
dem2[,4] = as.numeric(dem2[,4])

full2 = merge(full, dem2, by="FULL_TEXT", all.x=TRUE, all.y=FALSE, sort=TRUE)
full2$EmanuelDiff = 0
full2$EmanuelDiff = sapply(1:length(full2$Ward), function(x) {full2[x,"Emanuel_Pct"] - full2[x,"Emanuel2011_Pct"]})
EmanMin = min(full2$EmanuelDiff, na.rm=TRUE)
EmanMax = max(full2$EmanuelDiff, na.rm=TRUE)
full2$EmanuelDiff = sapply(1:length(full2$Ward), function(x) {((full2[x,"EmanuelDiff"] - EmanMin)/(EmanMax-EmanMin))*100})






full2$WP = sapply(1:2069, function(v) {paste(as.character(full2[v,"Ward"]), "_", as.character(full2[v,"Precinct"]), sep="")})
full3 = full2[,c(1:3, 15:39)]


otherelections = read.csv("RoughData/FullOldElections.csv", header=TRUE, stringsAsFactors=FALSE)

full4 = merge(full3, otherelections, by.x="WP", by.y="WP", all.x=T)
full4 = full4[,c(1:28, 32:66)]
colnames(full4)[3] = "Ward"

full4[,"Emanuel_Pct"] = gsub("%", "", full4[,"Emanuel_Pct"])
full4[,"Garcia_Pct"] = gsub("%", "", full4[,"Garcia_Pct"])
full4[,"Fioretti_Pct"] = gsub("%", "", full4[,"Fioretti_Pct"])
full4[,"Walls_Pct"] = gsub("%", "", full4[,"Walls_Pct"])
full4[,"Wilson_Pct"] = gsub("%", "", full4[,"Wilson_Pct"])
full4[,"Run_Emanuel_Pct"] = gsub("%", "", full4[,"Run_Emanuel_Pct"])
full4[,"Run_Garcia_Pct"] = gsub("%", "", full4[,"Run_Garcia_Pct"])
full4[,"Ob_Obama_Pct"] = gsub("%", "", full4[,"Ob_Obama_Pct"])
full4[,"Ob_Romney_Pct"] = gsub("%", "", full4[,"Ob_Romney_Pct"])
full4[,"Run_Emanuel_Pct"] = gsub("%", "", full4[,"Run_Emanuel_Pct"])
full4[,"Ob_Johnson_Pct"] = gsub("%", "", full4[,"Ob_Johnson_Pct"])
full4[,"Ob_Stein_Pct"] = gsub("%", "", full4[,"Ob_Stein_Pct"])
full4 = full4[,2:63]


write.csv(full4, "RoughData/PrecinctFinal.csv", na="0", row.names=FALSE)






