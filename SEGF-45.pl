#!/usr/bin/perl -w
use strict;
use File::Basename;
use Getopt::Long;
use FindBin qw/$Bin/;

sub USAGE
{
    my $usage=<<USAGE;

===============================================
Edit by Jidong Lang; E-mail: langjd\@geneis.cn;
===============================================

Option
        -fq <Input_File>    Input fq.gz file
        -trim_len   <Trim reads length> Trim N bases of read with 5' and 3' end, default is 5
        -remain_len <Remain reads length>   Remain N bases of read with 5' and 3' end, default is 27
        -configure  <bed file>    Target Gene bed file
        -process    <Number of process used>    N processes to use, default is 1
        -help   print HELP message

Example:

perl $0 -fq test.fq.gz -trim_len 10 -remain_len 35 -configure Target_Gene.conf -process 1

USAGE
}

unless(@ARGV>3)
{
    die USAGE;
    exit 0;
}


my ($fq,$trim_len,$remain_len,$configure,$process);
GetOptions
(
    'fq=s'=>\$fq,
    'trim_len=i'=>\$trim_len,
    'remain_len=i'=>\$remain_len,
    'configure=s'=>\$configure,
    'process=i'=>\$process,
    'help'=>\&USAGE,
);

$trim_len ||=5;
$remain_len ||=27;
$process ||=1;

#Prepare Target Gene Reference for BLAST#

open IN, "$configure" or die;

`mkdir reference`;

while(<IN>)
{
    chomp;
    my @tmp=split;
    my $len=$tmp[2]-$tmp[1]+1;
    `perl $Bin/script/Target_reference_prepare.pl $Bin/database/by_chr/$tmp[0].fa $tmp[1] $len $tmp[3] ./reference/reference.fa`;
}

`$Bin/bin/formatdb -i ./reference/reference.fa -p F -o T`;

#Deal Fastq Reads (to Fasta)#

`mkdir deal_fastq`;

my $basename=basename($fq);
$basename=~s/(.*).fq.gz/$1/g;
`perl $Bin/script/Deal_reads.pl $fq $trim_len $remain_len ./deal_fastq/$basename.blast.fa ./deal_fastq/$basename.soap.fa`;

#BLAST the Deal_Fasta/SOAP the Deal_Fasta#

`mkdir tmp`;

`$Bin/bin/blastall -p blastn -i ./deal_fastq/$basename.blast.fa -d ./reference/reference.fa -o ./tmp/$basename.blast -e 1e-10 -F F -m 8 -a $process`;
`$Bin/bin/soap2.21 -a ./deal_fastq/$basename.soap.fa -D $Bin/database/hg19.fa.index -o ./tmp/$basename.soap -p $process -s $remain_len`;

#Filter the result and find the candidate fusions#

`mkdir Result`;
`perl $Bin/script/Result-filter-45bp.pl ./tmp/$basename.blast ./tmp/$basename.soap ./Result/$basename.fusions.txt`;

#Remove the tmp file#
`rm -rf tmp deal_fastq reference`;
