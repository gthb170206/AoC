{
  if ( index($0, "#") ) {
    for ( i = index($0, "#"); i <= length($1); i++ ) {
      if ( substr($0, i, 1) == "#" ) {
        gxy[++g] = NR","i;
        pc[i]++;
      }
      cols = i;
    }
  } else
    er[NR]++
  rows = NR;
}
END{
  for ( c = 1; c <= cols; c++ )
    if ( ! pc[c] )
      ec[c]++;

  for ( i = 1; i < length(gxy); i++ ) {
    split(gxy[i], a, /,/);
    for ( j = i + 1; j <= length(gxy); j++ ) {
      dst = 0;
      split(gxy[j], b, /,/);
      if ( a[2] > b[2] ) {
        s = b[2];
        e = a[2];
      } else {
        s = a[2];
        e = b[2];
      }
      dst = e - s + b[1] - a[1];
      for ( x = s + 1; x < e; x++ )
        if ( ec[x] )
          dst++;
      for ( y = a[1] + 1; y < b[1]; y++ )
        if ( er[y] )
          dst++;
      ans += dst;
    }
  }
  print "Answer: "ans;
}
