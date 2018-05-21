#! /usr/bin/perl -w
use strict;
#Edit by Jidong Lang
#E-mail:langjd@geneis.cn

unless(@ARGV==4)
{
    die "perl $0 <result_filter> <Gene-CDS.bed> <output1> <output2>\n";
}

open IN1, "$ARGV[0]" or die;
open IN2, "$ARGV[1]" or die;
open OUT1, ">$ARGV[2]" or die;
open OUT2, ">$ARGV[3]" or die;

my (@tmp1,@tmp2,@t1,@t2,@t3,@t4,@k1,@k2,@k3,@k4,@k5,@k6,@k7,@k8,@k9,@k10);
#my (@uniq,@uniq_seq);
my ($i,$j,$dele1,$dele2,$dele3);

while(<IN1>)
{
    chomp;
    @tmp1=split(/\t/,$_);
    push @k1,$tmp1[0];
    push @k2,$tmp1[1];
    push @k3,$tmp1[2];
    push @k4,$tmp1[3];
    push @k5,$tmp1[4];
    push @k6,$tmp1[9];
    push @k7,$tmp1[10];
    push @k8,$tmp1[11];
    push @k9,$tmp1[12];
}

while(<IN2>)
{
    chomp;
    @tmp2=split(/\t/,$_,4);
    push @t1,$tmp2[0];
    push @t2,$tmp2[1];
    push @t3,$tmp2[2];
    push @t4,$tmp2[3];
}

#print OUT "ID1\tSequence\tID2\tGene1\tGene2\tRef1_Start\tRef1_End\tRef2_Start\tRef2_End\tType1\tType2\n";

for($i=0;$i<@t1;$i++)
{
    for($j=0;$j<@k1;$j++)
    {
        if($k6[$j] > $k7[$j])
        {
            $dele1=$k7[$j];
        }
        else
        {
            $dele1=$k6[$j];
        }
        if($k8[$j] > $k9[$j])
        {
            $dele2=$k9[$j];
        }
        else
        {
            $dele2=$k8[$j];
        }
        if($k4[$j] eq $t1[$i] && $dele1 >= $t2[$i] && $dele1 <= $t3[$i])
        {
            print OUT1 "$k1[$j]\t$k2[$j]\t$k3[$j]\t$k4[$j]\t$k5[$j]\t$dele1\t$t4[$i]\n";
        }
        if($k5[$j] eq $t1[$i] && $dele2 >= $t2[$i] && $dele2 <= $t3[$i])
        {
            print OUT2 "$dele2\t$t4[$i]\n";
        }
    }
}

#`paste out out1 > oooooo`;
#`rm -rf out out1`;
