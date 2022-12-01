BEGIN{
  max = 0;
}
{
  if ( /^$/ ) {
    if ( s > max )
      max = s;
    s = 0;
  } else
    s += $1;
}
END {
  if ( s > max )
    max = s;
  print "Max: "max;
}
