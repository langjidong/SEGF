#! /usr/bin/perl -w
use strict;
#Edit by Jidong Lang
#E-mail:langjd@geneis.cn

unless(@ARGV==5)
{
    die "perl $0 <Reads_fq> <Trim_length> <Remain_length> <deal_reads1_fa> <deal_reads2_fa>\n";
}

open IN, "gzip -dc $ARGV[0]|" or die;
open OUT1, ">$ARGV[3]" or die;
open OUT2, ">$ARGV[4]" or die;

my $trim_len=$ARGV[1];
my $remain_len=$ARGV[2];

while(<IN>)
{
    chomp;
    if(/^\@(.*)(\s+)(\d):N:0:(\S+)$/)
    {
        my $seq=<IN>;
        my $tmp=<IN>;
        my $qual=<IN>;
        my $tmp1=substr($seq,$trim_len,$remain_len);
        my $read_len=length($seq)-1;
        my $pos=$read_len-$trim_len-$remain_len;
        my $tmp2=substr($seq,$pos,$remain_len);
        my $seq1=$tmp1.$tmp2;
        print OUT1 ">$1/$3\n";
        print OUT1 "$seq1\n";
        print OUT2 ">$1/$3-$3/1\n";
        print OUT2 "$tmp1\n";
        print OUT2 ">$1/$3-$3/2\n";
        print OUT2 "$tmp2\n";
    }
}
