#!/usr/bin/perl -an

push @col1, $F[0];
push @col2, $F[1];

END{
  @col1s = sort { $a <=> $b } @col1;
  @col2s = sort { $a <=> $b } @col2;
  for ( $i = 0; $i <= $#col1; $i++ ) {
    $sum += abs($col1s[$i] - $col2s[$i]);
  }
  print "Answer: $sum\n";
}
