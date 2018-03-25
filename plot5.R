source("getFile.R")

# reading data
if(!NEI) NEI <- readRDS("summarySCC_PM25.rds")
if(!SCC) SCC <- readRDS("Source_Classification_Code.rds")

# subsetting SCC with vehicle values
vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

# merging dataframes
NEISCC <- merge(baltimoreNEI, subsetSCC, by="SCC")

# summing emission data per year per type
emissionsSum <- tapply(NEISCC$Emissions, NEISCC$year, sum)

# plotting
png("plot5.png")

barplot(emissionsSum, xlab = "year", ylab = "total Emission (ton)", 
        main = "total Emission from motor sources in Baltimore")

dev.off()