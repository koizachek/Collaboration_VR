# Install the tidytext and dplyr packages
install.packages("tidytext")
install.packages("dplyr")

# Install the ggplot2 package
install.packages("ggplot2")

# Load the tidytext, dplyr, and ggplot2 packages
library(tidytext)
library(dplyr)
library(ggplot2)



# Load the dataset and store it in a data frame
data <- read.csv("vrcollab_full.csv", stringsAsFactors = FALSE)

# Clean the data by removing punctuation and stopwords
data_clean <- data %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

# Perform sentiment analysis on the data
data_sentiment <- data_clean %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment, word, sort = TRUE)

# Group the data by sentiment and plot the results
ggplot(data_sentiment, aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ sentiment, scales = "free_y") +
  labs(x = NULL, y = "Count")


#Visualization and Group Comparison
# Divide the data into 10 groups and compare the sentiment of each group
data_sentiment_grouped <- data_sentiment %>%
  group_by(group) %>%
  summarize(mean_sentiment = mean(sentiment))

# Group the data by group and plot the results using a bar chart
ggplot(data_sentiment_grouped, aes(group, mean_sentiment)) +
  geom_col(show.legend = FALSE) +
  labs(x = "Group", y = "Mean sentiment")
  
 
# or as a line chart
ggplot(data_sentiment, aes(group, n, color = sentiment)) +
  geom_line() +
  labs(x = "Group", y = "Count")

# or a scatterplot
ggplot(data_sentiment, aes(group, n, color = sentiment)) +
  geom_point() +
  labs(x = "Group", y = "Count")



