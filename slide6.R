library(dplyr)

flower_table <- flowers  %>%  group_by (mix) %>% summarise (mean_vis =  mean (visits) ,
                                            stdev = sd (visits) , 
                                            se_vis = sd (visits) / sqrt (n () ) )
plot( mean_vis ~ as.factor(mix), data = flower_table, ylim=c(0,100), 
      xlab= "Flower mix", ylab = "Pollinators per 10 minutes")
points (visits ~ as.factor(mix), data = flowers, 							col=as.factor(mix))
arrows(x0=1:3, 
       y0=flower_table$mean_vis - flower_table$se_vis, 	x1=1:3, 
       y1=flower_table$mean_vis + flower_table$se_vis,
       code=3, length=0.2, angle=90, col=1:3, lwd=2)
         
# ggplot

library(ggplot2)
ggplot(flowers) + geom_point(aes(mix, visits, col=mix))
p <- ggplot(flowers) + geom_point(aes(mix, visits, col=mix), shape =21)

p1 <- p + geom_point(data=flowers, aes(mix, visits,col = mix),stat="summary",fun="mean")
plot(p1)
#↑ save the object as pi, and call the plot p1 to see it in the 'plot' at the right bottom section

p3<- p1 +   geom_point(data=flowers, aes(mix, visits,col = mix),stat="summary",fun="mean", size = 3)
p3

p4 <- p3 +  geom_errorbar (data=flower_table , 
                         aes(x=mix,ymin=(mean_vis-se_vis),
                             ymax=(mean_vis+se_vis),
                             col=mix), width=0.1)
p4
p5 <- p4 + labs(x="Flower mix", y = "Pollinator visits")
p6<- p5 + theme_bw()
p6s


