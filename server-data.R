## ==================================================================================== ##
# App Name: GeExAT - Gene Expression Analysis Tool
# Author: Ghazala Sultan & Swaleha Zubair from Department of Computer Science, AMU, Aligarh, India.
#
# This is a Shiny web application with All Rights Reserved to aforementioned Author.
# You may contact the author of this code, Ghazala Sultan at <gsultan@myamu.ac.in>
## ==================================================================================== ##

AllRNAdatReactive <- reactive({
  outdat=mousedata[,c("gene.name","gene.id","sample","count","log2cpm","cpm")]
  colnames(outdat) = c("gene.name","gene.id","sample.id","count","log2cpm.edgeR.adjusted","cpm.bowtie.raw")
  return(outdat)		
})

output$downloadData <- downloadHandler(filename = c('all_data.csv'),
                                       content = function(file) {write.csv(AllRNAdatReactive(), file, row.names=FALSE)})



output$outdat <- renderDataTable({
  tmpdat = AllRNAdatReactive()
  tmpdat[,sapply(tmpdat,is.numeric)] <- signif(tmpdat[,sapply(tmpdat,is.numeric)],3)
  datatable(tmpdat)
})
