data = read.csv("RoughData/PrecinctFinal.csv")

# Racial colors
RaceDomFn = function(x){
  max = max(data$C_White_Pct[x], data$C_AA_Pct[x], data$C_Hispanic_Pct[x])
  if (max == data$C_White_Pct[x]) 1
  else if (max == data$C_AA_Pct[x]) 2
  else if (max == data$C_Hispanic_Pct[x]) 3
}

RaceDom = seq(1, length(data$FULL_TEXT))
RaceDom = sapply(RaceDom, RaceDomFn)
RaceDomCol = RaceDom
RaceDomCol[RaceDom==1] = "#000000" #W
RaceDomCol[RaceDom==2] = "#FF0000" #B
RaceDomCol[RaceDom==3] = "#0000FF" #H

# 2015 election colors
MayorDomFn = function(x){
  max = max(data$Emanuel_Pct[x], data$Wilson_Pct[x], data$Garcia_Pct[x])
  if (max == data$Emanuel_Pct[x]) 1
  else if (max == data$Wilson_Pct[x]) 2
  else if (max == data$Garcia_Pct[x]) 3
}

MayorDom = seq(1, length(data$FULL_TEXT))
MayorDom = sapply(MayorDom, MayorDomFn)
MayorDomCol = MayorDom
MayorDomCol[MayorDom==1] = "#000000" #Emanuel
MayorDomCol[MayorDom==2] = "#FF0000" #Wilson
MayorDomCol[MayorDom==3] = "#0000FF" #Garcia



# More pro-Obama (and pro-Quinn) people preferred Rahm in 2011 to 2015.
ObamaRegression = lm(data$Ob_Obama_Pct~data$EmanuelDiff)
summary(ObamaRegression)

