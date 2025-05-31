# Introduction
# This is a starter code for BUSINFO 703 Practice Test

# Clustering
# In this question, you will be using a dataset (provided as PT_Sample.csv file)
#  to perform k-means clustering. The dataset contains information about age,
#  work hours and income for 500 individuals. You wish to understand the data
#  and identify if there are some individuals that can be grouped together to
#  better understand the dataset.

# Tradition
## It is customary to start any programming with this step :)
print('Hello World!')

# Step 0
# Print your student id here.
# START code here
print("329205126")
# END code here

# Step 1
# Check if relevant packages exist. Install them if needed.
# Load the packages you may need.
# START code here
install.packages("ggplot2") # need to install package once!
library(ggplot2)
## Package for computing Silhouette Score
install.packages("cluster") # need to install package once!
library(cluster)
## Package for generating multiple scatterplots
install.packages("GGally") # need to install package once!
library(GGally)
## Package for Association Rules
install.packages("arules") # need to install package once!
library(arules)
install.packages("arulesViz") # need to install package once!
library(arulesViz)
# END code here

# Step 2
# Load the CSV file (PT_Sample.csv) for processing.
# You should have downloaded it from Canvas before you started this task.
# START code here
pt_sample <- read.csv("PT_Sample.csv")
# END code here

# Step 3
# Perform basic data analysis on the sample dataset.
# You want to capture mean and standard deviation of each variable and
#  correlation between the variables.
# START code here
summary(pt_sample)
cor(pt_sample)
# END code here

# Step 4
# Create relevant visuals to understand distributions and relationships.
# Note: Please use pairplot function for this step.
# START code here
ggpairs(pt_sample)
# END code here

# Step 5
# Perform transformations to pre-process data before using k-means algorithm.
# Note: Please use standardisation (convert values to z-scores) for this step.
# START code here
pt_sample_std <- as.data.frame(scale(pt_sample))
summary(pt_sample_std)
sapply(pt_sample_std,sd)
# END code here

# Step 6
# Apply the clustering method. Start with 2 clusters.
# Check the Silhouette score using euclidean metric.
# START code here
set.seed(703) # Set seed for reproducibility - DO NOT CHANGE THIS!!!
kmeans_result <- kmeans(pt_sample_std,centers = 2)
silhouette_scores <- silhouette(kmeans_result$cluster, dist(pt_sample_std))
avg_silhouette_score <- mean(silhouette_scores[, 3])
print(avg_silhouette_score)
# END code here

# Step 7
# Add the cluster values to the original dataset. You can use this sample code:
#  df_XXX$cluster_2 <- factor(kmeans_result$cluster)
# Visualise the original data with the cluster information.
# Note: Please use pairplot with colour as the cluster labels for this step.
# START code here
pt_sample$cluster_2 <- factor(kmeans_result$cluster)
ggpairs(pt_sample, mapping = aes(color = cluster_2))
?ggpairs
# END code here

# Step 8
# Repeat the clustering process with 4 clusters and check the Silhouette score
#  using euclidean metric. (see Step 6).
# Add the cluster values to the original dataset (use a different column name).
# Now visualise the original data with these clusters (see Step 7).
# You may also see the 2-cluster values in your plot - that's as expected!
# START code here
set.seed(703) # Set seed for reproducibility - DO NOT CHANGE THIS!!!
kmeans_result <- kmeans(pt_sample_std,centers = 4)
silhouette_scores <- silhouette(kmeans_result$cluster, dist(pt_sample_std))
avg_silhouette_score <- mean(silhouette_scores[, 3])
print(avg_silhouette_score)
pt_sample$cluster_2 <- factor(kmeans_result$cluster)
ggpairs(pt_sample, mapping = aes(color = cluster_2))
# END code here

# Step 9
# Save this file and upload the CORRECT version in your Test.
# That's it - you are done with this question :)

# ENJOY!!!
# Here is a set of 3D plots using a special package called plotly.
# If you have created your dataframe as df_data and added the two cluster
#  variables as cluster_2 and cluster_4, you can enjoy your work :)

if (!require("plotly")) install.packages("plotly")
library(plotly)
# 3D plot using numeric data (see Viewer tab instead of Plots)
plot_ly(data = df_data,
        x = ~age,
        y = ~workhours,
        z = ~income,
        type = 'scatter3d',
        mode = 'markers')
# Colour coded with 2-cluster assignment
plot_ly(data = df_data,
        x = ~age,
        y = ~workhours,
        z = ~income,
        color = ~cluster_2,
        colors = c("blue", "red"),
        type = 'scatter3d',
        mode = 'markers')
# Colour coded with 4-cluster assignment
plot_ly(data = df_data,
        x = ~age,
        y = ~workhours,
        z = ~income,
        color = ~cluster_4,
        colors = c("blue", "red", "green", "brown"),
        type = 'scatter3d',
        mode = 'markers')


Interpretation of Your Results:
  For 2 clusters, the Silhouette score is 0.5707:
  This score is moderate, suggesting that the clustering is 
somewhat good but could still be improved. The clusters have a reasonable level 
of separation and cohesion.
For 4 clusters, the Silhouette score is 0.5421:
  This score is slightly lower than the one for 2 clusters, 
which indicates that adding more clusters might not have improved the 
clustering as expected. In fact, the score suggests that the 4-cluster solution 
is somewhat worse than the 2-cluster solution in terms of how well-separated 
and cohesive the clusters are.
