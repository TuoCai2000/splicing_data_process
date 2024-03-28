#stringtie输出文件：./output/transcript_count_matrix.csv

library(biomaRt)
mus = useMart("ENSEMBL_MART_ENSEMBL",
              dataset="mmusculus_gene_ensembl")
attr=listFilters(mus)

data=read.table("./output/transcript_count_matrix.csv",sep = ",",header = T)
feature_ids=rownames(data)
head(feature_ids)

attributes = c(
  "ensembl_gene_id",
  "ensembl_transcript_id",
  "external_gene_name",
  "chromosome_name",
  "start_position",
  "end_position"
)
filters = "external_gene_name"
feature_info <- getBM(attributes = attributes, 
                               filters = filters, 
                               values = feature_ids, mart = mus)

merged=merge(feature_info,data,by.x = 'external_gene_name',by.y = 'gene')
merged=na.omit(merged) #去掉未匹配的条目
dim(merged) #保留34042个gene

merged$eff_length=abs(merged$start_position-merged$end_position)

eff2_length=merged[,c('external_gene_name','eff_length')]
expr_matrix=merged[,c(1,6:19)]

unique_expr <- subset(expr_matrix, !duplicated(expr_matrix))
dim(unique_expr)

rownames(unique_expr)=unique_expr$external_gene_name
unique_expr=unique_expr[,-1]

x=unique_expr/eff2_length$eff_length

tpm=t(t(x)/colSums(x)) * 1e6

write.table(tpm,"./merged.tpm.csv",sep=",",quote=F)
