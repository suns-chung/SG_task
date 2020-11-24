library(ggplot2)
library(reshape2)

AH<-read.table('AH_S1_intersect.depth.txt.gz',sep='\t',header=FALSE,strip.white=TRUE)
CH<-read.table('CH_S2_intersect.depth.txt.gz',sep='\t',header=FALSE,strip.white=TRUE)
AH$V4<-paste0(AH[,1],":",AH[,2])
CH$V4<-paste0(CH[,1],":",CH[,2])
AH_reform<-AH[,c(4,3)]
CH_reform<-CH[,c(4,3)]
colnames(AH_reform)<-c('coord','AH_depth')
colnames(CH_reform)<-c('coord','CH_depth')
AH_CH_depth<-(merge(AH_reform,CH_reform))
df.AH_CD_depth<-melt(AH_CH_depth,id.vars='coord',variable.name='series')

ggplot(df.AH_CD_depth[df.AH_CD_depth$value>0,],aes(coord,value))+geom_point(aes(colour=series),alpha=0.6)+scale_color_brewer(palette='Accent')+labs(x='P:osition',y='Depth')
ggsave('AH_CD_cov.pdf',width=20,height=10)

ggplot(df.AH_CD_depth[df.AH_CD_depth$value>0,],aes(x=value,fill=series))+geom_histogram(alpha=0.6,position='identity',bins=200)+labs(fill='',x='Depth',y='Frequency')+scale_fill_brewer(palette='Accent')

ggsave('AH_CD_cov_histogram.pdf',width=20,height=10)
