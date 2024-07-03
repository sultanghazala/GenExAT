## ==================================================================================== ##
# App Name: GeExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##


tabPanel("Terms & Conditions",
         fluidRow(
           column(4,wellPanel(
             h4("Shinyapps.io Terms & Conditions")
           )
           ),#column
           column(8,
                  includeMarkdown("instructions/terms.md"))
         ))