source("getFile.R")

# reading data
if(!NEI) NEI <- readRDS("summarySCC_PM25.rds")
if(!SCC) SCC <- readRDS("Source_Classification_Code.rds")

# subset NEI data by Baltimore's fip.
baltimoreNEI <- NEI[NEI$fips=="24510",]

# sum the Baltimore emissions data by year and aggregate based on it
emissionsSumBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

#plotting
png("plot2.png")

barplot(
  emissionsSumBaltimore$Emissions,
  names.arg=emissionsSumBaltimore$year,
  xlab="year",
  ylab="PM2.5 Emissions (Tons)",
  main="total PM2.5 Emissions From all Baltimore City Sources"
)

dev.off()