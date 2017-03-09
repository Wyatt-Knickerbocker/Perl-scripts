#This perl module contains all of the subroutines for the main files,
#EXCEPT for the backup script.
package subroutines;
use strict;
use warnings;
use File::Copy qw( &copy );
use Exporter;
use Cwd;

our @ISA= qw( Exporter );

# these are exported by default.
our @EXPORT = qw( &copyFile );

# these CAN be exported.
our @EXPORT_OK = qw( &copyFile &numLines &changeSuff &revFile &globCheck);

sub copyFile{

  open my $min, '<', $_[0] or die "Could not find file: $!";
  open my $mout, '>', $_[1] or die "Could not write file: $!";

  while (<$min>){
    print $mout $_;
  }

  close $min;

  close $mout;
}


sub numLines{

  open my $in, '<', $_[0] or die "Could not find file: $!";
  open my $out, '>', $_[1] or die "Could not write file: $!";

  while (<$in>){
    last if 1;
  }

  if (($_ =~ /^\d+\t.*$/)){
    my $line = substr $_, 2;
    print $out "$line";

    while (<$in>){
      $line = substr $_, 2;
      print $out "$line";
    }

  }else{

    print $out "$.\t$_";

    while (<$in>){
      print $out "$.\t$_";
          }

    close $in;
    close $out;
  }
}

sub changeSuff{
  my $suffix = $_[1];

  copyFile $_[0], join( '', split( /\..*/, $_[0] ), $suffix);
}

sub revFile{

  open my $rin, '<', $_[0] or die "Could not open file: $!";

  my @reverse_lines = reverse <$rin>;

  close $rin;

  foreach (@reverse_lines){
    $_ = reverse $_;
  }

  open my $rout, '>', $_[0] or die "Could not write file: $!";

  foreach(@reverse_lines){
    print $rout $_;
  }

}

