# Getting and Cleaning Data Course Project

# plot5.R

# Question
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?


# download the the zip file from the URL below and unzip
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# move the unzipped files to working directory

# load emissions data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset Baltimore record
baltimore_data <- subset(NEI, fips == "24510")

# find motor related record from SCC
motor_index <- grep("motor", tolower(SCC$Short.Name), ignore.case = TRUE)

# extract SCC(ID)
motor_scc <- SCC[motor_index, 1]

# subset motor related data
baltimore_motor_nei <- subset(baltimore_data, SCC %in% motor_scc)

# calculate sum of emissions each year
baltimore_motor_annual_emissions_total <- aggregate(Emissions ~ year, data=baltimore_motor_nei, FUN=sum)

# plot motor related PM2.5 emissions in each year
with(baltimore_motor_annual_emissions_total, plot(year, Emissions, xlab = "Year", ylab= "Total Emmisions", main="Total motor related PM2.5 Emission in Baltimore", type="l"))

# save the graph as png file
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()
