# SEGF

===============================================
Edit by Jidong Lang; E-mail: langjd@geneis.cn;
===============================================

Option
        -fq <Input_File>    Input fq.gz file
        -trim_len   <Trim reads length> Trim N bases of read with 5' and 3' end, default is 5
        -remain_len <Remain reads length>   Remain N bases of read with 5' and 3' end, default is 27
        -configure  <bed file>    Target Gene bed file
        -process    <Number of process used>    N processes to use, default is 1
        -help   print HELP message

Example:

perl SEGF.pl -fq test.fq.gz -trim_len 10 -remain_len 35 -configure Target_Gene.conf -process 1
