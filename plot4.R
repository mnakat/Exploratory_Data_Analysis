# Getting and Cleaning Data Course Project

# plot4.R

# Question
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?


# download the the zip file from the URL below and unzip
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# move the unzipped files to working directory

# load emissions data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find coal combustion related record from SCC
coal_index <- grep("coal", tolower(SCC$Short.Name), ignore.case = TRUE)

# extract SCC(ID)
coal_scc <- SCC[coal_index, 1]

# subset coal combustion related data
coal_nei <- subset(NEI, SCC %in% coal_scc)

# calculate sum of emissions each year
coal_nei_annual_emissions_total <- aggregate(Emissions ~ year, data=coal_nei, FUN=sum)

# plot coal combustion related PM2.5 emissions in each year
with(coal_nei_annual_emissions_total, plot(year, Emissions, xlab = "Year", ylab= "Total Emmisions", main="Total coal combustion-related PM2.5 Emission", type="l"))

# save the graph as png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
