source("getFile.R")

# reading data
if(!NEI) NEI <- readRDS("summarySCC_PM25.rds")
if(!SCC) SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data by Baltimore's fip.
baltimoreNEI <- NEI[NEI$fips=="24510",]

# sum the Baltimore emissions data by year and aggregate based on it
emissionsSumBaltimore <- aggregate(Emissions ~ year + type, baltimoreNEI,sum)

# plotting
png("plot3.png")

library(ggplot2)

g <- ggplot(emissionsSumBaltimore, aes(year, Emissions, color = type)) + geom_line() +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" Emissions")) +
  ggtitle("total Emissions per type in Baltimore")
print(g)
dev.off()