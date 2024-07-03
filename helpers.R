## ==================================================================================== ##
# App Name: GeExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##

library(shiny) 
library(reshape2)
library(ggplot2)
library(ggthemes)
library(gplots)
library(ggvis)
library(dplyr)
library(tidyr)
library(DT) 
library(limma)
library(DESeq2)
library(edgeR)
library(RColorBrewer)
library(pheatmap)
library(shinyBS)
library(plotly)
library(markdown)
library(NMF)
library(scales)
library(heatmaply)
library(readr)
library(colourpicker)
library(data.table)
library(janitor)
library(DT) # for table width wrap in upload data

##================================================================================##

source("fun-dotplot.R")
source("fun-heatmap.R")
source("fun-analyzecounts.R")
source("fun-analysisres.R")
source("fun-groupplots.R")
source("fun-input-analyze-data.R")

#troubleshooting
if(FALSE) {
# seqdata <- read.csv("data/mousecounts_example.csv",stringsAsFactors = FALSE)
  seqdata <- read.csv("data/examplecounts_shortmicro_saudi-positives.csv",stringsAsFactors = FALSE)
# load('data/mousecounts_example_analysis_results.RData')
  load('data/START_results_examplecounts_shortmicro_saudi-positives.RData')
# load('data/mousecounts_example_analyzed.RData') #example_data_results
  load('data/START_results_examplecounts_shortmicro_saudi-positives.RData') #example_data_results
  data_analyzed = list('group_names'=group_names,'sampledata'=sampledata,
                       "results"=results,"data_long"=data_long, "geneids"=geneids,
                       "data_results_table"=example_data_results)
  
  data_results = data_analyzed$results
  
  test_sel = "group2/group1"
  sel_test = test_sel
  fdrcut = 0.05
  absFCcut = 1
  group_sel = c("group1","group2")
  valuename = "log2cpm"
  yname="log2cpm"
  maxgenes = 200
  view_group=NULL
  filter_by_go=FALSE
  filter_fdr=FALSE
  filter_maxgene=TRUE
  filter_cpm=FALSE
  filter_fc=FALSE
  fold_change_range=NULL
  fold_change_groups=NULL
  group_filter_range =NULL
  fixed_genes_list=NULL
  orderby="variance"
  
  tmpdat = heatmap_subdat(data_analyzed,yname,orderby="variance",maxgenes=100)
  heatmap_render(data_analyzed,yname,orderby="variance",maxgenes=100)
  
  mydat = heatmap_ggvis_data(
    data_analyzed = data_analyzed,
    yname = yname,
    orderby = "variance",
    maxgenes=100)

}
