schools = read.csv("Data/schoolcuts-master/lib/tasks/data/schools.csv")
space2013 = read.csv("RoughData/201314enrollmentspace.csv")
closed50 = read.csv("RoughData/50closed.csv")

write.csv(schools[,c(1,8:9)], "RoughData/AllSchools.csv", na="0", row.names=FALSE)

#sort through 50 data
closingrows = grep("clos", closed50$Action)
closing = closed50[closingrows, ] 
receivingrows = grep("receiving", closed50$Action)
receiving = closed50[receivingrows, ] 
rows133 = 1
rows133 = seq(rows133, 133, 1)
otherrows = setdiff(rows133, closingrows)
otherrows = setdiff(otherrows, receivingrows)
other = closed50[otherrows, ] 

#adding to f
f = closed50
f$Impact = gsub("L.Hughes", "HughesL", f$Impact)
f$Impact = gsub("C. Hughes", "HughesC", f$Impact)


f$ReceivingCode = f$Impact
f$ReceivingCode2 = f$Impact
f$ReceivingCode3 = f$Impact
findsingreceiving = grep("Receiving school is ", f$Impact)
findtworeceiving = grep("Receiving schools are [A-Za-z ]* and.*", f$Impact)
findthreereceiving = grep("Receiving schools are [A-Za-z ]*\\,.*", f$Impact)
findnoreceiving = grep("Receiv", f$Impact)
findnoreceiving = setdiff(rows133, findnoreceiving)
findnoreceiving = c(receivingrows, otherrows, findnoreceiving)
f[findnoreceiving,"ReceivingCode"] = "0"
f[findnoreceiving,"ReceivingCode2"] = "0"
f[findnoreceiving,"ReceivingCode3"] = "0"
f[findsingreceiving,"ReceivingCode2"] = "0"
f[findsingreceiving,"ReceivingCode3"] = "0"
f[findtworeceiving,"ReceivingCode3"] = "0"


f$ReceivingCode = gsub(".*Receiving school is ([A-Za-z ]*)[\\.\\,].*", "\\1", f$ReceivingCode)
f[findthreereceiving, "ReceivingCode"] = gsub(".*Receiving schools are ([A-Za-z ]*)\\,.*", "\\1", f[findthreereceiving, "ReceivingCode"])
f[findthreereceiving, "ReceivingCode2"] = gsub(".*Receiving schools are [A-Za-z ]*\\, ([A-Za-z ]*) and.*", "\\1", f[findthreereceiving, "ReceivingCode2"])
f[findthreereceiving, "ReceivingCode3"] = gsub(".*Receiving schools are [A-Za-z ]*\\, [A-Za-z ]* and ([A-Za-z ]*).*", "\\1", f[findthreereceiving, "ReceivingCode3"])

f[findtworeceiving, "ReceivingCode"] = gsub(".*Receiving schools are ([A-Za-z ]*) and.*", "\\1", f[findtworeceiving, "ReceivingCode"])
f[findtworeceiving, "ReceivingCode2"] = gsub(".*Receiving schools are [A-Za-z ]* and ([A-Za-z ]*).*", "\\1", f[findtworeceiving, "ReceivingCode2"])

f$School.Name.Condense = gsub("[ ,.-]", "", f$School.Name)
f$School.Name.Condense = gsub("WELLSI", "IDAWELLS", f$School.Name.Condense)
f$School.Name.Condense = gsub("WARDL", "LAURAWARD", f$School.Name.Condense)
f$ReceivingCode = gsub("[ ,.-]", "", f[,"ReceivingCode"])
f$ReceivingCode = sapply(f$ReceivingCode, function(v) {toupper(v)})
f$ReceivingCode2 = gsub("[ ,.-]", "", f[,"ReceivingCode2"])
f$ReceivingCode2 = sapply(f$ReceivingCode2, function(v) {toupper(v)})
f$ReceivingCode3 = gsub("[ ,.-]", "", f[,"ReceivingCode3"])
f$ReceivingCode3 = sapply(f$ReceivingCode3, function(v) {toupper(v)})

name.to.id = function(colnum, rownum){
  x = f[rownum, colnum]
  if(is.na(as.numeric(x)) && is.character(x)){
    str.loc = grep(x, f$School.Name.Condense)
    if (length(str.loc)==1){
      toString(f[str.loc, "School.ID"])
    } else{
      x
    }
  } else{
    "0"
  }
}

f$ReceivingCode = unlist(sapply(rows133, function(v) {name.to.id(9, v)}, simplify=FALSE))
f$ReceivingCode2 = unlist(sapply(rows133, function(v) {name.to.id(10, v)}, simplify=FALSE))
f$ReceivingCode3 = unlist(sapply(rows133, function(v) {name.to.id(11, v)}, simplify=FALSE))

g = merge(f, schools, by="School.ID", all.x=FALSE, all.y=FALSE)
h = merge(g, space2013, by.x="School.ID", by.y="SchoolID", all.x=TRUE, all.y=FALSE)
h = h[with(h, order(h$Action)), ]

h = h[,c(1:154)]
h$ResultCode = h$Action
h$ResultCode = as.numeric(h$ResultCode) - 2  
h$ResultCode[h$ResultCode=="0"] = 1
h$ResultCode[h$ResultCode=="2"] = 1
h$ResultCode[h$ResultCode=="4"] = 2
h$ResultCode[h$ResultCode=="5"] = 2
h$ResultCode[h$ResultCode=="6"] = 4

names(h) = gsub("\\.", "", names(h))

write.csv(h, "RoughData/SchoolsFinal.csv", na="0", row.names=FALSE)

hlinks = h[,c(1, 9:11, 19:20)]

find.dst.coord = function(latorlon, id, srcrow){ #id=1 for LAT, id=2 for LON
  charid = as.character(links$School.ID)
  dstrow = grep(id, charid)
  if (as.numeric(links[srcrow, "ReceivingCode"]) != 0){
    links[dstrow, (latorlon)] 
  } else{
    0
  }
}
links = hlinks
links$DstLat = 0
links$DstLon = 0
links = links[,c(5:8, 1:4)]
names(links)[1] = "SrcLat"
names(links)[2] = "SrcLon"
len = length(links$School.ID)
links$DstLat = sapply(1:len, function(i){find.dst.coord(1, links[i, "ReceivingCode"], i)})
links$DstLon = sapply(1:len, function(i){find.dst.coord(2, links[i, "ReceivingCode"], i)})
temp = links
#ReceivingCode2
temp = temp[temp$ReceivingCode2!="0",]
temp$ReceivingCode = temp$ReceivingCode2
len = length(temp$School.ID)
temp$DstLat = sapply(1:len, function(i){find.dst.coord(1, temp[i, "ReceivingCode"], i)})
temp$DstLon = sapply(1:len, function(i){find.dst.coord(2, temp[i, "ReceivingCode"], i)})
links = rbind(links, temp)
#ReceivingCode3
temp = temp[temp$ReceivingCode3!="0",]
temp$ReceivingCode = temp$ReceivingCode3
len = length(temp$School.ID)
temp$DstLat = sapply(1:len, function(i){find.dst.coord(1, temp[i, "ReceivingCode"], i)})
temp$DstLon = sapply(1:len, function(i){find.dst.coord(2, temp[i, "ReceivingCode"], i)})
links = rbind(links, temp)
links = links[,c(1:4)]
links = links[links$DstLat!="0",]
write.csv(links, "RoughData/SchoolsLinksFinal.csv", na="0", row.names=FALSE)



