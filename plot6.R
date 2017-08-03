# Getting and Cleaning Data Course Project

# plot6.R

# Question
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# download the the zip file from the URL below and unzip
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# move the unzipped files to working directory

library(ggplot2)

# load emissions data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset Baltimore, Los Angeles record
baltimore_los_data <- subset(NEI, fips == "24510" | fips == "06037")

# find motor related record from SCC
motor_index <- grep("motor", tolower(SCC$Short.Name), ignore.case = TRUE)

# extract SCC(ID)
motor_scc <- SCC[motor_index, 1]

# subset motor related data
baltimore_los_motor_nei <- subset(baltimore_los_data, SCC %in% motor_scc)

# calculate sum of emissions by each location, each year
baltimore_los_motor_annual_emissions_total <- aggregate(Emissions ~ fips + year, data=baltimore_los_motor_nei, FUN=sum)

# add city name based on fips
city_df <- data.frame(fips=c("24510", "06037"), city=c("Baltimore", "Los Angels"))
baltimore_los_motor_annual_emissions_total <- merge(baltimore_los_motor_annual_emissions_total, city_df, by="fips")

# plot coal combustion related PM2.5 emissions in each location, each year
ggplot(baltimore_los_motor_annual_emissions_total, aes(x=year, y=Emissions)) +
  geom_line(aes(color=city)) +
  ggtitle("emissions from motor vehicle sources")

# save the graph as png file
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()
