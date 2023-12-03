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
  for ( l = 1; l <= lc; l++ ) {
    if ( !match(lines[l], /[0-9]/) )
      continue;
    s = 0;
    t = lines[l];
    while ( match(t, /[0-9]+/) ) {
      m = substr(t, RSTART, RLENGTH);
      s += RSTART;
      for ( y = l - 1; y <= l + 1; y++ ) {
        if ( y == 0 || y > lc )
          continue
        for ( x = s - 1; x <= s + RLENGTH; x++ ) {
          if ( x == 0 || x > length(lines[l]) )
            continue;
          if ( symbol[y,x] == "*" )
            hit[y,x]++;
            if ( hit[y,x] == 1 )
              prod[y,x] = m;
            else if ( hit[y,x] == 2 )
              prod[y,x] *= m;
            else
              prod[y,x] = 1;
        }
      }
      s += RLENGTH - 1;
      t = substr(t, RSTART + RLENGTH);
    }
  }
}
END{
  for ( yx in prod ) {
    if ( hit[yx] != 2 )
      continue;
    sum += prod[yx];
  }
  print "Answer: "sum;
}
