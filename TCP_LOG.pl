#!/usr/bin/perl
use strict;
use warnings;

my @origin = `netstat -bnvp TCP | awk '{print \$5}'`;

my @compare;
my $origin_index;
my $compare_index;
my $diff;


print("TCP_LOG: RUNNING\n");

for( ; ; ) {

	$origin_index = $#origin;

	@compare = `netstat -bnvp TCP | awk '{print \$5}'`;
	$compare_index = $#compare; 
	
	if($origin_index != $compare_index) {
		$diff = $compare_index - $origin_index;
		for( my $i=2; $i<(2 + $diff); $i++) {
			print("new TCP connection: $compare[$i]");
		}
		@origin = @compare;
	}
}