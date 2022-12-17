# Install and load the required libraries
install.packages("topicmodels")
library(topicmodels)
library(tidytext)

# Read the dataset from a CSV file into a data frame
dataset <- read.csv("dataset.csv", stringsAsFactors = FALSE)

# Tokenize the sentences (split each sentence into a list of words)
tokenized_sentences <- dataset %>%
  unnest_tokens(word, text)

# Create a document-term matrix
dtm <- DocumentTermMatrix(tokenized_sentences, control = list(removePunctuation = TRUE, stopwords = TRUE))

# Create an LDA model
lda_model <- LDA(dtm, k = 1)

# Extract the topics for each sentence
sentence_topics <- as.matrix(lda_model$topics)

# Write the topics to a new CSV file
write.csv(sentence_topics, "topics.csv", row.names = FALSE)