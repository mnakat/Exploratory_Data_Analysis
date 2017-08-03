# Getting and Cleaning Data Course Project

# plot1.R

# Question
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# download the the zip file from the URL below and unzip
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# move the unzipped files to working directory

# load emissions data
NEI <- readRDS("summarySCC_PM25.rds")

# calculate sum of emissions each year
annual_emissions_total <- aggregate(Emissions ~ year, data=NEI, FUN=sum)

# plot total emissions in each year
with(annual_emissions_total, plot(year, Emissions, xlab = "Year", ylab= "Total Emmisions", main="Total PM2.5 Emission", type="l"))

# save the graph as png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
