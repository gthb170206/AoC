BEGIN {
  p = -1;
}
{
  if ( p != -1 && $1 > p )
    c++;
  p = $1;
}
END{
  print c;
}
