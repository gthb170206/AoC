#!/usr/bin/perl -n

while ( /mul\((\d+),(\d+)\)/og ) {
  $sum += $1 * $2;
}
END{
  print "Answer: $sum\n";
}
