{
  if ( NR == 1 )
    tmpl = $0;
  else if ( / -> / )
    rules[$1] = $3;
}
END {
  # Process the substitutions
  for ( i = 1; i <= 10; i++ ) {
    for ( j = 1; j < length(tmpl); j++ ) {
      tst = substr(tmpl, j, 2);
      if ( j == 1 ) {
        if ( i == 10 )
          stat[substr(tst, 1, 1)]++;
        res = substr(tst, 1, 1);
      }
      if ( tst in rules ) {
        if ( i == 10 )
          stat[rules[tst]]++;
        res = res rules[tst];
      }
      if ( i == 10 )
        stat[substr(tst, 2)]++;
      res = res substr(tst, 2);
    }
    tmpl = res;
  }

  # Process the statistics
  for ( s in stat ) {
    v = stat[s];
    if ( max == "" || v > max )
      max = v;
    if ( min == "" || v < min )
      min = v;
  }
  print "Answer: " max - min;
}