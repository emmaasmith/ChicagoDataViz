h = read.csv("RoughData/SchoolsFinal2.csv", header=TRUE, stringsAsFactors=FALSE)
precincts = read.csv("RoughData/PrecinctFinal.csv", header=TRUE, stringsAsFactors=FALSE)
h = h[(h$ResultCode < 3),]

len=length(h)
h = h[,c(3:len)]
hlinks = h[,c(1, 9:11, 158, 151)]

find.dst.code = function(id, srcrow){
  charid = as.character(links$SchoolID)
  dstrow = grep(id, charid)
  if (as.numeric(links[srcrow, "ReceivingCode"]) !=0){
    links[dstrow, 1] 
  } else{
    0
  }
}

precinct.subtraction = function(srcid, dstid, i){
  if (links[i, "DstCode"] == "0"){
    0
  } else{
    charid = as.character(links$SchoolID)
    srcid = as.character(srcid)
    dstid = as.character(dstid)
    srcrow = grep(srcid, charid)
    if(length(srcrow)!=1){
      srcrow = srcrow[1]
    }
    dstrow = grep(dstid, charid)
    if(length(dstrow)!=1){
      dstrow = dstrow[1]
    }
    sub = links[dstrow, 7] - links[srcrow, 7]
    sub
  }
}

links = hlinks
links$DstCode = 0
links = links[,c(5, 7, 1:4, 6)]
names(links)[1] = "SrcCode"
names(links)[4] = "ReceivingCode"
names(links)[5] = "ReceivingCode2"
names(links)[6] = "ReceivingCode3"
len = length(links$SchoolID)
links$DstCode = sapply(1:len, function(i){find.dst.code(links[i, "ReceivingCode"], i)})

temp = links
#ReceivingCode2
temp = temp[temp$ReceivingCode2!="0",]
temp$ReceivingCode = temp$ReceivingCode2
len = length(temp$SchoolID)
temp$DstCode = sapply(1:len, function(i){find.dst.code(temp[i, "ReceivingCode"], i)})
links = rbind(links, temp)
#ReceivingCode3
temp = temp[temp$ReceivingCode3!="0",]
temp$ReceivingCode = temp$ReceivingCode3
len = length(temp$SchoolID)
temp$DstCode = sapply(1:len, function(i){find.dst.code(temp[i, "ReceivingCode"], i)})
links = rbind(links, temp)
links$PPP = 0
len = length(links$SrcCode)
links$PPP = sapply(1:len, function(i){precinct.subtraction(links[i, "SchoolID"], links[i, "ReceivingCode"], i)})
links = links[links$DstCode!="0",]
links = links[,c(1:2, 8)]


#ADD PRECINCT STUFF
add.precinct.info = function(id, srcrow, xory, sord){ #xory is 1 for x, 2 for y; sord is 1 for src, 2 for dst
  charid = as.character(precincts[,"FULL_TEXT"])
  dstrow = grep(paste("^", id, "$", sep=""), charid)
  if (as.numeric(links[srcrow, sord]) != 0){
    precincts[dstrow, xory] 
  } else{
    0
  }
}
len = length(links$SrcCode)
precincts = precincts[,c("Emanuel_Pct", "Emanuel2011_Pct", "FULL_TEXT")] #make it the X then the Y variables
links$SrcX = sapply(1:len, function(i){add.precinct.info(links[i, "SrcCode"], i, 1, 1)})
links$SrcY = sapply(1:len, function(i){add.precinct.info(links[i, "SrcCode"], i, 2, 1)})
links$DstX = sapply(1:len, function(i){add.precinct.info(links[i, "DstCode"], i, 1, 2)})
links$DstY = sapply(1:len, function(i){add.precinct.info(links[i, "DstCode"], i, 2, 2)})
links = links[,c(1:2, 4:7, 3)]
#add policy points

write.csv(links, "RoughData/SchoolScatterLinks.csv", na="0", row.names=FALSE)

