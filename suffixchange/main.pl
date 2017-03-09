#!/usr/bin/perl

##Changesuffix file.
use lib "..";
use subroutines qw(&changeSuff);

if(defined $ARGV[1]){

  changeSuff $ARGV[0], $ARGV[1];

} else {

  die "Please enter a file and the new extension, in that order."

}