Emanuel_dif = data$Emanuel_Pct - data$Emanuel2011_Pct
plot(data$Ob_Obama_Pct, Emanuel_dif, xlab="Obama % in 2012", 
     ylab="Emanuel % in 2015 - Emanuel % in 2011", main="Obama voters preferred Rahm in 2011", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
abline(h=0, col="red")




# The people who both hate and love Rauner voted for Emanuel
RaunerPct = data$Rauner / data$Governor_Votes

ScreenCluster = RaunerPct<.09 & data$Emanuel_Pct<60 & data$Emanuel_Pct>20
ScreenCluster[ScreenCluster==FALSE] = "#000000"
ScreenCluster[ScreenCluster==TRUE] = "#FF0000"

plot(RaunerPct, data$Emanuel_Pct, xlab="Rauner % in 2014", 
     ylab="Emanuel % in 2015", main="Rauner voters vs Emanuel 2015", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)

plot(RaunerPct, data$Emanuel2011_Pct, xlab="Rauner % in 2014", 
     ylab="Emanuel % in 2011", main="Rauner voters vs Emanuel 2011", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)

plot(RaunerPct, data$Ob_Obama_Pct, xlab="Rauner % in 2014", 
     ylab="Obama % in 2012", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)

plot(RaunerPct, data$Run_Emanuel_Pct, xlab="Rauner % in 2014", 
     ylab="Emanuel % in Runoff", main="Rauner voters vs Emanuel Runoff", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)

# NOTE: The white voters jump up during the runoffs vs. in 2015.
# It makes sense that the AA voters rise, because their candidate is out
# Is it because of the voters who got scared / wanted to "warn" Rahm?

# NOTE: Using Rauner as a general measure of conservatism




plot(data$Emanuel_Pct[RaceDom==1], data$Run_Emanuel_Pct[RaceDom==1], xlab="2015", 
     ylab="Runoff", main="White Voters % for Emanuel 2015 vs Runoff", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5)
abline(1, 1, col="red")
#Yes, W voters universally prefer Rahm in Runoff




plot(data$Votes_Cast[RaceDom==1]/data$RegVot[RaceDom==1], data$Run_Votes_Cast[RaceDom==1]/data$Run_RegVot[RaceDom==1], xlab="2015", 
     ylab="Runoff", main="White Voters Turnout 2015 vs Runoff", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=MayorDomCol[RaceDom==1])
#Turnout for white voters is equal across candidate

plot(data$Emanuel_Pct, data$Votes_Cast/data$RegVot, xlab="Emanuel %", 
     ylab="Turnout", main="Voters Turnout 2015 vs Emanuel %, by race", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
#Turnout across races 2015 

plot(data$Run_Emanuel_Pct, data$Run_Votes_Cast/data$Run_RegVot, xlab="Emanuel %", 
     ylab="Turnout", main="Voters Turnout Runoff vs Emanuel %, by race", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
#Turnout across races runoff

turnout2011 = data$Overall2011_Tot/data$C_Tot
turnout2011[turnout2011>1] = 0
plot(data$Emanuel2011_Pct, turnout2011, xlab="Emanuel %", 
     ylab="Turnout", main="Voters Turnout 2011 vs Emanuel %, by race", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
#Turnout across races 2011 -- I think this is very bad data









# Failed test for Emanuel difference
RaunerRegression = lm(data$Rauner~data$EmanuelDiff)
summary(RaunerRegression)
plot(RaunerPct, data$EmanuelDiff, xlab="Rauner % in 2012", 
     ylab="Emanuel % in 2015 - Emanuel % in 2011", main="Rauner voters preferred Rahm in 2015", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5)
abline(h=0, col="red")




# Race with screen for the anomoly above
plot(data$C_Hispanic_Pct, data$Emanuel_Pct, xlab="Hispanic", 
     ylab="Emanuel % in 2015", main="Hispanic", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=ScreenCluster)

plot(data$C_White_Pct, data$Emanuel_Pct, xlab="White", 
     ylab="Emanuel % in 2015", main="White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=ScreenCluster)

plot(data$C_AA_Pct, data$Emanuel_Pct, xlab="Black", 
     ylab="Emanuel % in 2015", main="Black", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=ScreenCluster)

plot(data$School_Yes/data$School_Votes, data$Emanuel_Pct, xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=ScreenCluster)



# School vote
SchoolVote_Pct = data$School_Yes/data$School_Votes
plot(SchoolVote_Pct, data$Emanuel_Pct, xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)

# Investigate the split above
SplitCluster = data$Emanuel_Pct>60 | (SchoolVote_Pct>.6 & data$Emanuel_Pct>55) | (SchoolVote_Pct>.7 & data$Emanuel_Pct>50) | (SchoolVote_Pct>.75 & data$Emanuel_Pct>45) | (SchoolVote_Pct>.8 & data$Emanuel_Pct>40) 
SplitCluster[SplitCluster==FALSE] = "#000000"
SplitCluster[SplitCluster==TRUE] = "#FF0000"

#ppl who like Emanuel
SplitCluster2 = data$Emanuel_Pct>60 
SplitCluster2[SplitCluster2==FALSE] = "#000000"
SplitCluster2[SplitCluster2==TRUE] = "#FF0000"

#ppl who like school vote
SplitCluster3 = SchoolVote_Pct>.7 
SplitCluster3[SplitCluster3==FALSE] = "#000000"
SplitCluster3[SplitCluster3==TRUE] = "#FF0000"

#ppl who don't like school vote
SplitCluster4 = SchoolVote_Pct<.55 
SplitCluster4[SplitCluster4==FALSE] = "#000000"
SplitCluster4[SplitCluster4==TRUE] = "#FF0000"

#have closed schools
HaveClosedSchools = data$Freq
HaveClosedSchools[HaveClosedSchools==0] = "#000000"
HaveClosedSchools[HaveClosedSchools>0] = "#FF0000"

# have closed schools or don't like school vote
HaveClosedSchoolOrNoVote = data$Freq | SchoolVote_Pct<.55 
HaveClosedSchoolOrNoVote[HaveClosedSchoolOrNoVote==0] = "#000000"
HaveClosedSchoolOrNoVote[HaveClosedSchoolOrNoVote>0] = "#FF0000"


plot(SchoolVote_Pct, data$Emanuel_Pct, xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=HaveClosedSchools)

# Investigate split with white people
plot(SchoolVote_Pct[RaceDom==1], data$Emanuel_Pct[RaceDom==1], xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes, White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster2[RaceDom==1])

#no
plot(data$Ob_Obama_Pct[RaceDom==1], Emanuel_dif[RaceDom==1], xlab="Obama % in 2012", 
     ylab="Emanuel % in 2015 - Emanuel % in 2011", main="Obama voters preferred Rahm in 2011, White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster[RaceDom==1])
abline(h=0, col="red")

#YES
plot(RaunerPct[RaceDom==1], (data$Ob_Obama_Pct/100)[RaceDom==1], xlab="Rauner % in 2014", 
     ylab="Obama % in 2012", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster2[RaceDom==1])

plot(SchoolVote_Pct, data$Emanuel_Pct, xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes, White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster2)




#rejected from bottom?
# Colored by affected areas: no correlation
plot(SchoolVote_Pct, data$Emanuel_Pct, xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=HaveClosedSchools)

# Non-white voters: no correlation
plot(SchoolVote_Pct[RaceDom!=1], data$Emanuel_Pct[RaceDom!=1], xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=HaveClosedSchools[RaceDom!=1])

plot(SchoolVote_Pct[RaceDom==1], data$Emanuel_Pct[RaceDom==1], xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes, White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=HaveClosedSchoolOrNoVote[RaceDom==1])

# They had the best turnout for Obama and the worst turnout for Rauner/the vote
plot((data$Garcia_Pct)[SplitCluster4=="#FF0000"], data$Emanuel_Pct[SplitCluster4=="#FF0000"], xlab="Garcia Pct", 
     ylab="Emanuel Pct", main="Rauner vs Obama Turnout", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster4[SplitCluster4=="#FF0000"])

#They do kinda like Rauner
plot(RaunerPct[RaceDom==1], SchoolVote_Pct[RaceDom==1], xlab="Rauner % in 2014", 
     ylab="School Vote % in 2014", main="Rauner voters vs Obama 2012, White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster4[RaceDom==1])
plot(RaunerPct, SchoolVote_Pct, xlab="Rauner % in 2014", 
     ylab="School Vote % in 2014", main="Rauner voters vs Obama 2012, White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster4)




















#Important plots

# More pro-Obama (and pro-Quinn) people preferred Rahm in 2011 to 2015.
ObamaRegression = lm(data$Ob_Obama_Pct~data$EmanuelDiff)
summary(ObamaRegression)

Emanuel_dif = data$Emanuel_Pct - data$Emanuel2011_Pct
plot(data$Ob_Obama_Pct, Emanuel_dif, xlab="Obama % in 2012", 
     ylab="Emanuel % in 2015 - Emanuel % in 2011", main="Obama voters preferred Rahm in 2011", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
abline(h=0, col="red")





# The movement between the 2015 election and runoffs occurs by racial group (dominant in the precinct)
# The hispanic population shifts vertically: increases their turnout but not their support
# The black population shifts horizontally: same turnout but more support for Emanuel (as Wilson is gone)
# The white population shifts vertically and horizontally: increases turnout and support for Emanuel (scared; taught a lesson)

plot(data$Emanuel_Pct, data$Votes_Cast/data$RegVot, xlab="Emanuel %", 
     ylab="Turnout", main="Voters Turnout 2015 vs Emanuel %, by race", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)

plot(data$Run_Emanuel_Pct, data$Run_Votes_Cast/data$Run_RegVot, xlab="Emanuel %", 
     ylab="Turnout", main="Voters Turnout Runoff vs Emanuel %, by race", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)


# We can use Rauner as a general measure of conservatism; ought be separate from race

# A plot of Quinn and Obama % voters shows a pretty tight line
# This ought reflect conservativism: upper left is most Democratic, lower right is most Conservative
# Race correlates with this: black voters are most liberal, then Hispanic, then white
# But the most important takeaway is the fluidity of voters: they're all generally liberal

plot(RaunerPct, data$Ob_Obama_Pct/100, xlab="Rauner % in 2014", 
     ylab="Obama % in 2012", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
 


# The white voters jump up during the runoffs vs. in 2015.
# It makes sense that the AA voters rise, because their candidate is out
# Is it because of the voters who got scared / wanted to "warn" Rahm?




#Below, we see that the precincts that include schools that were affected by the school closings voted averagely for Rahm. 
# Colored by race: correlation
plot(SchoolVote_Pct, data$Emanuel_Pct, xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)

# Highlight people who vote no on school funding change (left) OR who had closed schools (right).
# They vote at similar levels for Rahm (although lower end of white; higher end of black voters)
# 1. We can see the coalition in Emanuel lovers between liberals and conservatives!
plot(SchoolVote_Pct[RaceDom==1], data$Emanuel_Pct[RaceDom==1], xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes, White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=HaveClosedSchoolOrNoVote[RaceDom==1])

plot(SchoolVote_Pct, data$Emanuel_Pct, xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=HaveClosedSchoolOrNoVote)

# Compare to Obama and Rauner
# 2. The people who disliked the school vote voted more conservatively in Obama than in Rauner/Quinn
# They don't like Obama, compared to their votes for Rauner
# The vote was also taken in the Rauner election, before Emanuel's election.
plot(RaunerPct[RaceDom==1], (data$Ob_Obama_Pct/100)[RaceDom==1], xlab="Rauner % in 2014", 
     ylab="Obama % in 2012", main="Rauner voters vs Obama 2012, White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster4[RaceDom==1])

plot(RaunerPct, (data$Ob_Obama_Pct/100), xlab="Rauner % in 2014", 
     ylab="Obama % in 2012", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster4)



# People who don't like school vote prefer Emanuel in 2015 (conservatives who figure out what he's about)
# People affected by closed schools prefer him in 2011
plot(data$Emanuel2011_Pct[HaveClosedSchoolOrNoVote=="#FF0000"], data$Emanuel_Pct[HaveClosedSchoolOrNoVote=="#FF0000"], 
     xlab="Emanuel 2011 %", ylab="Emanuel 2015 %", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster4[HaveClosedSchoolOrNoVote=="#FF0000"])
abline(1, 1, col="red")
#Prefer him in 2011 to Runoffs
plot(data$Emanuel2011_Pct[HaveClosedSchoolOrNoVote=="#FF0000"], data$Run_Emanuel_Pct[HaveClosedSchoolOrNoVote=="#FF0000"], 
     xlab="Emanuel 2011 %", ylab="Emanuel Runoff %", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster4[HaveClosedSchoolOrNoVote=="#FF0000"])
abline(1, 1, col="red")


# Most white people preferred Emanuel in 2011
plot(data$Emanuel2011_Pct[RaceDom==1], data$Emanuel_Pct[RaceDom==1], 
     xlab="Emanuel 2011 %", ylab="Emanuel 2015 %", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol[RaceDom==1])
abline(1, 1, col="red")
# The white people who voted no on schools preferred Emanuel in 2015
plot(data$Emanuel2011_Pct[SplitCluster4=="#FF0000"], data$Emanuel_Pct[SplitCluster4=="#FF0000"], 
     xlab="Emanuel 2011 %", ylab="Emanuel 2015 %", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol[SplitCluster4=="#FF0000"])
abline(1, 1, col="red")
# On top of that, the nonwhite people with schools closed preferred Emanuel in 2011
plot(data$Emanuel2011_Pct[HaveClosedSchoolOrNoVote=="#FF0000"], data$Emanuel_Pct[HaveClosedSchoolOrNoVote=="#FF0000"], 
     xlab="Emanuel 2011 %", ylab="Emanuel 2015 %", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol[HaveClosedSchoolOrNoVote=="#FF0000"])
abline(1, 1, col="red")












# Final graphs:

# 1
plot(RaunerPct, data$Ob_Obama_Pct/100, xlab="Rauner % in 2014", 
     ylab="Obama % in 2012", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
# 2
plot(RaunerPct, data$Emanuel2011_Pct, xlab="Rauner % in 2014", 
     ylab="Emanuel % in 2011", main="Rauner voters vs Emanuel 2011", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5)
plot(RaunerPct, data$Emanuel2011_Pct, xlab="Rauner % in 2014", 
     ylab="Emanuel % in 2011", main="Rauner voters vs Emanuel 2011", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
# 3
plot(RaunerPct, data$Emanuel_Pct, xlab="Rauner % in 2014", 
     ylab="Emanuel % in 2015", main="Rauner voters vs Emanuel 2015", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
# 4
plot(RaunerPct, data$Run_Emanuel_Pct, xlab="Rauner % in 2014", 
     ylab="Emanuel % in Runoff", main="Rauner voters vs Emanuel Runoff", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
# 5
plot(data$Emanuel_Pct, data$Votes_Cast/data$RegVot, xlab="Emanuel %", 
     ylab="Turnout", main="Voters Turnout 2015 vs Emanuel %, by race", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
# 6
plot(data$Run_Emanuel_Pct, data$Run_Votes_Cast/data$Run_RegVot, xlab="Emanuel %", 
     ylab="Turnout", main="Voters Turnout Runoff vs Emanuel %, by race", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
# 7
plot(SchoolVote_Pct, data$Emanuel_Pct, xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=RaceDomCol)
# 8
plot(SchoolVote_Pct[RaceDom==1], data$Emanuel_Pct[RaceDom==1], xlab="School Votes % Yes", 
     ylab="Emanuel % in 2015", main="School Votes, White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=HaveClosedSchoolOrNoVote[RaceDom==1])
# 9
plot(data$Emanuel2011_Pct[HaveClosedSchoolOrNoVote=="#FF0000"], data$Emanuel_Pct[HaveClosedSchoolOrNoVote=="#FF0000"], 
     xlab="Emanuel 2011 %", ylab="Emanuel 2015 %", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster4[HaveClosedSchoolOrNoVote=="#FF0000"])
abline(1, 1, col="red")
# 10
plot(data$Emanuel2011_Pct[HaveClosedSchoolOrNoVote=="#FF0000"], data$Run_Emanuel_Pct[HaveClosedSchoolOrNoVote=="#FF0000"], 
     xlab="Emanuel 2011 %", ylab="Emanuel Runoff %", main="Rauner voters vs Obama 2012", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster4[HaveClosedSchoolOrNoVote=="#FF0000"])
abline(1, 1, col="red")
# 11
plot(RaunerPct[RaceDom==1], (data$Ob_Obama_Pct/100)[RaceDom==1], xlab="Rauner % in 2014", 
     ylab="Obama % in 2012", main="Rauner voters vs Obama 2012, White", 
     cex=.3, cex.lab=.6, cex.main=.8, cex.axis=.5, col=SplitCluster4[RaceDom==1])
