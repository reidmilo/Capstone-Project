#Capstone Data Mergin

setwd('/Users/oliverreidmiller/Desktop/Data 400/Capstone/Data to Merge')
crime_df <- read.csv('df_anti_lgbt_crime.csv')
lgbt_pop_df <- read.csv('LGBT_State_Pop.csv')
church_df <- read.csv('churchesDf.csv')
state_pop_df <- read.csv('populationData.csv')
affiliation_df <- read.csv('Affiliation Full Data.csv')
education_df <- read.csv('Education Attainment.csv')
race_df <- read.csv('Race-Ethnicity.csv')
unemployment_df <- read.csv('unemployment data.csv')
voting_df <- read.csv('Voting Data.csv')
poverty_df <- read.csv('poverty data.csv')
urban_df <- read.csv('Urban Pop.csv')




# Function to convert state abbreviations to state names
convert_state_abbreviations <- function(dataframe, abbrev_column) {
  # Create a lookup table for state abbreviations and names
  state_lookup <- data.frame(
    Abbreviation = c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", 
                     "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", 
                     "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", 
                     "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", 
                     "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"),
    State = c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", 
              "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", 
              "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", 
              "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", 
              "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", 
              "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", 
              "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", 
              "Rhode Island", "South Carolina", "South Dakota", "Tennessee", 
              "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", 
              "Wisconsin", "Wyoming")
  )
  
  # Merge the lookup table with the dataframe
  merged_df <- merge(dataframe, state_lookup, by.x = abbrev_column, by.y = "Abbreviation", all.x = TRUE)
  
  # Remove the abbreviation column
  merged_df <- merged_df[, !(names(merged_df) %in% abbrev_column)]
  
  # Return the merged dataframe
  return(merged_df)
}

# Convert state abbreviations to state names
converted_df <- convert_state_abbreviations(df, "state_abbrev")

# Print the converted dataframe
print(converted_df)


#Crime Data Frame Aggregation
library(dplyr)

crime_df_agg <- crime_df %>% group_by(state_abbr,data_year) %>% summarise(crimes = n())

#Start Merging

#Crime & Churches
merged_df <- merge(crime_df_agg, church_df, by.x = 'state_abbr', by.y = 'STATE')

merged_df <- convert_state_abbreviations(merged_df,'state_abbr')

#Affiliation

merged_df <- merge(merged_df, affiliation_df, by.x = c('State', 'data_year'), by.y = c('State', 'Year'))

#Education
merged_df <- merge(merged_df, education_df, by.x = c('State', 'data_year'), by.y = c('State', 'Year'))


#Race
merged_df <- merge(merged_df, race_df, by.x = c('State', 'data_year'), by.y = c('State', 'Year'))

#LGBT Pop
lgbt_pop_df <- lgbt_pop_df[1:51,-c(1,4)]

colnames(lgbt_pop_df) <- c('State','LGBT_Pop')

merged_df <- merge(merged_df, lgbt_pop_df, by = 'State')
merged_df$LGBT_Pop <- as.numeric(merged_df$LGBT_Pop)

#Add Population


colnames(state_pop_df) <- c('State','2014','2015','2016','2017','2018','2019','2020','2021','2022')
rownames(state_pop_df) <- state_pop_df[, 1]
state_pop_df <- state_pop_df[, -1]

merged_df$State_Pop <- NA
state_pop_col_num <- which(colnames(merged_df) == 'State_Pop')


for (i in 1:nrow(merged_df)){
  state = merged_df[i,1]
  year = merged_df[i,2]
  
  column_number <- which(colnames(state_pop_df) == year)
  row_number <- which(rownames(state_pop_df) == state)
  
  merged_df[i,state_pop_col_num]<-state_pop_df[row_number,column_number]
  
}

#Add Unemployment 
merged_df <- merge(merged_df, unemployment_df, by.x = c('State', 'data_year'), by.y = c('STATE', 'YEAR'))

#Add Voting
voting_df<- convert_state_abbreviations(voting_df,'State')
voting_df <- na.omit(voting_df)
merged_df <- merge(merged_df, voting_df, by.x = c('State', 'data_year'), by.y = c('State.y', 'Year'))


#Add Poverty Data
merged_df <- merge(merged_df, poverty_df, by.x = c('State', 'data_year'), by.y = c('State', 'Year'))

#Add Urban
merged_df <- merge(merged_df, urban_df, by = "State")



# Function to divide a specific column in a dataframe by 100
divide_column_by_100 <- function(dataframe, column_name) {
  # Check if the column exists in the dataframe
  if (!(column_name %in% colnames(dataframe))) {
    stop("Column not found in the dataframe")
  }
  
  # Divide the specified column by 100
  dataframe[[column_name]] <- dataframe[[column_name]] / 100
  
  # Return the modified dataframe
  return(dataframe)
}
# Function to replace "N/A" with "NA" in a dataframe
replace_na_strings <- function(dataframe) {
  # Loop through each cell in the dataframe
  for (i in 1:nrow(dataframe)) {
    for (j in 1:ncol(dataframe)) {
      # Check if the cell contains "N/A"
      if (dataframe[i, j] == "N/A") {
        # Replace "N/A" with "NA"
        dataframe[i, j] <- NA
      }
    }
  }
  
  # Return the modified dataframe
  return(dataframe)
}

