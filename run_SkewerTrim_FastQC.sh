
skewer -t 4 -m mp -i AH_S1_L001_R1.fastq.gz AH_S1_L001_R2.fastq.gz -o AH_S1_SKEWER

bash-4.2$ skewer -t 4 -m mp -i CH_S2_L001_R1.fastq.gz CH_S2_L001_R2.fastq.gz -o CH_S2_SKEWER

mkdir AH_S1_fastqc
fastqc -o AH_S1_fastqc/ AH_S1_SKEWER-trimmed-pair1.fastq AH_S1_SKEWER-trimmed-pair2.fastq 

mkdir CH_S2_fastqc

fastqc -o CH_S2_fastqc/ CH_S2_SKEWER-trimmed-pair1.fastq CH_S2_SKEWER-trimmed-pair2.fastq

mkdir fastqc

cp AH_S1_fastqc/*.zip fastqc
cp CH_S2_fastqc/*.zip fastqc
