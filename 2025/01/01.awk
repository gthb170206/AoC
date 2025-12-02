BEGIN{
  pos = 50;
  sum = 0;
}
{
  printf "%s: %d => ", $0, pos;
  d = substr($0, 1, 1);
  c = substr($0, 2);
  if ( d == "L" )
    pos = ( 100 + pos -c ) % 100;
  else
    pos = ( pos + c ) % 100;
  if ( pos == 0 )
    sum++;
  printf "%d :: %d\n", pos, sum;
}
END{
  print "Answer:", sum;
}
