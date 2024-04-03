# Hate Crime Data Processing
setwd('/Users/oliverreidmiller/Desktop/Data 400/Capstone')
rawData <- read.csv('hate_crime.csv')


df<-rawData

library(dplyr)
library(ggplot2)

table(df$data_year)

ggplot(df, aes(x = factor(data_year))) +
  geom_bar() +
  labs(x = "Year", y = "Frequency", title = "Frequency Bar Graph of Data Year")


ggplot(df, aes(x = factor(data_year))) +
  geom_bar() +
  labs(x = "Year", y = "Frequency", title = "Frequency Bar Graph of Year")



biases <- c("Anti-Black or African American","Anti-White","Anti-Arab","Anti-Protestant","Anti-Islamic (Muslim)",
            "Anti-Gay (Male)","Anti-Asian","Anti-Catholic","Anti-Multiple Religions, Group","Anti-Hispanic or Latino",
            "Anti-Lesbian (Female)","Anti-Other Race/Ethnicity/Ancestry","Anti-Jewish","Anti-American Indian or Alaska Native",
             "Anti-Lesbian, Gay, Bisexual, or Transgender (Mixed Group)","Anti-Heterosexual",
            "Anti-Atheism/Agnosticism","Anti-Bisexual","Anti-Physical Disability","Anti-Mental Disability",
            "Anti-Jehovah's Witness","Anti-Church of Jesus Christ","Anti-Buddhist","Anti-Sikh","Anti-Other Christian",
            "Anti-Hindu", "Anti-Eastern Orthodox (Russian, Greek, Other)","Anti-Transgender","Anti-Gender Non-Conforming",
            "Anti-Male")

for (bias in biases) {
  df[[bias]] <- ifelse(grepl(bias, df$bias_desc), 1, 0)
}



filtered_column <- df$offense_name[!grepl(";", df$offense_name)]
crimeTypes <- unique(filtered_column)

for (crime in crimeTypes) {
  df[[crime]] <- ifelse(grepl(crime, df$offense_name), 1, 0)
}
# Initialize new column anti_lgbt
df$anti_lgbt <- NA

# Select relevant columns
anti_lgbt_df <- df[, c('Anti-Gay (Male)', 'Anti-Lesbian (Female)', 'Anti-Lesbian, Gay, Bisexual, or Transgender (Mixed Group)',
                       'Anti-Bisexual', 'Anti-Transgender', 'Anti-Gender Non-Conforming')]

# Check if any of the selected columns have a value >= 1
df$anti_lgbt <- as.integer(rowSums(anti_lgbt_df) >= 1)


# Filter the data
df_anti_lgbt_crime <- df %>% filter(anti_lgbt == 1)

# Plot
ggplot(df_anti_lgbt_crime, aes(x = factor(data_year))) +
  geom_bar(fill = "skyblue") +
  labs(x = "Year", y = "Frequency", title = "Anti-LGBT Hate Crimes in the United States",
       caption = 'Marriage Equality Legalized in 2014', subtitle = '1991-2022') +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 20, hjust = 0.5),
    axis.title = element_text(size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.text.y = element_text(size = 12)
  ) +
  geom_vline(xintercept =24, linetype = "dashed", color = "black") 

df_anti_lgbt_crime <- df_anti_lgbt_crime %>% 
  filter(data_year >= 2014 & data_year <= 2022)


# Plot
ggplot(df_anti_lgbt_crime, aes(x = factor(data_year))) +
  geom_bar(fill = "skyblue") +
  geom_text(aes(label = ..count..), stat = "count", vjust = -0.5, color = "black", size = 3) +  # Add data labels
  labs(x = "Year", y = "Frequency", title = "Anti-LGBT Hate Crimes in the United States", subtitle = '2014-2022') +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 20, hjust = 0.5),
    axis.title = element_text(size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.text.y = element_text(size = 12)
  )





write.csv(df, "wide_hate_crime.csv")
write.csv(df_anti_lgbt_crime, "df_anti_lgbt_crime.csv")
