## ==================================================================================== ##
# App Name: GenExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##


# package loading
library(shiny)
library(shinyjs)
library(shinythemes)
library(DT)
library(ggplot2)
library(heatmaply)
library(car)
library(nortest)
library(tseries)
library(RcmdrMisc)
library(lmtest)

linebreaks <- function(n){HTML(strrep(br(), n))}

#ui <- (fluidPage(theme = shinytheme("cerulean"),
fluidPage(theme = shinytheme("cerulean"), # style='border-right: 1px solid black; border-left: 1px solid black',
                 useShinyjs(),
                 tags$head(
                   tags$style(
                     HTML("
                          body{
                              min-width:1300px; max-width: 1300px;
                              #min-height:1000px;
                              margin: auto;
                              overflow: auto;
                              border-color: #000000;
                              background-color: #e8f4f8;
                              #background:url('www/bg3.jpg');
                              border-right: 1px solid grey; border-left: 1px solid grey;
                              #border: 1px #D3D3D3;
                            }
                          
                          .titlePane
                            {
                               background-color: #e8f4f8;
                               // background:url('network.gif'); 
                               // background:url('network-img-edited.png');
                               background-repeat: no-repeat;
                               background-size: 18% 100%;//
                            }
                          /* Change the navbar background color */
                                .navbar-default 
                                {
                                  #background-color: #ffffff;
                                  background-image: url(wavy.gif);
                                  background-size: cover;
                                }
                          /* Change the active tab color  */
                                .navbar-default .navbar-nav > li > a:hover
                                {
                                     #background-color: #b30000;
                                     #color: #b30000;
                                     border-radius: 1%;  /* if i want ellipse to appear ellipse */
                                }
                                
                               .navbar-default .navbar-nav > li > a:focus
                               {
                                     # border-radius: 30%;  /* if i want ellipse to appear ellipse */
                               },
                           
                               .navbar-default .navbar-nav > .active > a,
                               .navbar-default .navbar-nav > .active > a:hover,
                               .navbar-default .navbar-nav > .active > a:focus 
                               {
                                 background-color: #0000cc;
                                 color: #ffffff;
                               }
                            
                               /* Add equal space between tab panel names */
                               .nav-tabs > li > a 
                               {
                                 padding-left: 20px;
                                 padding-right: 20px;
                               }
                               
                               /* Make all navbar tabs equal in size */
                                .navbar-default .navbar-nav > li {
                                flex: 1;
                                text-align: center;
                                }
                              
                              /* CSS for second navbar */
                               #navbar2 {
                                 #width: 100%;
                                 #background-color: #73a839; /* #12A293; Change to your desired color */
                                 color: #ffffff;
                                 background-size: cover;
                                 #border-radius: 30%;
                                 background-size: 18% 100%;
                               }
                               .navbar2 .navbar2 > .active > a:focus 
                               {
                                 background-color: #0000cc;
                                 color: #ffffff;
                               }
                             ")   #HTML closing
                     )            #tags$style
            ),                    #tags$head
                 
                 
       
                 titlePanel("Gene Expression Analytics",
                            title =
                              div(
                                img(src = "logo_genomo2.png", href="https://www.google.com", 
                                    height = 150, width = 150,
                                    style = "margin:0px 25px"),
                                "GenExAT: Gene Expression Analysis Tool",style = "margin:0px 18px",
                                img(src = "bioinfo.PNG",
                                    height = 130, width = 460,
                                    style = "margin:0px 0px")
                                 )
                            ),
                 
                 navbarPage(
                            "GenExAT",
                            
                            id = "tabs",
                   
                            tabPanel(strong("Home"),
                                     icon = icon("home"), #class = "fa-2x"), 
                                     fluidRow(#column(tags$img(src="bioinfo.PNG",width="220px",height="260px"),width=2),
                                       column(
                                         br(),
                                         p("GenExAT app is a gene expression analysis tool to the analyze and interpret the insights from biological data.
                                         It primarily focusses on the genomics and tranbscriptomics data analysis", 
                                           strong("But do not worry!"), "you will find alternatives to learn all these technical aspects independently.",
                                           style="text-align:justify;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                                         br(),
                                         p("GenExAT will enable to perform multiple NGS data analysis and visualization for microarray, RNA-seq (NGS-based transcriptome analysis) and Single cell (scRNA) data.",
                                           style="text-align:justify;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                                         br(),
                                         p("The NGS data analysis process includes six main steps:",
                                         br(), 
                                         " 1. library preparation",
                                         br(),
                                         " 2. reads sequencing", 
                                         br(),
                                         " 3. reads mapping on reference geneome",
                                         br(),
                                         " 4. differential gene analysis",
                                         br(),
                                         " 5. visualization",
                                         br(),
                                         " 6. results interpretation.",
                                           style="text-align:justify;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                                         br(),
                                         p("For more information please contact the",em("developers"),
                                           a(href="https://brcafemdb-amu.in/about-us.php#contact", "Here",target="_blank"),
                                           style="text-align:left;color:black"), 
                                         width=6),
                                       
                                       
                                       column(
                                         tags$img(src="GenExAT_Home.png",width="560px",height="420px", style = "margin:0px 30px"),
                                     
                                         width=6)),
                                     
                                     
                                  #   hr(),
                                  #   
                                  #   p("© Developed by G. Sultan, S. Zubair, Dept. of CS, Aligarh Muslim University, Aligarh, India | All Rights Reserved"),
                                     style="text-align:center; font-family: timesbackground-color:cyan"),
                            
                                  # hr(),
                            
                            
                            #----------------------------------------------------------------------------#
                            #  1- Microarray ###
                            #----------------------------------------------------------------------------#  
                            tabPanel(strong("Microarray"), 
                                     #tags$style(HTML(".tabbable > .nav > li[class=active] > a {background-color: #ff9999; color:black}")),
                                     
                                    # tabsetPanel(
                                       
                                     #  tabPanel("About Microarray",
                                     #           br(),
                                              fluidRow(
                                                  column(
                                                    h4(p(strong("Microarray Data Analysis"),
                                                         style="text-align:left;color:black;background-color:lavender;padding:15px;border-radius:10px")),
                                                    p("Microarrays can be used in many types of experiments including genotyping, epigenetics, translation profiling, and gene expression profiling. Gene expression profiling is by far the most common use of microarray technology. Both one- and two-color microarrays can be used for this type of experiment. The process of analyzing gene expression data is similar for both types of microarrays and involves feature extraction, quality control, normalization, differential expression analysis, and biological interpretation of the results.",
                                                      style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                                    br(),
                                                    
                                                    p(" Microarrays are used to measure the expression levels of large numbers of genes simultaneously or to genotype multiple regions of a genome. Each DNA spot contains picomoles (10−12 moles) of a specific DNA sequence, known as probes (or reporters or oligos). These can be a short section of a gene or other DNA element that are used to hybridize a cDNA or cRNA (also called anti-sense RNA) sample (called target) under high-stringency conditions. Probe-target hybridization is usually detected and quantified by detection of fluorophore-, silver-, or chemiluminescence-labeled targets to determine relative abundance of nucleic acid sequences in the target. The original nucleic acid arrays were macro arrays approximately 9 cm × 12 cm and the first computerized image based analysis was published in 1981 by Patrick O. Brown.",
                                                      a(href="https://en.wikipedia.org/wiki/Microarray", "Read More",
                                                        style="color:blue; text-align:center"),
                                                      style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                                    # p("These files contain the intensity values measured for each probe on a RNA-seq chip. Each probe represents a specific gene or genomic sequence, and the intensity values reflect the amount of target molecules (such as mRNA-seq) that have hybridized to each probe during the RNA-seq experiment.",
                                                    #   style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                                    br(),
                                                    
                                                    h4(p(strong("Start Analysis"), 
                                                         actionLink("go_to_analysis", icon("tools")),
                                                         #style="text-align:left;color:black;background-color:#73a839;padding:15px;border-radius:10px")),#width:150px; 
                                                    )),#width:150px; 
                                                    
                                                    width=7),
                                                   
                                                  br(),
                                                  column(tags$img(src="microarray-chip.PNG",width="480px",height="300px",
                                                                  style="border: 0px solid black; margin-left: 0px"),
                                                         br(),
                                                         br(),
                                                         width = 5)),
                            ),  # tabPanel main Microarray
                        
                        
                        
                        #----------------------------------------------------------------------------#
                        #  2 - RNA-Seq ###
                        #----------------------------------------------------------------------------#  
                        tabPanel(strong("RNA-Seq"), tags$style(HTML(".tabbable > .nav > li[class=active] > a {background-color: #ff9999; color:black}")),
                                 #tags$style(HTML(".tabbable > .nav > li[class=active] > a {background-color: #ff9999; color:black}")),
                                 
                                 # tabsetPanel(
                                 
                                 #  tabPanel("About RNA-sequencing",
                                 #           br(),
                                 fluidRow(
                                   column(
                                     h4(p(strong("RNA sequence(s)"),
                                          style="text-align:left;color:black;background-color:lavender;padding:15px;border-radius:10px")),
                                     p("RNA-seqs can be used in many types of experiments including genotyping, epigenetics, translation profiling, and gene expression profiling. Gene expression profiling is by far the most common use of RNA-seq technology. Both one- and two-color RNA-seqs can be used for this type of experiment. The process of analyzing gene expression data is similar for both types of RNA-seqs and involves feature extraction, quality control, normalization, differential expression analysis, and biological interpretation of the results.",
                                       style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                     br(),
                                     
                                     h4(p(strong("RNA-seq over Microarrays"),
                                          style="text-align:left;color:black;background-color:lavender;padding:15px;border-radius:10px")),
                                     p("Prior to RNA-Seq, gene expression studies were done with hybridization-based microarrays. Issues with microarrays include cross-hybridization artifacts, poor quantification of lowly and highly expressed genes, and needing to know the sequence a priori. Due to these technical issues, transcriptomics transitioned to sequencing-based methods. These progressed from Sanger sequencing of Expressed sequence tag libraries, to chemical tag-based methods (e.g., serial analysis of gene expression), and finally to the current technology, next-gen sequencing of complementary DNA (cDNA), notably RNA-Seq.", 
                                       a(href="https://en.wikipedia.org/wiki/RNA-seq", "Read More",
                                         style="color:blue; text-align:center"),
                                       style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                    # p("These files contain the intensity values measured for each probe on a RNA-seq chip. Each probe represents a specific gene or genomic sequence, and the intensity values reflect the amount of target molecules (such as mRNA-seq) that have hybridized to each probe during the RNA-seq experiment.",
                                    #   style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                     br(),
                                     
                                    h4(p(strong("Start Analysis"), 
                                         actionLink("go_to_analysis", icon("tools")),
                                         #style="text-align:left;color:black;background-color:#73a839;padding:15px;border-radius:10px")),#width:150px; 
                                         )),#width:150px; 
                                    
                                     width=7),
                                 
                                   
                                   column(tags$img(src="RNA-Seq.png",width="480px",height="400px",
                                                   style="border: 0px solid black; margin-left: 15px"),
                                          br(),
                                   width = 5)),

                                 
                        ),  # tabPanel main RNA-seq

                 
                        #----------------------------------------------------------------------------#
                        #  3 - scRNA ###
                        #----------------------------------------------------------------------------#  
                        tabPanel(strong("scRNA-Seq"),
                                 #tags$style(HTML(".tabbable > .nav > li[class=active] > a {background-color: #ff9999; color:black}")),
                                 
                                 fluidRow(
                                   column(
                                     h4(p(strong("Single cell RNA-Sequencing"),
                                          style="text-align:left;color:black;background-color:lavender;padding:15px;border-radius:10px")),
                                     p("Single-cell sequencing examines the nucleic acid sequence information from individual cells with optimized next-generation sequencing technologies, providing a higher resolution of cellular differences and a better understanding of the function of an individual cell in the context of its microenvironment. In cancer, sequencing the DNA of individual cells can give information about mutations carried by small populations of cells. In development, sequencing the RNAs expressed by individual cells can give insight into the existence and behavior of different cell types. In microbial systems, a population of the same species can appear genetically clonal. Still, single-cell sequencing of RNA or epigenetic modifications can reveal cell-to-cell variability that may help populations rapidly adapt to survive in changing environments.",
                                       style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                     br(),
                                     
                                     # h4(p(strong("File format"),
                                     #      style="text-align:left;color:black;background-color:lavender;padding:15px;border-radius:10px")),
                                     p("A typical human cell consists of about 2 x 3.3 billion base pairs of DNA and 600 million mRNA bases. Usually, a mix of millions of cells is used in sequencing the DNA or RNA using traditional methods like Sanger sequencing or next generation sequencing. By deep sequencing of DNA and RNA from a single cell, cellular functions can be investigated extensively. Like typical next-generation sequencing experiments, single-cell sequencing protocols generally contain the following steps: isolation of a single cell, nucleic acid extraction and amplification, sequencing library preparation, sequencing, and bioinformatic data analysis. It is more challenging to perform single-cell sequencing than sequencing from cells in bulk.",
                                       a(href="https://en.wikipedia.org/wiki/Single-cell_sequencing", "Read More",
                                         style="color:blue; text-align:center"),
                                       style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                     # p("These files contain the intensity values measured for each probe on a RNA-seq chip. Each probe represents a specific gene or genomic sequence, and the intensity values reflect the amount of target molecules (such as mRNA-seq) that have hybridized to each probe during the RNA-seq experiment.",
                                     #   style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                     br(),
                                     
                                     h4(p(strong("Start Analysis"), 
                                          actionLink("go_to_analysis", icon("tools")),
                                          #style="text-align:left;color:black;background-color:#73a839;padding:15px;border-radius:10px")),#width:150px; 
                                     )),#width:150px; 
                                     
                                     width=7),
                                     
                                   
                                   column(tags$img(src="scRNA.png",width="480px",height="380px",
                                                   style="border: 0px solid black; margin-left: 15px"),
                                          br(),
                                          br(),
                                          width = 5)),
                                 
                        ),  # tabPanel main scRNA   
                        
                        
                        #----------------------------------------------------------------------------#
                        #  3 - Exome ###
                        #----------------------------------------------------------------------------#  
                        tabPanel(strong("Exome-Seq"),
                                 #tags$style(HTML(".tabbable > .nav > li[class=active] > a {background-color: #ff9999; color:black}")),

                                 fluidRow(
                                   column(
                                     h4(p(strong("Exome-Sequencing"),
                                          style="text-align:left;color:black;background-color:lavender;padding:15px;border-radius:10px")),
                                     p("Exome sequencing, also known as whole exome sequencing (WES), is a genomic technique for sequencing all of the protein-coding regions of genes in a genome (known as the exome). It consists of two steps: the first step is to select only the subset of DNA that encodes proteins. These regions are known as exons—humans have about 180,000 exons, constituting about 1% of the human genome, or approximately 30 million base pairs. The second step is to sequence the exonic DNA using any high-throughput DNA sequencing technology.",
                                       style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                     br(),
                                     
                                     p("While many more genetic changes can be identified with whole exome and whole genome sequencing than with select gene sequencing, the significance of much of this information is unknown. Because not all genetic changes affect health, it is difficult to know whether identified variants are involved in the condition of interest. Sometimes, an identified variant is associated with a different genetic disorder that has not yet been diagnosed."),
                                     
                                    h4(p(strong("Exome-seq vs.RNA-seq"),
                                     style="text-align:left;color:black;background-color:lavender;padding:15px;border-radius:10px")),
                                    p("WES sequencing refers to genomic DNA sequencing that is enriched for exonic regions. RNA sequencing, on the other hand, may or may not be enriched (for example for polyadenylated transcripts).",
                                       a(href="https://en.wikipedia.org/wiki/Single-cell_sequencing", "Read More",
                                         style="color:blue; text-align:center"),
                                       style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                     # p("These files contain the intensity values measured for each probe on a RNA-seq chip. Each probe represents a specific gene or genomic sequence, and the intensity values reflect the amount of target molecules (such as mRNA-seq) that have hybridized to each probe during the RNA-seq experiment.",
                                     #   style="text-align:justify;color:black"),#;background-color:papayawhip;padding:15px;border-radius:10px"),
                                     br(),
                                     
                                    h4(p(strong("Start Analysis"), 
                                         actionLink("go_to_analysis", icon("tools")),                  
                                         )),
                                    #style="text-align:left;color:black;background-color:#73a839;padding:15px;border-radius:10px")),#width:150px; 

                                     width=7),
                                   
                                   
                                   column(tags$img(src="whole_exome_sequencing.jpg",width="480px",height="450px",
                                                   style="border: 0px solid black; margin-left: 15px"),
                                          br(),
                                          br(),
                                          width = 5)),
                                
                        ),  # tabPanel main Exome0-seq   
                        
                                                
                        
                      #----------------------------------------------------------------------------#
                      #  FAQs (Frequently Asked Questions)  
                      #----------------------------------------------------------------------------#
                      
                      tabPanel(strong("Frequently Asked Questions"),
                               
                               column(width=12,
                                      p(strong("How does GenExAT App work?"),
                                        br(),
                                        "GenExAT is abbreviated for Gene Expression Analysis Tool. It is a web application that perform analysis based on different types of biological data, including microarray and bulk RNA-seq, single-cell RNA-seq and Exome-seq data. ",
                                        br(),
                                        "GenExAT utilizes expression data to perform bioinformatics analysis and output the estimates in the form of tables and figures."),
                                        br(),
                                      
                                      p(strong("Which data formats GenExAT accept?"),
                                      br(),
                                          "GenExAT accepts data in both excel or CSV (comma seperated values) format."),
                                      br(),
                                          "- File must have a header row."),
                                     br(),
                                          "- First/Left-hand column(s) must be gene identifiers."),
                                     br(),
                                          "- Format expression column names as `GROUPNAME_REPLICATE#`, e.g. `Treat_1, # Treat_2,Treat_3, Control_1, Control_2."),

                                    br(),
                                    p(strong("Paired-end sequencing:"),"A process of sequencing from both ends of a DNA fragment in the same run.")
                                      br(),
                                      
                               ), #column closing
                               
                               #fluidRow(p("See More",a(href="https://www.biosyn.com/bioinformatics.aspx", "Here",target="_blank"),
                               #           style="text-align:left;color:black")#,
                                        #  hr(),
                                        #  p("© Developed by G. Sultan, S. Zubair, Dept. of CS, Aligarh Muslim University, Aligarh, India | All Rights Reserved",
                                        #    style="text-align:center; font-family: timesbackground-color:cyan"),
                                        #  hr()
                               )
                      ), #glossary tabPanel
                      
                      

                      
                      #----------------------------------------------------------------------------#
                      #  Glossary  
                      #----------------------------------------------------------------------------#
                      
                      tabPanel(strong("Glossary"),
                               icon = icon("book"), #class = "fa-2x"), 
                               column(width=12,
                                      h3("Glossary"),
                                      hr(),
                                      p(strong("Bioinformatics:"),"The field of endeavor that relates to the collection, organization and analysis of large amounts of biological data using networks of computers and databases (usually with reference to the genome project and DNA sequence information)."),
                                      br(),
                                      p(strong("Sequencing reads:"),"The data strings of A,T, C, and G bases corresponding to each DNA fragment in a sequencing library. In Illumina technology, when a library is sequenced, each DNA fragment produces a cluster on the surface of a flow cell and each cluster generates a single sequencing read. (For example, 1 million clusters on a flow cell would produce 1 million single reads and 2 million paired-end reads.) Read lengths can range from 25 bp to 300 bp or higher depending on application needs."),
                                      br(),
                                      p(strong("Paired-end sequencing:"),"A process of sequencing from both ends of a DNA fragment in the same run."),
                                      br(),
                                      p(strong("Reference genome:"),"A reference genome is a fully sequenced and assembled genome that acts as a scaffold against which new sequence reads are aligned and compared. Typically, reads generated from a sequencing run are aligned to a reference genome as a first step in data analysis. Examples of reference genomes include hg19 and hg38."),
                                      br(),
                                      p(strong("Quality score (Q-score):"), "A metric in NGS that predicts or estimates the probability of an error in base calling. A quality score (Q-score) serves as a compact way to communicate very small error probabilities. A high Q-score implies that a base call is more reliable and less likely to be incorrect."),
                                      br(),
                                      p(strong("cDNA (complementary DNA):"), "A DNA strand copied from mRNA using reverse transcriptase. A cDNA library represents all of the expressed DNA in a cell."),
                                      br(),
                                      p(strong("Ribonucleic acid (RNA):"), "A category of nucleic acids in which the component sugar is ribose and consisting of the four nucleotides Thymidine, Uracil, Guanine, and Adenine. The three types of RNA are messenger RNA (mRNA), transfer RNA (tRNA) and ribosomal RNA (rRNA)."),
                                      # style="border: 10px solid transparent;border-image: url(border4.png) 30 round")
                                      br(),
                                      
                               ), #column closing
                               
                               fluidRow(p("See More",a(href="https://www.biosyn.com/bioinformatics.aspx", "Here",target="_blank"),
                                          style="text-align:left;color:black")#,
                                        #  hr(),
                                        #  p("© Developed by G. Sultan, S. Zubair, Dept. of CS, Aligarh Muslim University, Aligarh, India | All Rights Reserved",
                                        #    style="text-align:center; font-family: timesbackground-color:cyan"),
                                        #  hr()
                               )
                      ), #glossary tabPanel


                      #----------------------------------------------------------------------------#
                      #  Help  
                      #----------------------------------------------------------------------------#
                      tabPanel(strong("Help"),       
                               column(width=12,
                                      p("For more information please contact the",em("developers"),
                                           a(href="https://brcafemdb-amu.in/about-us.php#contact", "Here",target="_blank"),
                                           style="text-align:left;color:black"), 
                                      br(),
                                      
                               ), #column closing
                      ), # help tabPanel
                      
                      


                      #----------------------------------------------------------------------------#
                      #  4 - Data Analysis ###
                      #----------------------------------------------------------------------------#  
                      tabPanel(
                        title = " ",
                               #tags$style(HTML(".tabbable > .nav > li[class=active] > a {background-color: #0FC7CF; color:#0FC7CF}")),
                               
                               # collects all of the tab UIs
                               
                        #source("helpers.R"),
                               
                        navbarPage(id = "navbar2",
                                 # theme = "bootstrap.min.united.updated.css",
                                 # United theme from http://bootswatch.com/
                                 title = "",
                                 #    source("ui-tab-landing.R",local=TRUE)$value,
                                 ## =========================================================================== ##
                                 ## DOWNLOAD DATA TABS
                                 ## =========================================================================== ##
                                 source("ui-tab-inputdata.R",local=TRUE)$value,
                                 source("ui-tab-filterdata.R",local=TRUE)$value,
                                 ## =========================================================================== ##
                                 ## Visualization TABS
                                 ## =========================================================================== ##
                                 source("ui-tab-dotplot.R",local=TRUE)$value,
                                 source("ui-tab-analysisres.R",local=TRUE)$value,
                                 source("ui-tab-heatmap.R",local=TRUE)$value,
                                 source("ui-tab-samplegroupplots.R",local=TRUE)$value,
                               )  # nav
                      ), #tabPanel main Data Analysis
                         
                    
                      ## ==================================================================================== ##
                      ## FOOTER 
                      ## ==================================================================================== ##              
                      footer=p(hr(),p("© Developed by G. Sultan, S. Zubair, Dept. of CS, Aligarh Muslim University, Aligarh, India | All Rights Reserved",
                                      style="text-align:center; font-family: timesbackground-color:cyan"),
                               hr(),
                               ),
                      ## ==================================================================================== ##
                      ## end
                      ## ==================================================================================== ## 
                      tags$head(includeScript("google-analytics.js")) 
                      
                          
            ) # navbarPage
            
        ) # fluidPage

