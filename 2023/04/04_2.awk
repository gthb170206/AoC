{
  gsub(/  /, " ");
  sub(/$/, " ");
  n = split($0, a, /[:|]/);
  m = split(a[2], b, / /);
  card[NR] = 1;
  delete wins;
  for ( i = 2; i < m; i++ ) {
    wins[b[i]] = 1;
    re = " "b[i]" ";
    if ( match(a[3], re) )
      hits[NR]++;
  }
  cc = NR;
}
END{
  for ( i = 1; i <= cc; i++ )
    if ( hits[i] )
      for ( j = i + 1; j <= i + hits[i]; j++ )
        if ( j <= cc )
          card[j] += card[i];
  for ( i = 1; i <= cc; i++ )
    sum += card[i];
  print "Answer: "sum;
}
