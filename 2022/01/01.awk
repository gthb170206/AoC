{
  if ( /^$/ ) {
    if ( s > ans )
      ans = s;
    s = 0;
  } else
    s += $1;
}
END {
  if ( s > ans )
    ans = s;
  print "Answer:", ans;
}
