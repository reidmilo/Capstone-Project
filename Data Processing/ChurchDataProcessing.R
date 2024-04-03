churchDf <- read.csv('/Users/oliverreidmiller/Desktop/Data 400/Idea 2/All_Places_Of_Worship.csv')
setwd('/Users/oliverreidmiller/Desktop/Data 400/Capstone')
library(dplyr)

df <- churchDf %>% 
  group_by(STATE) %>% 
  summarise(churchesPerState = n())
df <- df %>% filter(STATE != 'AP')

write.csv(df, 'churchesDf.csv')


# Assuming you've already loaded the required libraries
library(XML)
library(RCurl)

# Read HTML table into a list
churchStateAffiliation <- readHTMLTable(readLines(curl("https://www.pewresearch.org/religion/religious-landscape-study/compare/religious-tradition/by/state/")), 
                                        stringsAsFactors=FALSE)

# Convert list to data frame
affiliationDf <- do.call(rbind, churchStateAffiliation)

# Set row names (assuming state names are in the first column)
rownames(affiliationDf) <- affiliationDf[,1]

# Remove the first column (since it's already used as row names)
affiliationDf <- affiliationDf[, -1]

affiliationDf <- apply(affiliationDf, 2, function(x) gsub("< 1%", "0", x))
affiliationDf <- apply(affiliationDf, 2, function(x) gsub("%", '', x))
affiliationDf <- apply(affiliationDf, 2, function(x) gsub(",", '', x))


  # Get column names
  columns <- colnames(affiliationDf)
  
  # Iterate through columns and convert to numeric
  for (i in 1:ncol(affiliationDf)) {
    affiliationDf[, i] <- as.numeric(as.character(affiliationDf[, i]))
  }
  # Iterate through columns 1 to 16 and divide each element by 100


write.csv(affiliationDf,'affiliationDf.csv')

class(ibmbs) #Data type: List
ibmbs = ibmbs[[1]]
ibmbs = ibmbs[,-12] #Delete the last column
rownames(ibmbs) = ibmbs[,1]

ibmbs