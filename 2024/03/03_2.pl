#!/usr/bin/perl -n

while ( /(?:mul\((\d+),(\d+)\)|(do(?:n\'t)?)\(\))/og ) {
  if ( !defined($3) && !defined($dont) ) {
    $sum += $1 * $2;
  } elsif ( $3 eq "do" ) {
    undef $dont;
  } else {
    $dont = 1;
  }
}
END{
  print "Answer: $sum\n";
}
