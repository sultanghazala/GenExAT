## ==================================================================================== ##
# App Name: GenExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##


# update expression names for plotting
observe({
  print("server-samplegroupplots-update-yname")
  data_analyzed = analyzeDataReactive()
  
  #ADD
  tmpgroups = data_analyzed$group_names
  tmpsamples = as.character(data_analyzed$sampledata$sampleid)
  tmpdat = data_analyzed$results
  tmptests = unique(as.character(tmpdat$test))
  #END ADD
  
  tmpdatlong = data_analyzed$data_long
  tmpynames = tmpdatlong%>%select(-unique_id,-sampleid,-group,-one_of("rep"))%>%colnames()
  
  #ADD
  if("count"%in%tmpynames) tmpynames = tmpynames[-match("count",tmpynames)]
  #END ADD
  
  updateRadioButtons(session,'groupplot_valuename',
                     choices=sort(tmpynames,decreasing = TRUE))
  updateSelectizeInput(session,'sampleres_groups',
                       choices=tmpgroups, selected=tmpgroups)
  updateSelectizeInput(session,'sampleres_samples',
                       choices=tmpsamples, selected=tmpsamples)
})

#update list of groups
observe({
  print("server-samplegroupplots-update-groups")
  data_analyzed = analyzeDataReactive()
  tmpgroups = data_analyzed$group_names
  tmpsamples = as.character(data_analyzed$sampledata$sampleid)
  updateSelectizeInput(session,'sampleres_groups',
                       choices=tmpgroups, selected=tmpgroups)
  updateSelectizeInput(session,'sampleres_samples',
                       choices=tmpsamples, 
					   selected=tmpsamples)
})

# sampleres_groups = intersect selected groups with sample names 
# after selecting group
observe({
  print("server-sampleplots-update-samples")
  data_analyzed = analyzeDataReactive()
  tmpselected = input$sampleres_groups
  print(tmpselected)
  if(!is.null(tmpselected)) {
    if(!(tmpselected[1]=="")) {
      tmpsampledata = data_analyzed$sampledata
      tmpsampledata = data_analyzed$sampledata%>%filter(group%in%tmpselected)
      tmpsamples = as.character(tmpsampledata$sampleid) 
	  print(tmpsamples)
	  
  updateSelectizeInput(session,'sampleres_samples',
                       choices=tmpsamples, selected=tmpsamples)
    }
  }
}, priority = 2)


fun_gene_pheatmap <- reactive({
  print("render gene_pheatmap")
  data_analyzed = analyzeDataReactive()
  data_results = data_analyzed$results
  geneids = data_analyzed$geneids
  sampledata = data_analyzed$sampledata
  
  tmpgroups = input$sampleres_groups
  tmpsamples = input$sampleres_samples
  
  tmplong = data_analyzed$data_long
  tmplong = tmplong%>%filter(sampleid%in%tmpsamples,group%in%tmpgroups)
  
  validate(need(nrow(tmplong)>1,message = "Need more samples to plot."))
  
  tmpkeep = which((sampledata$group%in%tmpgroups)&(sampledata$sampleid%in%tmpsamples))
  
  gene_pheatmap(data_long=tmplong,valuename=input$groupplot_valuename,
                sampleid=sampledata$sampleid[tmpkeep],
                annotation_row = sampledata[tmpkeep,c("group"),drop=FALSE])
  
})

fun_pca_plot <- reactive({
  print("render PCA plot")
  
  data_analyzed = analyzeDataReactive()
  data_results = data_analyzed$results
  geneids = data_analyzed$geneids
  sampledata = data_analyzed$sampledata
  
  
  tmpgroups = input$sampleres_groups
  tmpsamples = input$sampleres_samples
  
  tmplong = data_analyzed$data_long
  tmplong = tmplong%>%filter(sampleid%in%tmpsamples,group%in%tmpgroups)
  
  tmpkeep = which((sampledata$group%in%tmpgroups)&(sampledata$sampleid%in%tmpsamples))
  
  validate(need(nrow(tmplong)>1,message = "Need more samples to plot."))
  validate(need(length(input$pcnum)==2,message = "Select 2 Prinical Components."))
  
  gene_pcaplot(data_long=tmplong,
               valuename=input$groupplot_valuename,
               sampleid= sampledata$sampleid[tmpkeep],
               groupdat= sampledata[tmpkeep,c("sampleid","group")],
               pcnum = as.numeric(input$pcnum),
               colorfactor="group")
  
  
  
})


  
output$pca_plot <- renderPlot({fun_pca_plot()})

output$download_pca_plot <- downloadHandler(
  filename = "pcaplot.png",
  content = function(file) {
    ggplot2::ggsave(filename = file, plot = fun_pca_plot(), device = "png", dpi = "retina")
  }
)


output$gene_pheatmap <- renderPlot({fun_gene_pheatmap()})

output$download_gene_pheatmap <- downloadHandler(
  filename = "sample_heatmap.png",
  content = function(file) {
    ggplot2::ggsave(filename = file, plot = fun_gene_pheatmap(), device = "png", dpi = "retina")
  }
)
