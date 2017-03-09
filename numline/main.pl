#!usr/bin/perl

##Main file for numbering the lines.
use lib "..";
use subroutines qw(&numlines &copyFile);

if (defined $ARGV[0] ) {

  numlines $ARGV[0], "temp.file";

  copyFile "temp.file", $ARGV[0];
  unlink temp.file;

} else {
  die "Please input a file.\n";
}
