---
title: "GettingAndCleaning-CourseProject"
output: html_document
---
Initial Housekeeping to set the working directory, create the data directory if it doesn't exist and get the file.

setwd ("C:/Users/sodonri/Documents/My Personal Stuff/coursera/Getting and Cleaning Data/CourseProject")
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")