merged_df <- replace_na_strings(merged_df)
merged_df$Black..non.Hispanic <- as.numeric(merged_df$Black..non.Hispanic)
merged_df$Hispanic <- as.numeric(merged_df$Hispanic)
merged_df$Asian.or.Pacific.Islander <- as.numeric(merged_df$Asian.or.Pacific.Islander)

merged_df <- divide_column_by_100(merged_df,'High.school.or.less')
merged_df <- divide_column_by_100(merged_df,'Some.college')
merged_df <- divide_column_by_100(merged_df,'College.graduate')
merged_df <- divide_column_by_100(merged_df,'Post.graduate')
merged_df <- divide_column_by_100(merged_df,'White..non.Hispanic')
merged_df <- divide_column_by_100(merged_df,'Black..non.Hispanic')
merged_df <- divide_column_by_100(merged_df,'Hispanic')
merged_df <- divide_column_by_100(merged_df,'Asian.or.Pacific.Islander')
merged_df <- divide_column_by_100(merged_df,'Something.Else...Multiracial')
merged_df <- divide_column_by_100(merged_df,'LGBT_Pop')
merged_df <- divide_column_by_100(merged_df,'UNEMPLOYMENT.RATE')

write.csv(merged_df, 'Merged_data.csv')

#New Variables

df <- read.csv('Merged_data.csv')

#PopToChurch <- df$State_Pop/df$churchesPerState

df$MarriageLegalization <- NA
marriageLegal_col <- which(colnames(df) == 'MarriageLegalization')
year_col <- which(colnames(df) == 'data_year')

for (i in 1:nrow(df)) {
  if (df[i, year_col] > 2015) {
    df[i, marriageLegal_col] <- 1
  } else {
    df[i, marriageLegal_col] <- 0
  }
}



#library(corrplot)
#corDf <- df[-c(1,2)]
#M<-cor(corDf)
#corrplot(M)
#corrplot(M, type = "upper")

  
#Democratic is Reference Group
df$otherReligions <- df$Muslim+df$Buddhist+df$Hindu+df$Orthodox.Christian+df$Jehovah.s.Witness

df$crimes_per_100k <- (df$crimes/df$State_Pop)*100000
df$whiteProtestant <- df$White.evangelical.Prot.+df$White.mainline.Prot.
df$non_white_Protestant <- df$Hispanic.Protestant+df$Other.non.white.Prot.+df$Black.Protestant
df$non_white_catholic <- df$Hispanic.Catholic+df$Other.non.white.Catholic

df$population_to_church_ratio_100k <- (df$churchesPerState / df$State_Pop) * 100000

df$college <- df$College.graduate+df$Some.college


df <- df[, !colnames(df) %in% c('Asian.or.Pacific.Islander', 'Democratic','X','Muslim','Buddhist','College.graduate','Some.college',
                                'Hindu','Orthodox.Christian','Jehovah.s.Witness','State_Pop','churchesPerState',
                                'White.evangelical.Prot.','White.mainline.Prot.','crimes')]

# Assuming 'df' is your data frame
colnames(df) <- c("State", 
                  "Data_Year", 
                  "Black_Protestant", 
                  "Hispanic_Protestant", 
                  "Other_Non_White_Protestant", 
                  "White_Catholic", 
                  "Hispanic_Catholic", 
                  "Other_Non_White_Catholic", 
                  "Mormon", 
                  "Jewish", 
                  "Unaffiliated", 
                  "High_School_or_Less", 
                  "Post_Graduate", 
                  "White_Non_Hispanic", 
                  "Black_Non_Hispanic", 
                  "Hispanic", 
                  "Something_Else_Multiracial", 
                  "LGBT_Pop", 
                  "Unemployment_Rate", 
                  "Republican", 
                  "Poverty_Rate", 
                  "Rural_Pop", 
                  "Marriage_Legalization", 
                  "Other_Religions", 
                  "Hate_Crimes_Per_100k", 
                  "White_Protestant", 
                  "Non_White_Protestant", 
                  "Non_White_Catholic", 
                  "Population_to_Church_Ratio_100k", 
                  "College")
write.csv(df,'updated_df.csv')

#df <- read.csv('updated_df.csv')

modelData <- df [-c(1,2,3,4,25)]

library(jtools)
library(kableExtra)
lm <- lm(hate_crimes_per_100k~., data = modelData)
summ(lm)
plot_summs(lm)

religionDf <-df %>% select('hate_crimes_per_100k','white_evangelical_protestant','white_mainline_protestant','black_protestant',
                           'hispanic_protestant','other_non_white_protestant','white_catholic','hispanic_catholic','other_non_white_catholic',
                           'mormon','jewish','unaffiliated','population_to_church_ratio')



lm2 <- lm(hate_crimes_per_100k~white_catholic+hispanic_catholic+other_non_white_catholic+population_to_church_ratio_100000, data = religionDf)
plot_summs(lm2)


lm3<-lm(hate_crimes_per_100k~. data= religionDf)
summary(lm3)
