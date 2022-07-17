=
This is essentially a second TCP_LOG it is currently a work in 
progress. I will eventually depricate the original is this second
version fits better to the original purpose of the TCP_LOG.

the majour difference between the two is that this second version
will scan specifically for IPs of people hosting minecraft servers.
this will make it easier to pinpoint the exact address of a server.
I will plan to make this code more reliant on perl (try to avoid 
using netstat) and reduce the complexeties within the code.
=cut

#!/usr/bin/perl
use strict;
use warnings;

my @origin = `netstat -bnvp TCP | awk '{print \$5}'`;

my @compare;
my @testminecraft;
my $testminecraft;
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
			@testminecraft = split('.', $compare[$i]);
			print(@testminecraft);
		}
		@origin = @compare;
	}
}