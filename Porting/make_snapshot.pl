#!/usr/bin/perl
use strict;
use warnings;
use File::Spec;
use Cwd qw/getcwd abs_path/;

# Create a snapshot for smokers

my $sha1 = `git rev-parse HEAD`;
chomp $sha1;

my $dir = abs_path(File::Spec->catdir(getcwd, File::Spec->updir));
my $tgz  = "$sha1.tar.gz";
my $path_tgz = File::Spec->catfile($dir, $tgz);

unlink $path_tgz;
system("Porting/make_dot_patch.pl");
system("git archive --format=tar.gz --add-file=.patch $sha1 > $path_tgz");
unlink ".patch";

print "$path_tgz", -t STDOUT ? "\n" : "";

