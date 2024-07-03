## ==================================================================================== ##
# App Name: GenExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##

options(shiny.maxRequestSize = 100*1024^2)
#options(repos = BiocInstaller::biocinstallRepos()) # use setRepositories() 1 2

source("helpers.R")
print(sessionInfo())

shinyServer(function(input, output,session) {
## Redirect Start Analysis to Analysis Tab  
   observeEvent(input$go_to_analysis, {
    updateNavbarPage(session, "tabs", selected = " ")
  })

## Server functions are divided by tab
  source("server-inputdata.R",local = TRUE)
  source("server-filterdata.R",local = TRUE)
  source("server-dotplot.R",local = TRUE)
  source("server-heatmap.R",local = TRUE)
  source("server-samplegroupplots.R",local=TRUE)
  source("server-analysisres.R",local = TRUE)
  source("server-data.R",local = TRUE)
  
})
