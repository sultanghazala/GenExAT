## ==================================================================================== ##
# App Name: GenExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##

tabPanel("Heatmaps",  
         fluidRow(column(4,wellPanel(
           actionButton("action_heatmaps","Generate Heatmaps"),  
           h6(textOutput("numheat")),
           radioButtons("heatmapvaluename",label="Select Value to Plot in Heatmap",choices=""),
           selectizeInput("view_group_heatmap", label="Select Groups to View",
                          choices=NULL,
                          multiple=TRUE),
           selectizeInput("view_samples_heatmap", label="Select Samples to View",
                          choices=NULL,
                          multiple=TRUE),
           radioButtons("heatmap_subset",label="Use all genes or upload your own subset?",
                        choices=c("all","subset"),selected="all"),
           
           conditionalPanel("input.heatmap_subset=='subset'",
                            fileInput('heatmap_file', 'Choose File Containing Gene IDs\n(one row per gene)',
                                      accept=c('text/csv', 
                                               'text/comma-separated-values,text/plain', 
                                               '.csv'))
           ),
           
           
           conditionalPanel("input.heatmap_subset=='all'",
                            radioButtons("heatmap_order",label = "Order genes by",
                                         choices=c("Significance (adjusted p-value)"="significance",
                                                   "Variation (CV or SD)"="variation"),
                                         selected="variation")
                            ,
                            
                            
                            
                            h4("Filters"),
                            
                            conditionalPanel(condition="input.heatmap_order=='significance'",
                                             selectizeInput("sel_test_heatmap",
                                                            label=h5("Select Test to Use for Filtering"), 
                                                            choices="",
                                                            selected="")
                            ),
                            
                            conditionalPanel(condition="input.heatmap_order=='significance'",
                                             checkboxInput("filter_fdr","FDR cutoff",value = FALSE)),
                            conditionalPanel(condition="input.filter_fdr==true",
                                             numericInput("FDRcut",label="Choose P-value 
                                         (FDR if analyzed by START) cutoff",
                                                          min=0,max= 1,value=0.05)),
                            
                            conditionalPanel(condition="input.heatmap_order=='significance'",
                                             checkboxInput("filter_fc","Filter by fold change for a pair of groups",
                                                           value=FALSE)),
                            conditionalPanel(condition="input.filter_fc==true",
                                             selectizeInput("fold_change_groups", label="Select 2 Groups",
                                                            choices=NULL,
                                                            selected=NULL,
                                                            multiple=TRUE,options = list(maxItems = 2)),
                                             sliderInput("fold_change_range",
                                                         label="Choose Log2Fold Change Filter",
                                                         min= -20, max=20,value=c(-20,20))),
                            
                            checkboxInput("filter_maxgene",
                                          "Show a maximum number of genes \n (Note: Selecting >1000 genes may be slow to load. If app crashes memory limits have been reached and you should run from local computer via github.)",value=TRUE),
                            conditionalPanel(condition="input.filter_maxgene==true",    		
                                             numericInput("maxgenes",label="Choose Max # of Genes",
                                                          min=1,max= 10000,value=10,step=1))
                            
                            #                             #conditionalPanel(condition="output.numgenes>9000",
                            #                             conditionalPanel(condition="input.filter_maxgene==false",    
                            #                                              radioButtons("filter_maxgeneN",
                            #                                                           "WARNING: >10000 genes may be slow to 
                            # load and may cause memory limits to be reached and app may crash. 
                            # Run app on local computer if heatmap of large number of genes and samples required.",
                            #                                                           choices=c(
                            #                                                             "Restrict to 10k genes for online viewing."="genesN",
                            #                                                             "Do not restrict to 10k. Show all genes (may cause web app to crash)."="genesall"),
                            #                                                           selected="genesN"
                            #                                              )
                            #                             )
           ), #conditional panel
           h4("Other Settings"),
           
           checkboxInput("heatmap_rowlabels",
                         "Show gene (row) labels",value = TRUE
           ),
           checkboxInput("heatmap_rowcenter",
                         "Center each row",value=TRUE)
           
           
         )#,#sidebarPanel
         #img(src="KCardio_CMYK_4C_pos_small.jpg",height=150,width= 275,align="right")	
         ),#column
         column(8,
                tabsetPanel(
                  tabPanel(title="HeatMap",
                           #textOutput("which_genes"),
                           h4(textOutput("heatmap_rna_title")),
                           plotOutput("heatmap_rna",height="800px")                        
                  ),
                  # tabPanel(title="Interactive HeatMap",
                  #          h4(textOutput("heatmap_rna_title_int")),
                  #          uiOutput("heatmapggvisUI_rna"),
                  #          ggvisOutput("heatmapggvis_rna")
                  # ),
                  tabPanel(title="Interactive HeatMap",
                           #h4(textOutput("heatmap_rna_title_int")),
                           plotlyOutput("heatmapplotly",height="800")
                  ),
                  tabPanel(title="Data Output",
                           downloadButton('downloadHeatmapData_rna', 
                                          'Download Heatmap Data as CSV File'),
                            br(),
                            p(""),
                            div(style="overflow-x: auto;",   # added div to control table horizontal overflow
                            dataTableOutput("heatdat_rna")
                           ),
                  ) #tabpanel 
                )#tabsetPanel
         )#column
         )#fluidrow
)#tabpanel
