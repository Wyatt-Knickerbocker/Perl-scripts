#!/usr/bin/perl

##This is the main script file for reversing a file.
##This reverse line-by-line and character-by-character
##Such that the last character is first, first character is last, ec cetera.
use lib "..";
use subroutines qw(&revFile);

if(defined $ARGV[0]){

  revFile $ARGV[0];

} else {

  die "Please enter the name of a file."

}
