## ==================================================================================== ##
# App Name: GenExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##


tabPanel("PCA (Principal Component Analysis)",  
         fluidRow(column(4,wellPanel(
           radioButtons("groupplot_valuename",label="Select Value to Plot",choices=""),
           selectizeInput("sampleres_groups", label="Select Groups",
                          choices=NULL,
                          multiple=TRUE),
           selectizeInput("sampleres_samples", label="Select Samples",
                          choices=NULL,
                          multiple=TRUE),
           conditionalPanel("input.groupplot_tabset=='PCA Plot'",
                            selectizeInput("pcnum",label="Select Principal Components",
                                           choices=1:10,
                                           multiple=TRUE,
                                           selected=1:2,
                                           options = list(maxItems = 2))
             
           )
         )#,#wellpanel
         
           
           #img(src="KCardio_CMYK_4C_pos_small.jpg",height=150,width= 275,align="right")	
         ),#column
         column(8,
           tabsetPanel(id="groupplot_tabset",
             tabPanel(title="PCA Plot",
                      downloadButton(outputId = "download_pca_plot", label = "Download the PCA plot .png"),
                      plotOutput("pca_plot")
             ),#tabPanel
       #      tabPanel(title="Sample Distance Heatmap",
       #               downloadButton(outputId = "download_gene_pheatmap", label = "Download the Heatmap .png"),
       #               plotOutput("gene_pheatmap") 
       #     )#tabPanel
           )#tabsetPanel
         )#mainPanel
         )#sidebarLayout
) #END tabPanel
