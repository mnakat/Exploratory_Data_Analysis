# Getting and Cleaning Data Course Project

# plot3.R

# Question
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

# download the the zip file from the URL below and unzip
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# move the unzipped files to working directory

library(ggplot2)

# load emissions data
NEI <- readRDS("summarySCC_PM25.rds")

# subset Baltimore record
baltimore_data <- subset(NEI, fips == "24510")

# calculate sum of emissions each year
baltimore_annual_emissions_total_by_type <- aggregate(Emissions ~ type + year, data=baltimore_data, FUN=sum)

# plot total emissions in each year by type
ggplot(baltimore_annual_emissions_total_by_type, aes(x=year, y=Emissions)) +
    geom_line(aes(color=type)) +
    ggtitle("PM2.5 emissions by type in Baltimore")


# save the graph as png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
