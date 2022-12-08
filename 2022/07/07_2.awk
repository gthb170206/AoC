function dirname(dir, _d){
  if ( dir == "/" )
    return dir;
  _d = dir;
  sub(/\/[^\/]+$/, "", _d);
  if ( _d == "" )
    return "/";
  return _d;
}
{
  if ( /^\$ cd / )
    if ( $3 ~ /^\// )
      cwd = $3;
    else if ( $3 == ".." )
      cwd = dirname(cwd);
    else
      if ( cwd ~ /\/$/ )
        cwd = cwd $3;
      else
        cwd = cwd "/" $3;
  else if ( /^\$ ls/ || /^dir / )
    next;
  else if ( /^[0-9]+ / ) {
    s = $1;
    d = cwd;
    du[d] += s;
    if ( d != "/" )
      do {
        d = dirname(d);
        du[d] += s;
      } while ( d != "/" );
  }
}
END{
  s = du["/"];
  a = 70000000 - s;
  n = 30000000 - a;
  for ( d in du ) {
    if ( du[d] < n )
      continue;
    if ( du[d] < s )
      s = du[d];
  }
  print "Answer: " s;
}
