{
  if ( p != "" && $1 > p )
    c++;
  p = $1;
}
END{ print c; }
