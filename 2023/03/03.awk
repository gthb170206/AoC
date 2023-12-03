{
  lines[NR] = $0;
  if ( match($0, /[^0-9.]/) ) {
    s = 0;
    t = $0;
    while ( match(t, /[^0-9.]/) ) {
      s += RSTART;
      symbol[NR, s] = substr(t, RSTART, 1);
      t = substr(t, RSTART + 1);
    }
  }
  lc = NR;
}
END{
  #for ( l in lines ) {
  for ( l = 1; l <= lc; l++ ) {
    if ( !match(lines[l], /[0-9]/) )
      continue;
    s = 0;
    t = lines[l];
    while ( match(t, /[0-9]+/) ) {
      m = substr(t, RSTART, RLENGTH);
      s += RSTART;
      hit = 0;
      for ( y = l - 1; y <= l + 1; y++ ) {
        if ( hit == 1 || y == 0 || y > lc )
          continue
        for ( x = s - 1; x <= s + RLENGTH; x++ ) {
          if ( hit == 1 || x == 0 || x > length(lines[l]) )
            continue;
          if ( symbol[y,x] )
            hit = 1;
        }
      }
      if ( hit == 1 )
        sum += m;
      s += RLENGTH - 1;
      t = substr(t, RSTART + RLENGTH);
    }
  }
}
END{
  print "Answer: "sum;
}
