## ==================================================================================== ##
# App Name: GenExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##


tabPanel("Volcano Plots",  
         fluidRow(column(4,wellPanel(
           conditionalPanel("input.analysisres_tabset=='Volcano Plot'",
                            selectizeInput("analysisres_test", label="Select Test for Volcano Plot",
                                           choices=NULL),
                            numericInput("analysisres_fold_change_cut",
                                         label="Choose log2(Fold Change) Threshold\n(based on your input FCs, 
                       or fitted FCs if your data has been analyzed by START)",min= 0, max=20,value=1),
                            numericInput("analysisres_pvalcut",
                                         label="Choose P-value Threshold",min=0,max=1,value=0.05),
                            numericInput("analysisres_fdrcut",
                                         label="Choose adjusted P-value (or FDR) Threshold",min=0,max=1,value=0.05)
           ),#conditionalpanel
           
           conditionalPanel("input.analysisres_tabset=='Scatterplot of Fold Changes'",
                            selectizeInput("analysisres_groups",label="Select Groups for Scatterplot",
                                           choices=NULL,
                                           multiple=TRUE,options = list(maxItems = 2)),
                            radioButtons("scattervaluename",label="Select Scatterplot Value",choices=""),
                            radioButtons("scattercolor",label="Select Color Factor Value",
                                         choices=c("Sign of FC",
                                                   "logFC","p-value","adjusted p-value (q-value)",
                                                   "p-value < .1","q-value < .1",
                                                   "-log10(p-value)","-log10(q-value)"),
                                         selected = "-log10(p-value)"),
                            radioButtons("scatterresultsname",label="Select Test for Color Factor",
                                         choices=""),
                            colourInput("scattercolor_low",label="Select Color - Low Values","blue",
                                        showColour = "background"),
                            colourInput("scattercolor_hi",label="Select Color - High Values","orange",
                                        showColour = "background")
                            
           ),#conditionalpanel
           selectizeInput("analysisres_genes",label="Select Genes to Highlight",
                          choices=NULL,
                          multiple=TRUE)
         )#,
         #img(src="KCardio_CMYK_4C_pos_small.jpg",height=150,width= 275,align="right")	
         ),#column
         column(8,
                tabsetPanel(id="analysisres_tabset",
                            tabPanel(title="Volcano Plot",
                                     #h5(textOutput("corPR")),
                                     #uiOutput("volcanoplot_2groups_ggvisUI"),
                                     #ggvisOutput("volcanoplot_2groups_ggvis")  
                                     plotlyOutput("volcanoplot",height=600)
                            ),#tabPanel
                            tabPanel(title="Scatterplot of Fold Changes",
                                     #h5(textOutput("corPR")),
                                     # uiOutput("scatterplot_fc_2groups_ggvisUI"),
                                     # ggvisOutput("scatterplot_fc_2groups_ggvis")  
                                     plotlyOutput("scatterplot",height=600)
                            )#tabPanel
                )#tabsetPanel
         )#column
         )#fluidrow
) #END tabPanel
