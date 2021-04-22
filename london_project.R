#loading the data set into the dataframe
london_crime <- read.csv("london-crime-data.csv",na="")
str(london_crime)
london_crime

#creating a new column called date and adding month and year into the column
london_crime$Date <- paste(london_crime$month, london_crime$year, sep='/')
str(london_crime)

converted_date <- paste("01",london_crime$month,london_crime$year, sep = "/")
converted_date

###################################

names(london_crime)
names(london_crime)[names(london_crime) == "borough"] <- "Borough"
names(london_crime)[names(london_crime) == "minor_category"] <- "SubCategory"
names(london_crime)[names(london_crime) == "major_category"] <- "MajorCategory"
names(london_crime)[names(london_crime) == "value"] <- "Value"
names(london_crime)[names(london_crime) == "Date"] <- "CrimeDate"
names(london_crime)

london_crime <- london_crime[c(2,3,4,5,8)]
london_crime
str(london_crime)

###################################

london_crime$CrimeDate <- as.Date(converted_date, "%d/%m/%Y")
london_crime
str(london_crime)

###################################

london_crime$Borough <- factor(london_crime$Borough)
str(london_crime)

attach(london_crime)

display_settings <- par(no.readonly = TRUE)
plot(london_crime$Borough , main = "Crime occurrences in Borough", xlab = "Names of Borough", ylab = "Crime occurrences")
summary.factor(Borough)

detach(london_crime)

# Croydon        -- 5226 -- highest 
# City of London --   86 -- lowest  

###################################

london_crime$MajorCategory <- factor(london_crime$MajorCategory)

attach(london_crime)

str(MajorCategory)
summary(MajorCategory)
MajorCategory <- summary(MajorCategory)
pie(MajorCategory,  main="The percentage of crime by major category")

detach(london_crime)

###################################

london_crime$Region[Borough == "Kingston upon Thames" | Borough == "Newham" | Borough == "Barking and Dagenham" | Borough == "Bexley" | Borough == "Greenwich" | Borough == "Havering"| Borough == "Redbridge" | Borough == "Wandsworth" ] <- "East"
london_crime$Region[Borough == "Barnet" | Borough == "Enfield" | Borough == "Hackney" | Borough == "Haringey" ] <- "North"
london_crime$Region[Borough == "Brent" | Borough == "Ealing" | Borough == "Hammersmith and Fulham" | Borough == "Harrow" | Borough == "Hillingdon" | Borough == "Hounslow" | Borough == "Richmond upon Thames"] <- "West"
london_crime$Region[Borough == "Bromley" | Borough == "Croydon" | Borough == "Merton" | Borough == "Sutton" ] <- "South"
london_crime$Region[Borough == "Islington" | Borough == "Kensington and Chelsea" | Borough == "Lambeth" | Borough == "Lewisham" | Borough == "Southwark" | Borough == "Waltham Forest" | Borough == "Tower Hamlets" | Borough == "Westminster" ] <- "Central"
#Checking for nulls
which(london_crime$MajorCategory == NA)
#City of london is nA so filling the values
london_crime$Region[Borough == "City of London"] <- "Central"

######################################

london_crime$Region <- factor(london_crime$Region)
str(london_crime)
plot(london_crime$Region)
summary(london_crime$Region)

#Central is the highest one is central
# South is the least one
###################################

write.csv(london_crime,"london-crime-modified.csv")


