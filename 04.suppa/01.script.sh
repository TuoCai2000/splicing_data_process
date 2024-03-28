######################01.generate events
suppa.py generateEvents -i ./mm39.hCDK13.sorted.gtf -o ./SUPPA/events/mm39.hCDK13.events -e SE SS MX RI FL -f ioe
######################02.merge all ioe files
awk 'FNR==1 && NR!=1 { while (/^<header>/) getline; } 1 {print}' ./SUPPA/events/*.ioe > ./SUPPA/events/mm39.hCDK13.all.events.ioe
######################03.calculate psi matrix
python /share/home/caituo/miniconda3/pkgs/suppa-2.3-py_2/python-scripts/suppa.py psiPerEvent -i ./SUPPA/events/mm39.hCDK13.all.events.ioe \
            -e ./StringTie/modified_tpm.txt \
            -o ./SUPPA/psiPerEvent
#######################04.按照不同的比较组拆分PSI矩阵和TPM表达谱，并进行差异可变剪切事件的查找，以LTHSC ko vs wt为例
cut -f 1-3 ./SUPPA/psiPerEvent.psi > ./SUPPA/LTHSC.KO.psi
cut -f 1,6-7,10-11 ./SUPPA/psiPerEvent.psi > ./SUPPA/LTHSC.WT.psi
cut -f 1-3 ./StringTie/modified_tpm.txt > ./StringTie/LTHSC.KO_tpm.txt
cut -f 1,6-7,10-11 ./StringTie/modified_tpm.txt > ./StringTie/LTHSC.WT_tpm.txt
python /share/home/caituo/miniconda3/pkgs/suppa-2.3-py_2/python-scripts/suppa.py diffSplice -m empirical \
                      -gc -i ./SUPPA/events/mm39.hCDK13.all.events.ioe --save_tpm_events \
                      -p ./SUPPA/LTHSC.KO.psi ./SUPPA/LTHSC.WT.psi \  
                      -e ./StringTie/LTHSC.KO_tpm.txt ./StringTie/LTHSC.WT_tpm.txt \
                      -o ./SUPPA/LTHSC_diffSplice
#######################05.按照阈值筛选出deltaPSI大于0.1且pvalue小于0.05的事件
awk '($2 > 0.1 || $2 < -0.1) && $3 < 0.05 {count++} END {print count}' ./LTHSC_diffSplice.dpsi
