#! /usr/bin/perl -w
use strict;
#Edit by Jidong Lang
#E-mail:langjd@geneis.cn

unless(@ARGV==3)
{
    die "perl $0 <blast_m8_result> <soap_uniq_result> <output>\n";
}

open IN1, "$ARGV[0]" or die;
open IN2, "$ARGV[1]" or die;
open OUT, ">$ARGV[2]" or die;

my (@tmp1,@tmp2,@t1,@t2,@t3,@t4,@k1,@k2,@k3,@k4,@k5,@k6,@k7,@k8,@k9,@k10);
#my (@uniq,@uniq_seq);
my ($i,$j,$id1,$seq1);

while(<IN1>)
{
    chomp;
    @tmp1=split;
    push @k1,$tmp1[0];
    push @k2,$tmp1[1];
    push @k3,$tmp1[2];
    push @k4,$tmp1[3];
    push @k5,$tmp1[4];
    push @k6,$tmp1[5];
    push @k7,$tmp1[6];
    push @k8,$tmp1[7];
    push @k9,$tmp1[8];
    push @k10,$tmp1[9];
}

while(<IN2>)
{
    chomp;
    @tmp2=split;
    $tmp2[0]=~s/-1\/1$|-1\/2$|-2\/1$|-2\/2$//g;
    push @t1,$tmp2[0];
    push @t2,$tmp2[1];
    push @t3,$tmp2[3];
    push @t4,$tmp2[9];
}

my %hash;

for($i=0;$i<@t1;$i++)
{
    if($t3[$i]==1 && $t4[$i]==0 && $t3[$i+1]==1 && $t4[$i+1]==0 && $t1[$i] eq $t1[$i+1])
    {
        $id1=$t1[$i];
        $seq1=$t2[$i]."<->".$t2[$i+1];
        $hash{$id1}="$id1\t$seq1";
    }
}

print OUT "ID1\tSequence\tID2\tGene1\tGene2\tQuery1_Start\tQuery1_End\tQuery2_Start\tQuery2_End\tRef1_Start\tRef1_End\tRef2_Start\tRef2_End\n";

for($j=0;$j<@k1;$j++)
{
    if(exists $hash{$k1[$j]} && $k3[$j]==100 && $k4[$j]==35 && $k5[$j]==0 && $k6[$j]==0 && ($k7[$j]==1 && $k8[$j]==35 || $k7[$j]==36 && $k8[$j]==70) && $k3[$j+1]==100 && $k4[$j+1]==35 && $k5[$j+1]==0 && $k6[$j+1]==0 && ($k7[$j+1]==1 && $k8[$j+1]==35 || $k7[$j+1]==36 && $k8[$j+1]==70) && $k1[$j] eq $k1[$j+1] && $k7[$j]!=$k7[$j+1] && $k8[$j]!=$k8[$j+1] && $k2[$j] ne $k2[$j+1])
        {
            print OUT "$hash{$k1[$j]}\t$k1[$j+1]\t$k2[$j]\t$k2[$j+1]\t$k7[$j]\t$k8[$j]\t$k7[$j+1]\t$k8[$j+1]\t$k9[$j]\t$k10[$j]\t$k9[$j+1]\t$k10[$j+1]\n";
        }
}
