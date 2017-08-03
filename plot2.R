# Getting and Cleaning Data Course Project

# plot2.R

# Question
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# download the the zip file from the URL below and unzip
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# move the unzipped files to working directory

# load emissions data
NEI <- readRDS("summarySCC_PM25.rds")

# subset Baltimore record
baltimore_data <- subset(NEI, fips == "24510")

# calculate sum of emissions each year
baltimore_annual_emissions_total <- aggregate(Emissions ~ year, data=baltimore_data, FUN=sum)

# plot total emissions in each year
with(baltimore_annual_emissions_total, plot(year, Emissions, xlab = "Year", ylab= "Total Emmisions", main="Baltimore Total PM2.5 Emission", type="l"))

# save the graph as png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
