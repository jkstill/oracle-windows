#!/usr/bin/env perl 

use warnings;
use strict;
use IO::File;

my $DEBUG=0;


=head1 csv-hdr-rewrite.pl

This script is used to shorten the headers of Windows Performance Counter CSV files.

Additionally:


- all backslash are converted to slash in header names
- all line terminators, CR and LF, are removed from headers and data

usage: ./csv-hdr-rewrite.pl source-dir target-dir

=cut


my $csvSourceDir=$ARGV[0];
my $csvTargetDir=$ARGV[1];

unless ( defined($csvSourceDir) and defined($csvTargetDir) ) {
	print "Please include the target directory name for the new CSV files\n";
	die 1;
}

mkdir $csvTargetDir;

unless ( -d $csvTargetDir and -x $csvTargetDir) {
	die "problem with target dir: $csvTargetDir\n";
}

opendir( CSV,$csvSourceDir);

my @allfiles = readdir(CSV);
closedir (CSV);

my %fileHdrs=();
my $slash='/';

# create new header lines
foreach my $file (@allfiles) {
	my $fqn = "$csvSourceDir/$file";
	-f $fqn || next;
	#print "$fqn \n";

	my $sourceFH = IO::File->new();
	$sourceFH->open($fqn,'r') or die "cannot open $fqn - $!\n";

	my $hdrLine = <$sourceFH>;
	# dos files - remove ctl-M
	stripLineTerminators(\$hdrLine);
	stripQuotes(\$hdrLine);
	replaceBackslash(\$hdrLine);
	my @hdrs = split(/,/,$hdrLine);
	#print join(' - ', @hdr ) . "\n";
	
	my $newHdrLine='';

	if ($DEBUG) {
		print '=' x 80 . "\n";
		print "==== $file\n";
		print '=' x 80 . "\n";
	}

	foreach my $hdr (@hdrs) {

		my $newhdr=$hdr;

		print "(D:) $newhdr\n" if $DEBUG;

		print "HDR: $hdr\n" if $DEBUG;
		if ($hdr =~ /(Daylight|Standard)\s+Time/ ) {
			$newhdr = 'timestamp';
		} elsif ( $hdr =~ /\(.+\)/ ) {
			# \\SUSCLTAP043\Database(HealthService)\Database Cache Misses/sec
			my $parenPos = index($hdr,'(');
			$newhdr = substr($hdr,$parenPos+1);
			$newhdr = '('.$newhdr;
			$newhdr =~ s/\(HealthService\)\///g;
		} elsif ( $hdr =~ /^$slash$slash[[:alnum:]-]+$slash/ ) {
			# //SERVER-NAME/Memory/Page Faults/sec
			$newhdr = $hdr;
			$newhdr =~ s/^\/\/[[:alnum:]-]+\///;
			$newhdr =~ s/\(HealthService\)\\//g;
		} else {
			print "error\n";
			print "hdr: $hdr\n";
			die "Dunno what happened\n";
		}
		print "NEWHDR: $newhdr\n" if $DEBUG;


		# remove the 'Healthservice' tag from db metrics
		print "(N:) $newhdr\n" if $DEBUG;

		$newHdrLine .= $newhdr . ',';
		print "(N2:) $newHdrLine\n\n" if $DEBUG;

	}

	undef $sourceFH;

	#chomp $newHdrLine;

	print "$newHdrLine\n\n" if $DEBUG;
	# remove trailing comma;
	chop $newHdrLine;
	$fileHdrs{$file} = $newHdrLine;

}

foreach my $file (@allfiles) {

	my $sourceFQN = "$csvSourceDir/$file";
	-f $sourceFQN || next;
	print "working on $file\n";
	#print "$fqn \n";
	my $targetFQN = "$csvTargetDir/$file";

	my $sourceFH = IO::File->new();
	$sourceFH->open($sourceFQN,'r') or die "cannot open $sourceFQN - $!\n";

 	my $targetFH = IO::File->new();
	$targetFH->open($targetFQN,'w') or die "cannot open $targetFQN - $!\n";

	$targetFH->write($fileHdrs{$file} . "\n");

	# first line is header, which we are replacing
	my $dummy = <$sourceFH>;

	while (my $line = <$sourceFH> ) {
		stripQuotes(\$line);
		stripLineTerminators(\$line);
		$targetFH->write($line . "\n");
	}

	undef $sourceFH;
	undef $targetFH;

}


sub replaceBackslash {
	my ($dataRef)=@_;
	$$dataRef  =~ s#\\#/#g;
}

sub stripQuotes {
	my ($dataRef)=@_;
	$$dataRef  =~ s/\"//g;
}

# this removes ALL line terminating characaters
sub stripLineTerminators {
	my ($lineRef)=@_;
	$$lineRef =~ s/[\r\n]+//g;
}


