AH_TPCR<-read.csv('AH_S1_collected_TargetedPCR_metrics.txt',skip=6,nrows=1,sep='\t',header=T)
CH_TPCR<-read.csv('CH_S2_collected_TargetedPCR_metrics.txt',skip=6,nrows=1,sep='\t',header=T)
AH_TPCR<-as.data.frame(t(AH_TPCR))
CH_TPCR<-as.data.frame(t(CH_TPCR))
TPCR_df<-cbind(AH_TPCR,CH_TPCR)
colnames(TPCR_df)<-c('AH_S1','CH_S2')
TPCR_df<-TPCR_df[1:(NROW(TPCR_df)-3),]

AH_HS<-read.csv('AH_S1_hs_metrics.txt',skip=6,nrows=1,sep='\t',header=T)
CH_HS<-read.csv('CH_S2_hs_metrics.txt',skip=6,nrows=1,sep='\t',header=T)
AH_HS<-as.data.frame(t(AH_HS))
CH_HS<-as.data.frame(t(CH_HS))
HS_df<-cbind(AH_HS,CH_HS)
colnames(HS_df)<-c('AH_S1','CH_S2')
HS_df<-HS_df[1:(NROW(HS_df)-3),]