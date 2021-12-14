/^[01]/ {
  n = split($0, a, //);
  for ( i = 1; i <= n; i++ ) {
    ( a[i] == 0 ) && z[i]++
    ( a[i] == 1 ) && o[i]++
  }
}
END {
  for ( i = 1; i <= n; i++ ) {
    if ( o[i] > z[i] ) {
      eb = eb"0";
      gb = gb"1";
      gn += 2 ** (n - i);
    } else {
      eb = eb"1";
      gb = gb"0";
      en += 2 ** (n - i);
    }
  }
  print "Answer: " gn * en;
}
