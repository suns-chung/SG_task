#!/bin/sh

module purge
module load gcc/6.2.0 python/2.7.12 java/jdk-1.8u112 samtools/1.9 bwa/0.7.17 

export PATH=$PWD/mysql-5.7.27-linux-glibc2.12-x86_64/bin:$PATH 

[ -d group2 ] || { echo group2 is not found. You need at least two groups to run this pipeline; exit 1; }

pwdhere=`pwd`

for group in `ls -d group*/|sed 's|[/]||g'`; do
    echo working on group:  $group
    cd $pwdhere/$group
    for sample in `ls -d */|sed 's|[/]||g'`; do
        rm $pwdhere/unmappedBams/$group/$sample.inputBamList.txt 2>/dev/null
        mkdir -p $pwdhere/unmappedBams/$group/$sample 
        echo working on sample: $sample
        for r1 in `ls $sample/*_1.fastq* $sample/*_1.fq* 2>/dev/null`; do 
            readgroup=${r1#*/}
            readgroup=${readgroup%_*}
            r2=${r1%_*}_2${r1##*_1}
            echo working on readgroup: $readgroup
			[[ -f $r2 ]] || { echo -e "\n\n!!!Warning: read2 file '$r2' not exist, ignore this warning if you are working with single-end data\n\n"; r2=""; }
            
            #@1,0,fastqToSam,,sbatch -p short -t 0-4 --mem 4G 
            java -XX:+UseSerialGC -Xmx8G -jar /n/app/picard/2.8.0/bin/picard-2.8.0.jar FastqToSam \
                    FASTQ=$r1 \
                    FASTQ2=$r2 \
                    OUTPUT=$pwdhere/unmappedBams/$group/$sample/$readgroup.bam \
                    READ_GROUP_NAME=${readgroup##*_} \
                    SAMPLE_NAME=$sample \
                    LIBRARY_NAME=${readgroup%%_*} \
                    PLATFORM_UNIT=H0164ALXX140820.2 \
                    PLATFORM=illumina \
                    SEQUENCING_CENTER=BI \
                    RUN_DATE=2014-08-20T00:00:00-0400
            #bwa mem -M -t 4 -R "@RG\tID:$sample.$readgroupz\tPL:Illumina\tSM:$sample" $index $r1 $r2 > $sample/$readgroup.sam 
            
            echo $pwdhere/unmappedBams/$group/$sample/$readgroup.bam >> $pwdhere/unmappedBams/$group/$sample.inputBamList.txt
		done
        sed "s/sampleName/$sample/; s/inputBamList.txt/${pwdhere//\//\\/}\/unmappedBams\/$group\/$sample.inputBamList.txt/" $pwdhere/processing-for-variant-discovery-gatk4-template.json > $pwdhere/unmappedBams/$group/in.json
        
   
        #[[ $group == group1 ]] && group1Sample=$sample || group2Sample=$sample 
        
        break; 
    done
done      

#cd $pwdhere 

# trap "rm -r $PWD/mysqldLock; killall mysqld" 0 2 3 15 ; 

# this does not work, need run it in interactive mode
##@2,1,processGATK,,sbatch -p medium -c 2 -t 3-0 --mem 20G
# setupAndRunMysql.sh || exit 1; trap "rm -r $PWD/mysqldLock; killall mysqld" 0 1 2 3 15; 
# java -XX:+UseSerialGC -Dconfig.file=your.conf -jar /n/shared_db/singularity/hmsrc-gatk/cromwell-43.jar run processing-for-variant-discovery-gatk4.wdl -i unmappedBams/group1/in.json; 
# java -XX:+UseSerialGC -Dconfig.file=your.conf -jar /n/shared_db/singularity/hmsrc-gatk/cromwell-43.jar run processing-for-variant-discovery-gatk4.wdl -i unmappedBams/group2/in.json; 
# setupJson.sh; java -XX:+UseSerialGC -Dconfig.file=your.conf -jar /n/shared_db/singularity/hmsrc-gatk/cromwell-43.jar run mutect2.wdl -i unmappedBams/exon.json && findVCF.sh 
# killall mysqld; rm -r mysqldLock 

