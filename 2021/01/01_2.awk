{
  c = b;
  b = a;
  a = $1;
  if ( NR >= 3 ) {
    s = a + b + c;
    if ( p != "" && s > p )
      d++;
    p = s;
  }
}
END{
  print "Answer: " d;
}
