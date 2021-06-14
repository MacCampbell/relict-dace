#! /usr/bin/perl -w
# I want to read in a phylip file, and then remove sequences with some proportion of Ns.

my $firstline;
my @seqs=();
# so we can throw out sequences with missing data
# set here
my $thresh = 0.10;
my $i=0;

while (<>) {
$i++;

if ($i == 1) {
	chomp;
	$firstline=$_;
	} else {
	push(@seqs, $_);	
	}


}

my @info=split(/\s+/, $firstline);

my $chars=$info[1];

#calculate proportion of Ns
my $j=0;
my @kept;
my @dumped;

foreach my $seq (@seqs) {
	my @a=split(/\s+/, $seq);
	my $count = () = $a[1] =~ /\QN/g;
	if( $count/$chars < $thresh) {
	push (@kept, $seq);
	$j++;
	} else {
	push (@dumped, $seq);
	}
	
}

print "$j\t$chars\n";
print join ("\n", @kept);

open(my $fh, ">", "dumped.txt")
    or die "Can't open > dumped.txt: $!";

print $fh @dumped;
print $fh "\n";
close($fh);

exit;
