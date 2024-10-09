# PoE-tutorial-02

aggregate(wt~ sex, data = pups, mean)

#the weight difference
obs_wt_dif <- 412.9 -  444.54

#the standard devitation
aggregate(wt~ sex, data = pups, sd)

#first create two separate data sets, containing the data for each sex
mwt<-subset(pups, sex=="m")
fwt<-subset(pups, sex=="f")

#then draw the histogram for the male data
#the code after col is known as 'RGB' code, where the first 3 numbers give a colour, #and the final number makes it transparent 
hist(mwt$wt, col=rgb(1,0,0,0.5), main=NULL, xlab="Pup weight (g)", xlim=c(100,700))
abline(v=mean(mwt$wt),col="red", lty=2, lwd=3)

#this then 'adds' the female histogram to the male one
hist(fwt$wt, add=T, col=rgb(0, 1, 1, 0.5))
abline(v=mean(fwt$wt),col="blue", lty=2, lwd=3)

# - 
- We have started investigating weight data for banded mongoose pups, asking whether there is a difference between the weights of male and female pups at 90 days old.
- We have calculated the means for the two sexes, and seen that they differ by 31.64g.
- We then plotted the histograms, and they looked terribly similar.
- So we now have to ask how likely it is that we would see this difference, just by chance?

# the null hypothesis is:
“There is no weight difference between male and female mongooses at 90 days old”. 


wt_dif<-c()
for (i in 1:1000) {
   wts <- sample(pups$wt, 200, replace = F )
   sex <- pups$sex
   mean_f<- mean(wts[sex=="f"])
   mean_m<- mean(wts[sex=="m"]) 
   wt_dif[i] <- mean_f - mean_m}
   
# 'sample()' is saying 
- ‘draw 200 numbers at random from the wt column in the pups data set. Note the number, but don’t put it back before drawing the next’
- sample only exists inside the loop


hist(wt_dif, main=NULL, 
	xlab= "Simulated difference between mean weights (g)", 40)
# ↑'40' tells R how many 'bins' you want
abline(v=obs_wt_dif, col="red", lty=2, lwd=3)

#the probability of seeing a difference that big or bigger, purely by chance is:

more_extreme <- sum(wt_dif <= obs_wt_dif)/1000

# accept the null hypothesis as its propbability is larger than p=0.05
