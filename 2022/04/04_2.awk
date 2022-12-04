BEGIN{
  FS = ",";
}
{
  n = split($1, a, /-/);
  m = split($2, b, /-/);
  if ( a[1] <= b[2] && a[1] >= b[1] ||
       b[1] <= a[2] && b[1] >= a[1] )
    cnt++;
}
END{
  print "Answer:", cnt;
}
