gatk --java-options "-XX:+UseSerialGC -Xms36000m" Mutect2 -R /n/groups/shared_databases/genomes/hg19.fa -I AH_S1/AH_S1.b37.sorted.named.bam -tumor AH_S1 -O AH_S1_somatic.vcf.gz -L AH_S1_chr_target.interval_list

gatk --java-options "-XX:+UseSerialGC -Xms36000m" Mutect2 -R /n/groups/shared_databases/genomes/hg19.fa -I CH_S2/CH_S2.b37.sorted.named.bam -tumor CH_S2 -O CH_S2_somatic.vcf.gz -L CH_S2_chr_target.interval_list
