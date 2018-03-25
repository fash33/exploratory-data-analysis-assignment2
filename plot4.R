source("getFile.R")

# reading data
if(!NEI) NEI <- readRDS("summarySCC_PM25.rds")
if(!SCC) SCC <- readRDS("Source_Classification_Code.rds")

# subsetting SCC with coal values
coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
subsetSCC <- SCC[coalMatches, ]

# merging dataframes
NEISCC <- merge(NEI, subsetSCC, by="SCC")

# summing emission data per year
emissionsSum <- tapply(NEISCC$Emissions, NEISCC$year, sum)


# plotting
png("plot4.png")

barplot(emissionsSum/10^5, xlab = "year", ylab = "total Emission (ton)", 
        main = "total Emission from coal sources")
dev.off()