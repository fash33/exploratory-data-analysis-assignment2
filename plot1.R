source("getFile.R")

# reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sum the total emissions by year
emissionsSum <- aggregate(Emissions ~ year,NEI, sum)

# plotting 
png("plot1.png")

barplot(
  (emissionsSum$Emissions)/10^6,
names.arg=emissionsSum$year,
  xlab="Year",
  ylab="pM2.5 Emissions (10^6 Tons)",
  main="total PM2.5 Emissions From All US Sources"
)

dev.off()
