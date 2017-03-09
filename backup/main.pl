#!/usr/bin/perl

##The main script file for backing up files.
##This was a major PITA, but I managed
##without using system calls or relying on tar.
use lib "..";
use Cwd;
use File::Copy;
use subs (fileBackup);

$Backup::homedir;
$Backup::backdir;

if(defined $ARGV[0]){

  our $homedir = cwd;
  my $backupdir = ".backup";
  chdir;

  if(-d $backupdir){
    #print ".backup exists.\n";
  } else {
    mkdir $backupdir;
    #print ".backup created.\n";
  }

  chdir ".backup";
  if (-e "$ARGV[0]"){
    print "WARNING: File already exists. Continue and overwrite(y/n)?";
    my $reply = <STDIN>;
    close STDIN;
    if(reply == "Y" or reply == "y"){
      print "Continuing.\n";
      unlink "$ARGV[0]";
    } else {
      print "Backup aborted.\n";
      exit;
    }
  }

  if(-d "$homedir/$ARGV[0]"){
    chdir;
    chdir $backupdir;
    mkdir "testdir";
    chdir "testdir";
    fileBackup "$homedir/$ARGV[0]";
    print "Directory backup success.\n";
  } else {
    chdir;
    copy "$homedir/$ARGV[0]", ".backup" or die "couldn't copy $ARGV[0]: $!, stopped";
    print "File copy success.\n";
  }



} else {

  die "Please enter the name of a file or directory.";

}

sub fileBackup{

  our $backdir = cwd;
  our $homedir = $homedir;
  my @files = <$_[0]/*>;
  my $file;
  foreach $file (@files) {
    print "Checking $file...\n";
    if (-f $file){
        #print "Copying $file to $backdir while in ", cwd, "\n\n";
        copy "$file", "$backdir" or die "couldn't copy $file: $!, stopped";
        print " File $file Archived.\n";
    } else{
        if (-d $file) {
        print "$file is a directory.\n";
        my @tmp = split("/", $file);
        my $nextdir = pop(@tmp);
        mkdir $nextdir;
        chdir $nextdir;
        print "moving to $backdir/$nextdir.\n\n";
        fileBackup $file;
        chdir "..";
      }
    }
  }
}
