#!usr/bin/perl

# Written by Tom de Man

use strict;
use Getopt::Long;
use Bio::DB::GenBank;

my $in = "";
# default file name
my $out = "GenBank_genes.fasta";

GetOptions('in=s'=>\$in,
	   'out=s'=>\$out);
		   
&Use unless(-e $in);

open (INPUT_FILE, "<$in");
open (OUTPUT_FILE, ">$out");

while(<INPUT_FILE>)
{
    chomp;

    my $line = $_;
    my @acc_no = split(" ", $line);

    my $counter = 1;

    while ($acc_no[$counter])
    {

        my $db_obj = Bio::DB::GenBank->new;

        my $seq_obj = $db_obj->get_Seq_by_acc($acc_no[$counter]);

        my $sequence1 = $seq_obj->seq;

        print OUTPUT_FILE ">"."$acc_no[$counter]","\n";

        print OUTPUT_FILE $sequence1,"\n";

        print "Sequence Downloaded:", "\t", $acc_no[$counter], "\n";

        $counter++;
    }
}

close OUTPUT_FILE;
close INPUT_FILE;

sub Use	{
	die "\n\tUsage::perl grab_seq_from_genbank_by_accession.pl

	-in <two column text file> (col 1 = gene name, col 2 = GenBank accession) 
	
	-out <output FASTA file name> (default file name is: GenBank_genes.fasta)

	\n";
}
