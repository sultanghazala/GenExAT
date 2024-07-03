## ==================================================================================== ##
# App Name: GenExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##

tabPanel("Data Filter", 
         ## ==================================================================================== ##
         ## Left hand column has the filter settings and options
         ## ==================================================================================== ##
         fluidRow(column(4,wellPanel(
           #h5("Note: this does not redo any analysis, it merely filters the data already analyzed based on gene identifiers or sample/group names."),
           selectizeInput("datafilter_groups", label="Select Groups",
                          choices=NULL,
                          multiple=TRUE),
           selectizeInput("datafilter_samples", label="Select Samples",
                          choices=NULL,
                          multiple=TRUE),
           checkboxInput("datafilter_genelist","Filter by gene names",value=FALSE), #upload a file of gene names
           conditionalPanel("input.datafilter_genelist==true",
                            selectizeInput("datafilter_gene_select","Search gene names.",choices=NULL,multiple=TRUE),
                            fileInput('datafilter_gene_file', 'Or, upload file containing gene IDs\n(one row per gene)',
                                      accept=c('text/csv', 
                                               'text/comma-separated-values,text/plain', 
                                               '.csv'))
           ),

           checkboxInput("datafilter_signif","Filter by significance",
                         value=FALSE),
           conditionalPanel(condition="input.datafilter_signif==true",
                            selectizeInput("datafilter_selecttest","Select Test",choices=NULL),
                            numericInput("datafilter_fccut",label="Minimum absolute value of Log2 Fold Change",
                                         min=0,max= 20,value=1),
                            radioButtons("datafilter_logfc_dir",label="Direction of Fold Change",
                                         choices=c("Both"="both","Up in first group"="up","Down in first group"="down")),
                            numericInput("datafilter_qvaluecut",label="Maximim Q-value (FDR)",
                                         min=0,max= 1,value=1),
                            numericInput("datafilter_pvaluecut",label="Maximim P-value",
                                         min=0,max= 1,value=1)
           ),
           checkboxInput("datafilter_expr","Filter by expression",
                         value=FALSE),
           conditionalPanel(condition="input.datafilter_expr==true",
                            radioButtons("datafilter_selectexpr",label="Select Expression Value",choices=""),
                            numericInput("datafilter_exprmin",label="Filter by minimum expression (remove genes with minimum expression lower than this value)",
                                         min=0,max= 1000,value=1),
                            numericInput("datafilter_exprmax",label="Filter by maximum expression (remove genes with maximum expression lower than this value)",
                                         min=0,max= 1000,value=1)
           )
           
           
         )#wellpanel
         ),#column
         ## ==================================================================================== ##
         ## Right hand column shows filtered data
         ## ==================================================================================== ##
         column(8,wellPanel(
           h4(textOutput("nrow_filterdata")),
           downloadButton('download_filtered_data_csv','Save Filtered Result'),
           br(),
           p(""),
           div(style="overflow-x: auto;",   # added div to control table horizontal overflow
           dataTableOutput('filterdataoutput')
           ),
         )#wellpanel
         )#column
         )#fluidRow
        
)
