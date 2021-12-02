BEGIN {
  p =- 1;
}
{
  c = b;
  b = a;
  a = $1;
  if ( NR >= 3 ) {
    s = a + b + c;
    if ( p != -1 && s > p )
      d++;
    p = s;
  }
}
END{
  print d;
}
