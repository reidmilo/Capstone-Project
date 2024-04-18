### Maia Vachon, Mai Nguyen and Oliver Reidmiller
---
# Exploring the Correlation Between Religious Affiliations and Anti-LGBT Hate Crimes and Legislation


## Introduction

## Objectives
Research Question

## Data Analysis 
### Data Collection
Provide data sources

### Data Processing 
How was dataframe manipulated, merged, aggregated, etc.

### Data Dictionary

# `capstoneData.csv`

| Variable                      | Class   | Description                                                                                  |
|:------------------------------|:--------|:---------------------------------------------------------------------------------------------|
| State Name                    | String  | Name of the state                                                                            |
| State Abbreviation                    | String  | Abbreviation code of the state                                                               |
| Year                     | String  | Year of the data                                                                             |
| Hate Crimes                   | String  | Total number of anti-LGBT+ reported hate crimes                                              |
| Churches per State              | String  | Number of churches per state                                                                 |
| State Population                     | String  | Total population of the state                                                                |
| White  Protestant  | Numeric | Number of White Evangelical and White Mainline Protestant churches in the state                 |
| Non white Protestant              | Numeric | Number of Black, Hispanic, and Other Non White Protestant churches in the state                             |
| White Catholic                | Numeric | Number of White Catholic churches in the state                                |
| Non White Catholic             | Numeric | Number of Hispanic and Non White Catholic churches in the state                             |
| Mormon                        | Numeric | Number of Mormon churches in the state                                        |
| Jewish                        | Numeric | Number of Jewish churches in the state                                        |
| Other Religions                        | Numeric | Number of Hindu, Muslim, Jehovah's Witness, and Orthodox Christian churches in the state                                        |
| Unaffiliated                  | Numeric | Number of Unaffiliated population in the state                                   |
| High School or Less           | Numeric | Percentage of population with high school education or less in the state            |
| College                  | Numeric | Percentage of population with atleast some college education in the state                   |
| Post Graduate                 | Numeric | Percentage of population with post-graduate education in the state                  |
| White Non Hispanic            | Numeric | Percentage of White Non-Hispanic population in the state                            |
| Black Non Hispanic            | Numeric | Percentage of Black Non-Hispanic population in the state                            |
| Hispanic                      | Numeric | Percentage of Hispanic population in the state                                      |
| Multiracial                   | Numeric | Percentage of Multiracial population in the state                                   |
| Unemployment Rate             | Numeric | Unemployment rate in the state                                                                |
| Republican                    | Numeric | Percentage of Republican voters in the state                                        |
| Democratic                    | Numeric | Percentage of Democratic voters in the state                                        |
| Poverty Rate                  | Numeric | Poverty rate in the state                                                                     |
| Marriage Legalization         | Numeric | Indicator of whether marriage legalization is present in the state (0 for No, 1 for Yes)      |
| Hate Crimes per 100,000       | Numeric | Number of hate crimes reported per 100,000 population in the state                             |
| Crime Rate per 100,000        | Numeric | Total crime rate reported per 100,000 population in the state                                  |
| Percent Rural Population      | Numeric | Percentage of urban population in the state                                                   |
| Churches Per 100,000          | Numeric | Number of churches per 100,000 population in the state                                         |



# Results 

| VARIABLES                   | Hate Crime | Religious Affiliation | Controlled Variables | FE-1   | FE-2   |
|-----------------------------|------------|-----------------------|----------------------|--------|--------|
| White_Protestant            | 0.247      | 1.097***              |                      | -0.063 | -0.208 |
| Non_White_Protestant        | 0.360      | 0.600                 |                      | -0.490 | -0.671 |
| White_Catholic              | 0.159      | 1.012***              |                      | 0.527  | 0.371  |
| Non_White_Catholic          | 0.311      | 0.865**               |                      | 0.125  | -0.080 |
| Mormon                      | 0.137      | 1.001**               |                      | -0.376 | -0.517 |
| Jewish                      | 1.316      | 2.637***              |                      | 1.575  | 1.343  |
| Other_Religions             | 1.334***   | 1.238**               |                      | 0.540  | 0.576  |
| Unaffiliated                | 0.327      | 1.483***              |                      | -0.112 | -0.439 |
| Population_to_Church_Ratio_100k | -0.000965** | -0.000885*         | -0.000510            | -0.00968 | -0.00429 |
| High_School_or_Less         | 0.931      |                       | 1.180                | 0.267  | -0.288 |
| College                     | 1.431*     |                       | 1.578**              | 0.661  | 0.097  |
| Post_Graduate               | 1.084      |                       | 1.483*               | -0.156 | -1.105 |
| White_Non_Hispanic          | 0.442      |                       | 0.335                | 0.462  | -0.183 |
| Black_Non_Hispanic          | -0.106     |                       | -0.0674              | 1.025** | 0.265 |
| Hispanic                    | 0.118      |                       | 0.0856               | 0.293  | -0.334 |
| Multiracial                 | 0.491*     |                       | 0.605**              | 0.618* | 0.050  |
| Unemployment_Rate           | -0.171     |                       | 0.135                | -0.329 | 1.044  |
| Republican                  | -0.0886    |                       | -0.193**             | -0.110 | -0.373 |
| Poverty_Rate                | 0.379      |                       | 0.328                | -0.256 | 0.238  |
| Marriage_Legalization       | 0.0363**   |                       | 0.0304               | 0.0194 | 0.169*** |
| 2015.Year                   |            |                       |                      |        | 0.0405 |
| 2016.Year                   |            |                       |                      |        | -0.121*** |
| 2017.Year                   |            |                       |                      |        | -0.102*** |
| 2018.Year                   |            |                       |                      |        | -0.113*** |
| 2019.Year                   |            |                       |                      |        | -0.101** |
| 2020.Year                   |            |                       |                      |        | -0.124** |
| 2021.Year                   |            |                       |                      |        | -0.0646*** |
| LGBT_Pop                    | 0.271      |                       | 0.102                |        |        |
| Rural_Pop                   | -0.000263  |                       | 0.000237             |        |        |
| Constant                    | -1.662**   | -0.915**              | -1.524**             | 0.0492 | 1.003  |


Let me know if you need anything else!

