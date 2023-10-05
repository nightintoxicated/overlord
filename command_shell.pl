#!/usr/bin/perl
my $file = "/tmp/overlord_command";
#UID is a counter so client can make sure
#it hasnt already done the command
my $UID = "1\n";

while (1) {
	print "Enter Command: ";
	my $command = <>;
	open(FH, '>', $file) or die $!;
	print FH "COMMAND: $command";
	print FH "UID: $UID";
	close(FH);
	$UID+=1;
}
