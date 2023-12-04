{
  gsub(/  /, " ");
  sub(/$/, " ");
  n = split($0, a, /[:|]/);
  m = split(a[2], b, / /);
  delete wins;
  for ( i = 2; i < m; i++ )
    wins[b[i]] = 1;
  hit = -1;
  for ( w in wins ) {
    re = " "w" ";
    if ( match(a[3], re) )
      hit++;
  }
  if ( hit >= 0 )
    sum += 2 ** hit;
}
END{
  print "Answer: "sum;
}
