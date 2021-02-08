#!/usr/bin/perl

# Perl interface to use clustered ssh servers
system('clear');
use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;
use Scalar::Util qw(looks_like_number);
use Term::ANSIColor qw(:constants);


my $clustersfile = "/etc/clusters";
my $csshbinfile = "/usr/bin/clusterssh"; # Change it with csshX in case of OSX 

open(my $fh, '<:encoding(UTF-8)', $clustersfile) or die "Could not open file '$clustersfile' $!";

print "Here are the defined clusters. Choose the one you want to connect to:\n";

START:

my @cluster;
my @cluster_screen;

while (my $row = <$fh>) {
    chomp $row;
    push @cluster, $row unless ($row =~ /^#/);
    unless ($row =~ /^#/){
        my ($cname, $cservers) = $row =~ /(^[^\s]+).*?(.*)$/;
        push @cluster_screen, $cname;
    }else{
        push @cluster_screen, $row;
    }
}

my $i = 1;
foreach (@cluster_screen){
    if ($_ =~ /^#/){
        print BOLD, YELLOW, $_."\n";
        next;
    }
    if ($_ =~ /^PRO/){
        print BOLD, BLUE, $i, RESET, " => ", RESET, RED, "$_", WHITE, RESET, "\n";
    }else{
        print BOLD, BLUE, $i, RESET, " => ", RESET, GREEN, "$_", WHITE, RESET, "\n";
    }
    $i++;
}
print BOLD, BLUE, "x", RESET, " => ", RESET, "exit\n";

my $option = <STDIN>;
chomp $option;

if (looks_like_number($option) && ($option > 0 && $option <= scalar(@cluster))) {
    my ($cname, $cservers) = @cluster[$option-1] =~ /(^[^\s]+).*?(.*)$/;

    $cname =~ s/^\s+|\s+$//g;
    $cservers =~ s/^\s+|\s+$//g;

    print "\nCluster Name: $cname\n";
    print "Cluster Servers: $cservers\n";

    system($csshbinfile.' '.$cname);
}else{
    if ($option eq "x"){
        exit;
    }
    print "This options does not exists. Please, choose another one:\n";
    goto START;
}
