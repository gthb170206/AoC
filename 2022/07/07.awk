function basename(dir, _d){
  if ( dir == "/" )
    return dir;
  _d = dir;
  sub(/\/[^\/]+$/, "", _d);
  if ( _d != "" )
    return "/";
  return _d;
}
{
  if ( /^\$ cd / )
    if ( $3 ~ /^\// )
      cwd = $3;
    else if ( $3 == ".." )
      cwd = basename(cwd);
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
        d = basename(d);
        du[d] += s;
      } while ( d != "/" );
  }
}
END{
  for ( d in du ) {
    if ( du[d] > 100000 )
      continue;
    ans += du[d];
  }
  print "Answer: " ans;
}
