#!/usr/bin/perl -an

push @col1, $F[0];
$col2{$F[1]}++;

END{
  $sum += $_ * $col2{$_} foreach ( @col1 );
  print "Answer: $sum\n";
}
