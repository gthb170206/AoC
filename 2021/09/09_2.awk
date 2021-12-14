function get_basin(y, x) {
  for ( i in offsets ) {
    split(offsets[i], a, /,/);
    dy = a[1];
    dx = a[2];
    t = y + dy SUBSEP x + dx;
    if ( t in coords )
      ;
    else
      continue;
    if ( t in taken )
      continue;
    #if ( coords[t] == coords[y,x] + 1 && 
    if ( coords[t] > coords[y,x] && 
         coords[t] < 9 ) {
      taken[t]++;
      if ( coords[t] < 8 )
        get_basin(y + dy, x + dx);
    }
  }
}
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
    split(yx, a, SUBSEP);
    y = a[1];
    x = a[2];
    v = coords[yx]; # value

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
    for ( i in res )
      if ( v >= res[i] ) {
        r = -1;
        break;
      }

    if ( r == 0 )
      lows[++l_idx] = yx;
  }

  # Check the size of each basin
  for ( l_idx in lows ) {
    delete taken;
    yx = lows[l_idx];
    split(yx, l, SUBSEP);
    y = l[1];
    x = l[2];
    taken[yx]++;
    get_basin(y, x);
    for ( yx in taken )
      if ( taken[yx] > 1 ) {
        split(yx, l, SUBSEP);
        print "[" l[1] "," l[2] "] taken " taken[yx] " times";
      }
    sizes[l_idx] = length(taken);
  }

  # Sort the sizes
  for ( i in sizes ) {
    v = sizes[i];
    if ( length(answer) == 0 ) {
      answer[1] = v;
      continue;
    }

    for ( j = 1; j <= length(answer); j++ ) {
      if ( j == 1 && v < answer[j] )
        idx = j;
      else if ( j == length(answer) && v > answer[j] )
        idx = j + 1;
      else if ( v < answer[j] )
        idx = j;
      else
        continue;
      break;
    }

    if ( idx > length(answer) )
      answer[idx] = v;
    else {
      for ( j = length(answer); j >= idx; j-- )
        answer[j+1] = answer[j];
      answer[idx] = v;
    }
  }

  # Get the top three basin sizes
  prod = 1;
  for (j = length(answer); j >= length(answer) - 2; j-- )
    prod *= answer[j];
  print "Answer: " prod;
}
