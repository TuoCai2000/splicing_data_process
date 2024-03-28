#####tophat using for mapping
#####conda activate py27
#################################################################
#####mm39.hCDK13.sorted.gtf stored in reference data
#####./bowtie2index/GRCm39.genome stored in reference data

input_path=./fastp/WT/ #fastp的输出目录文件夹
sample=xxxx #同第一步的样本名
tophat2 -p 32 -G mm39.hCDK13.sorted.gtf \
        --library-type fr-unstranded \
        --no-novel-juncs \
        -o test_output \ #输出的目录名
        ./bowtie2index/GRCm39.genome $input_path/${sample}"_1.fq",$input_path/${sample}"_2.fq"
