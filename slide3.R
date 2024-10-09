# Analysis of Variance test (ANOVA)
#“do the three different wildflower seed mixes attract different numbers of pollinators?”

# The first thing we need to do is visualise the data.
# it’s much easier to deal with categorical data if we convert it to a factor:

flowers$mix <- as.factor(flowers$mix)
plot(visits~mix, data=flowers)

# however box plot is not really what we want to see
# We want to visualise the full variation within and among the mixes, and relate that to the overall mean.
# Add an extra column to our data give each observation a reference number:
flowers$ref <- c(1:length(flowers$visits))
plot(visits ~ ref, data = flowers, col=mix)
# ↑'col=mix' give each mix its own colour
plot(visits~ ref, xaxt="n", data=flowers,col=mix)
# ↑'xaxt="n"' tells R to leave the x axis blank

axis(1, at =c(10, 30, 50), labels=c("A", "B", "C"))
#↑adding labels

mean_visits = mean(flowers$visits)
abline(h=mean_visits, col="blue", lty=2, lwd=3)
# The means of each mix are a long way from each other, and  the means for mix A and C are a long way from the overall mean.
# So we can say that there is ‘substantial variation among the mixes’.

# let's calculate the variance!
# first thing, we need to calculate the sum of squares within each mix.
mixA <- subset(flowers, mix=="A")
mixB <- subset(flowers, mix=="B")
mixC <- subset(flowers, mix=="C")

ss_A<- sum((mixA$visits - mean(mixA$visits))^2)
ss_B<- sum((mixB$visits - mean(mixB$visits))^2)
ss_C<- sum((mixC$visits - mean(mixC$visits))^2)

df_A <- 19
df_B <- 19
df_C <- 19
# or 
df_A <- length(mixA$visits) - 1

within_ss <- ss_A + ss_B + ss_C
within_df <- df_A + df_B + df_C

within_ms <- within_ss / within_df 
total_ss <- sum((flowers$visits - mean(flowers$visits))^2) 

total_df <- 60-1
# or 
total_df <- length(flowers$visits) -1 

among_ss <- total_ss - within_ss
among_df <- total_df - within_df

among_ms <- among_ss / among_df

F_ratio <- among_ms / within_ms
1-pf(F_ratio, 2, 57)

a <- aov(visits ~ mix, data=flowers) 
anova(a)
