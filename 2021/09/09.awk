BEGIN{
  offsets[1] = "0,-1";
  offsets[2] = "0,1";
  offsets[3] = "-1,0";
  offsets[4] = "1,0";
}
{
  size_x = split($0, l, //);
  y = NR;
  for ( x = 1; x <= size_x; x++ )
    coords[y,x] = l[x];
  size_y = y;
}
END{
  for ( yx in coords ) {
    v = coords[yx];
    split(yx, a, SUBSEP);
    y = a[1];
    x = a[2];

    delete res;
    for ( i in offsets ) {
      split(offsets[i], a, /,/);
      dy = a[1];
      dx = a[2];
      t = y + dy SUBSEP x + dx;

      if ( t in coords )
        res[i] = coords[t];
    }

    r = 0;
    for ( i in res ) {
      if ( v >= res[i] ) {
        r = -1;
        break;
      }
    }

    if ( r == 0 ) {
      sum += v + 1;
      lows[++l_idx] = yx;
    }
  }
  print "Risk: "sum;
}