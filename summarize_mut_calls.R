library(vcfR)
library(VennDiagram)

AH_vcf_file<-read.vcfR('AH_S1_somatic.vcf', verbose = FALSE )
AH_vcf<-as.data.frame(attributes(AH_vcf_file)$fix)
CH_vcf_file<-read.vcfR('CH_S2_somatic.vcf', verbose = FALSE )
CH_vcf<-as.data.frame(attributes(CH_vcf_file)$fix)
AH_vcf$chrom_pos<-paste0(AH_vcf$CHROM,":",AH_vcf$POS)
CH_vcf$chrom_pos<-paste0(CH_vcf$CHROM,":",CH_vcf$POS)

library(RColorBrewer)
myCol <- brewer.pal(3, "Accent")

venn.diagram(
  x = list(AH_vcf$chrom_pos, CH_vcf$chrom_pos),
  category.names = c("CH_S2" , "AH_S1"),
  filename = 'AH_CH_vcf_venn_diagramm.png',
  output=TRUE,
  # Output features
  imagetype="png" ,
  height = 480 , 
  width = 480 , 
  resolution = 300,
  compression = "lzw",
  
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = myCol[1:2],
  
  # Numbers
  cex = .6,
  fontface = "bold",
  fontfamily = "sans",
  
  # Set names
  cat.cex = .7,
  cat.dist = -0.5,
  cat.default.pos = "outer",
  cat.fontfamily = "sans"
)