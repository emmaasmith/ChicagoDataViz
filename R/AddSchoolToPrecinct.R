precincts = read.csv("RoughData/PrecinctFinal.csv")
schools = read.csv("RoughData/SchoolsFinal2.csv")

#choose schools variables
schools = schools[,c(160, 158:159, 157, 3:4, 11:13, 27:28, 33:34, 59:60, 65, 138, 151:153)]
names(schools) = c("FULL_TEXT", "WARD", "PRECINCT", "ResultCode", "SchoolID", "SchoolName", "ReceiveA", "ReceiveB", "ReceiveC",
                   "StudentsBlack", "StudentsHisp", "StudentsWhite", "Enrollment", "ClassSize", "SpaceUsed", "InvolvedFam", 
                    "ClosingStatus", "ReceivingStatus", "PPP")
  
# Fix names to get rid of numbers
#betternames = read.csv("RoughData/SchoolsFinal.csv")
#names(schools)[3:157] = names(betternames)
#rm.nums = function(name){
#  len = nchar(name)
#  first = substr(name, 1, 1)
#  last = substr(name, len, len)
#  if(!is.na(as.numeric(last))){
#    name = paste(name, "x", sep="") 
#  }
#  name
#}
#names(schools) = lapply(names(schools), rm.nums)


sortschool = schools[order(schools[,"FULL_TEXT"]),]
tableschool = as.data.frame(table(sortschool$FULL_TEXT))

merge_sortschool = merge(sortschool, tableschool, by.x="FULL_TEXT", by.y="Var1", all=T)

sing_sortschool = merge_sortschool[merge_sortschool$Freq==1,]
mult_sortschool = merge_sortschool[merge_sortschool$Freq>1,]

# NOTE: RIGHT NOW SCHOOL DATA IS CHOSEN AT RANDOM IF MULTIPLE CLOSINGS. 
# Only two schools per precinct max. Most are 1 closing 1 receiving; former is taken if so.
combined_sortschool = merge(sing_sortschool, mult_sortschool[seq(1, length(mult_sortschool$Freq), 2),], all=T)

fulldata = merge(precincts, combined_sortschool, by="FULL_TEXT", all=T)
fulldata$Freq[is.na(fulldata$Freq)] = 0


write.csv(fulldata, "RoughData/PrecinctFinal.csv", na="0", row.names=FALSE)

