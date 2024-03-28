###################################single sample
# step1
/share/home/caituo/software/stringtie-2.2.1.Linux_x86_64/stringtie -p 32 -e -G ./mm39.hCDK13.sorted.gtf  -o ./output/YR-Lib_WT-ST2.gtf -i ./tophat/YR-Lib_WT-ST2/accepted_hits_sorted.bam
##################################所有样本运行完了再运行step2
# step 2
/share/home/caituo/software/stringtie-2.2.1.Linux_x86_64/stringtie --merge -p 48 ./output/*gtf -G ./mm39.hCDK13.sorted.gtf -o ./output/stringtied_merged.gtf
#################################step2只需要运行一次，再运行step3
# step 3
python /share/home/caituo/software/stringtie-2.2.1.Linux_x86_64/prepDE.py -i new.txt -g ./output/gene_count_matrix.csv -t ./output/transcript_count_matrix.csv
