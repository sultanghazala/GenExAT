## ==================================================================================== ##
# App Name: GenExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##



## Input data files
tabPanel("Input Data & DEG Analysis", 
         
         ## Left hand column has the input data settings and options
         fluidRow(column(4,wellPanel(
           # PDF of instructions link
           #downloadLink("instructionspdf",label="Download Instructions (pdf)"),
           # Upload data from csv, upload data from RData, use example data
           radioButtons('data_file_type','Upload your data or start with the example file',
                        c('Upload Data'="upload",
                         #'START RData file'="previousrdata",
                          'Example Data'="examplecounts"
                        ),selected = "examplecounts"),
        # # Conditional panels appear based on input.data_file_type selection
        # conditionalPanel(condition="input.data_file_type=='previousrdata'",
        #                  fileInput('rdatafile','Upload START Generated RData File'),
        #                  conditionalPanel("output.fileUploaded",
        #                                   h4(strong("Check data contents then click:")))
        # ),
         conditionalPanel(condition="input.data_file_type=='upload'",
                          radioButtons("inputdat_type","Input Data Type:",
                                     # c("Gene Expression or Gene Counts"="expression_only",
                                     #   "DEG results from other tool"="analyzed")),
                                     c("Gene Expression "="expression_only",
                                       "Transcript Counts"="expression_only")),
                          conditionalPanel(
                            condition="input.inputdat_type=='expression_only'",
                            downloadLink("example_counts_file",label="Download Example Count File"),
                            p(""),
                           # img(src="examplecounts.png",width="100%"),
                           # tags$ul(
                           #   tags$li("File must have a header row."), 
                           #   tags$li("First/Left-hand column(s) must be gene identifiers."), 
                           #   tags$li("Format expression column names as GROUPNAME_REPLICATE#: Group1_1, Group1_2, Group2_1, Group2_2...")
                           # ),
                            radioButtons("analysis_method","Select DEG Analysis Method",
                                         c("Limma"="voom",
                                           "edgeR"="edgeR",
                                           "DESeq2"="linear_model"
                                           ))
                          ),
                          conditionalPanel(condition="input.inputdat_type=='analyzed'",
                                           downloadLink("example_analysis_file",label="Download Example Analysis Results File"),
                                           p(" "), 
                                          #  img(src="exampleanalysisdata.png",width="100%"),
                                          # tags$ul(
                                          #   tags$li("File must have a header row."), 
                                          #   tags$li("Format expression column names as GROUPNAME_REPLICATE#: Group1_1, Group1_2, Group2_1, Group2_2..."),
                                          #   tags$li("Number & order of fold changes must MATCH p-value number & order.")
                                          # )
                          ),
                          fileInput('datafile', 'Choose File Containing Data (.CSV)',
                                    accept=c('text/csv', 
                                             'text/comma-separated-values,text/plain', 
                                             '.csv')),
                          conditionalPanel(condition="input.inputdat_type=='analyzed'",
                                           #checkboxInput('header', 'Header', TRUE),
                                           selectInput("c_geneid1",label="First column # with gene IDs",choices=NULL),
                                           selectInput("c_geneid2",label="Last column # with gene IDs",choices=NULL),
                                           selectInput("c_expr1",label="First column # with expression values",choices=NULL),
                                           selectInput("c_expr2",label="Last column # with expression values",choices=NULL),
                                           selectInput("c_fc1",label="First column # with fold changes",choices=NULL),
                                           selectInput("c_fc2",label="Last column # with fold changes",choices=NULL),
                                           radioButtons("isfclogged",label="Is FC logged? (if false, expression values will be log2-transformed for visualization)",choices=c("Yes (Leave it alone)","No (Log my data please)"),selected="No (Log my data please)"),
                                           selectInput("c_pval1",label="First column # with p-values",choices=NULL),
                                           selectInput("c_pval2",label="Last column # with p-values",choices=NULL),
                                           selectInput("c_qval1",label="First column # with adjusted p-values (can be same columns as p-values)",choices=NULL),
                                           selectInput("c_qval2",label="Last column # with adjusted p-values (can be same columns as p-values)",choices=NULL)
                          )
         ),
           conditionalPanel("output.fileUploaded",
                            actionButton("upload_data","Submit Data",
                                         style="color: #000000; background-color: #c64fdb; border-color: #000000"))
         )#,
         # add reference group selection
         # missing value character?
         ),#column
         ## ==================================================================================== ##
         ## Right hand column shows data input DT and data analysis result DT
         ## ==================================================================================== ##
         column(8,
                bsCollapse(id="input_collapse_panel",open="data_panel",multiple = FALSE,
                           bsCollapsePanel(title="Uploaded Data",
                                           value="data_panel",
                                           div(style="overflow-x: auto;",   # added div to control table horizontal overflow
                                           dataTableOutput('countdataDT')
                                           )
                                          ),
                           bsCollapsePanel(title="Differential Gene Expression Analysis Results",
                                           value="data_panel",
                                           downloadButton('downloadResults_CSV','Download DEG Analysis Result'),
                                           br(),
                                           p(""),
                                         #  downloadButton('downloadResults_RData',
                                         #                 'Save Results as START RData File for Future Upload',
                                         #                 class="mybuttonclass"),
                                         div(style="overflow-x: auto;",   # added div to control table horizontal overflow
                                         dataTableOutput('analysisoutput')
                                         ),
                                         tags$head(tags$style(".mybuttonclass{background-color:#c64fdb;} .mybuttonclass{color: #000000;} .mybuttonclass{border-color: #000000;}"))
                           ) #bsCollapsePanel
                ), #bscollapse
         )#column
         )#fluidrow
)#tabpanel
