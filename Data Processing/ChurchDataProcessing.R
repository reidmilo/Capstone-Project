churchDf <- read.csv('/Users/oliverreidmiller/Desktop/Data 400/Idea 2/All_Places_Of_Worship.csv')
setwd('/Users/oliverreidmiller/Desktop/Data 400/Capstone')
library(dplyr)

df <- churchDf %>% 
  group_by(STATE) %>% 
  summarise(churchesPerState = n())
df <- df %>% filter(STATE != 'AP')

write.csv(df, 'churchesDf.csv')


library(XML)
library(RCurl)

# Read HTML table into a list
churchStateAffiliation <- readHTMLTable(readLines(curl("https://www.pewresearch.org/religion/religious-landscape-study/compare/religious-tradition/by/state/")), 
                                        stringsAsFactors=FALSE)

# Convert list to data frame
affiliationDf <- do.call(rbind, churchStateAffiliation)

# Set row names 
rownames(affiliationDf) <- affiliationDf[,1]

# Remove the first column 
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
