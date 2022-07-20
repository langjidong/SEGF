# SEGF

Option

-fq <Input_File>    Input fq.gz file
-trim_len   <Trim reads length> Trim N bases of read with 5' and 3' end, default is 5
-remain_len <Remain reads length>   Remain N bases of read with 5' and 3' end, default is 27
-configure  <bed file>    Target Gene bed file
-process    <Number of process used>    N processes to use, default is 1
-help   print HELP message

Example:

perl SEGF.pl -fq test.fq.gz -trim_len 10 -remain_len 35 -configure Target_Gene.conf -process 1

**Publications**

Xu H, Wu X, Sun D, Li S, Zhang S, Teng M, Bu J, Zhang X, Meng B, Wang W, Tian G, Lin H, Yuan D, Lang J, Xu S. SEGF: A Novel Method for Gene Fusion Detection from Single-End Next-Generation Sequencing Data. Genes (Basel). 2018 Jul 2;9(7):331. doi: 10.3390/genes9070331. PMID: 30004447; PMCID: PMC6070977
