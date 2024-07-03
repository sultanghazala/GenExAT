## ==================================================================================== ##
# App Name: GenExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##

observe({
  
  print("server-dotplot-update")
  
  data_analyzed = analyzeDataReactive()
  tmpgeneids = data_analyzed$geneids
  data_analyzedgenes = as.character(unlist(tmpgeneids))
  tmpgroups = data_analyzed$group_names
  #data_analyzedgenes = c("a","b","c")

  tmpynames = data_analyzed$data_long%>%select(-unique_id,-sampleid,-group,-one_of("rep"))%>%colnames()
  updateSelectizeInput(session,'sel_gene',
                       choices= data_analyzedgenes,server=TRUE)
  updateCheckboxGroupInput(session,'sel_group',
                           choices=tmpgroups, selected=tmpgroups)
  updateRadioButtons(session,'sel_gene_header',
                     choices=colnames(tmpgeneids))
  updateRadioButtons(session,"ytype",
                     choices=sort(tmpynames,decreasing = TRUE))
})

#Show dotplot	
output$dotplot <- renderPlotly({
  
  print("generating box plot")
  
  validate(need(length(input$sel_gene)>0,"Please select a gene."))
  validate(need(length(input$sel_group)>0,"Please select group(s)."))
  
  data_analyzed = analyzeDataReactive()
  data_long = data_analyzed$data_long
  geneids = data_analyzed$geneids
  if (names(dev.cur()) != "null device") dev.off()
  pdf(NULL)
  p=dotplot_fun(data_long = data_long,geneids = geneids,
              genelabel=input$sel_gene_header,
              sel_group=input$sel_group,sel_gene=input$sel_gene,
              #log2y=input$log2cpm_checked,
              ytype=input$ytype)
}) #renderPlot


#Based on dotplot filters create data

DataDotplotReactive <- reactive({
  print("DataDotplotReactive")
  data_analyzed = analyzeDataReactive()
  
  subdat = dotplot_dat(data_long = data_analyzed$data_long,geneids = data_analyzed$geneids,
                       sel_group=input$sel_group,sel_gene=input$sel_gene,
                       ytype=input$ytype)
  return(subdat)
})

output$dat_dotplot <- renderDataTable({
  tmpdat = DataDotplotReactive()
  tmpdat[,sapply(tmpdat,is.numeric)] <- signif(tmpdat[,sapply(tmpdat,is.numeric)],3)
  datatable(tmpdat)
}
)			

output$downloadSubsetData <- downloadHandler(
  filename = c('boxplot_data.csv'),
  content = function(file) {write.csv(DataDotplotReactive(), file, row.names=FALSE)}
)
