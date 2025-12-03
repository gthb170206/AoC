BEGIN {
  sum = 0;
}
{
  n = split($1, a, //);
  f = 0;
  s = 0;
  for ( i = 1; i <= n; i++ )
    if ( a[i] > f && i != n ) {
      f = a[i];
      p = i;
    }
  for ( i = p + 1; i <= n; i++ )
    if ( a[i] > s )
      s = a[i];
  sum += 10 * f + s;
}
END{
  print "Answer:", sum;
}
