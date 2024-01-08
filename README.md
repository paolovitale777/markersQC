# Description
This package was created to detect potential mismatches between genotyping and pedigree data. It proves valuable in overseeing genotyping errors and crossbreeding operations.
The parental contribution feature assesses the genetic contribution of each parent to their offspring, employing the methodology outlined by Bernardo et al. (2000). 
An altered parental contribution, particularly regarding genetic similarity, can signal significant concerns related to genotyping and/or crossbreeding operations.

# Code
Here, is provided the code for running markersQC. 

#Install and load remotes

install.packages("remotes")

library(remotes)

#install markersQC

remotes::install_github("paolovitale777/markersQC")

#Load the datasets

data(crosses)

data(hpm)

#Run the function "estimate_common_markers" to calculate the similarity between offspring and parent 1 and 2

results_df <- estimate_common_markers(markers, crosses)

#Parental contribution estimation

pc_df <- parental_contribution(results_df)



# Reference
Bernardo, R., Romero-Severson, J., Ziegle, J., Hauser, J., Joe, L., Hookstra, G., & Doerge, R. W. (2000). Parental contribution and coefficient of coancestry among maize inbreds: pedigree, RFLP, and SSR data. Theoretical and Applied Genetics, 100, 552-556.
