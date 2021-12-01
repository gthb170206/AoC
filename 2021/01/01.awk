BEGIN {
  p=-1;
  c=0;
}
{
  if ( p != -1 && $1 > p )
    c++;
  p=$1
}
END{
  print c;
}
