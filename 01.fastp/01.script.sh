##########using fastp

#!/bin/bash
RawDir=/share/home/caituo/ptRNA/raw_data/CDK13ko/ #fastq文件所在目录
CleanDir=/share/home/caituo/ptRNA/fastp/CDK13ko/ #结果存放目录
Sample=YR-Lib_WT-ST2 #样本名样式：{Sample}_1.fq.gz、{Sample}_2.fq.gz
mkdir -p ${CleanDir} 
fastp -i ${RawDir}/${Sample}_1.fq.gz -o ${CleanDir}/${Sample}_1.fq.gz \
-I ${RawDir}/${Sample}_2.fq.gz -O ${CleanDir}/${Sample}_2.fq.gz \
--report_title ${Sample} --json ${CleanDir}/${Sample}_fastp.json \
--html ${CleanDir}/${Sample}_fastp.html --detect_adapter_for_pe
