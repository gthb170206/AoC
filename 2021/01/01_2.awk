BEGIN {
  p=-1;
  c=0;
}
{
  a[1] = a[2];
  a[2] = a[3];
  a[3] = $1
  if ( NR >= 3 ) {
    #print a[1], a[2], a[3];
    s = a[1] + a[2] + a[3];
    if ( p != -1 && s > p )
      c++;
    #print s;
    p = s;
  }
}
END{
  print "INC: "c;
}
