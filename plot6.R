source("getFile.R")

# reading data
if(!NEI) NEI <- readRDS("summarySCC_PM25.rds")
if(!SCC) SCC <- readRDS("Source_Classification_Code.rds")

los <- subset(NEI, fips == "06037")

# subsetting SCC with vehicle values
vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

# merging dataframes, adding city variable
baltimoreData <- merge(baltimoreNEI, subsetSCC, by="SCC")
baltimoreData$city <- "Baltimore City"
laData <- merge(los, subsetSCC, by="SCC")
laData$city <- "Los Angeles County"
data <- rbind(baltimoreData, laData)

# summing emission data per year per type
data <- aggregate(Emissions ~ year + city, data, sum)

# plotting
png("plot6.png")

g <- ggplot(data, aes(year, Emissions, color = city)) + geom_line() +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" Emissions")) +
  ggtitle("total Emissions from motor sources in Baltimore and Los Angeles")

print(g)
dev.off()