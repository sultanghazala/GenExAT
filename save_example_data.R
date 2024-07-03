## ==================================================================================== ##
# App Name: GeExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ## 
source("helpers.R")
source("fun-input-analyze-data.R")

alldata  <- read_csv("data/examplecounts_short_analyzed.csv")

analyzed_data <- analyze_expression_data(alldata, analysis_method="edgeR", numgeneids = 2)
names(analyzed_data)

write.csv(analyzed_data$data_results_table,file="data/examplecounts_short_analyzed.csv",quote=FALSE,row.names=FALSE)
write.csv(analyzed_data$data_results_table[1:100,],file="data/examplecounts_short_analysisres_short.csv",quote=FALSE,row.names=FALSE)
write.csv(alldata[1:100,],"data/examplecounts_short.csv",row.names = FALSE)

# LOADED DATA FOR EXAMPLE
save(analyzed_data,
     file="data/examplecounts_short_data.RData")



