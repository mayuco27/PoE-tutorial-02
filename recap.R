# Recap: summarising data in Base R


## subset a data


## subset a data using square bracket
# square brackets allow you to call specific components of an object in R.
# The basic syntax is:flowers[y, x]
# 'y' tells R which rows you want. If you leave it blank, it will give you ALL the rows in the dataframe ‘flowers’.
# 'x' tells R which columns you want. If you leave it blank, it will give you ALL the columns in the dataframe ‘flowers’.

flowers[5,]
flowers$visits[1]
flowers$visits[flowers$mix=="A"]
mean(flowers$visits[flowers$mix=="A"])
