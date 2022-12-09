{
  n = split($0, a, //);
  x_max = n;
  y_max = NR;
  for ( i = 1; i <= n; i++ )
    data[NR,i] = a[i];
}
END{
  # From the left
  for ( y = 2; y < y_max; y++ ) {
    m = data[y,1];
    for ( x = 2; x < x_max; x++ ) {
      if ( data[y,x] <= m )
        continue;
      m = data[y,x];
      if ( hit[y,x] == 0 )
        ans++;
      hit[y,x]++;
    }
  }

  # From the top
  for ( x = 2; x < x_max; x++ ) {
    m = data[1,x];
    for ( y = 2; y < y_max; y++ ) {
      if ( data[y,x] <= m )
        continue;
      m = data[y,x];
      if ( hit[y,x] == 0 )
        ans++;
      hit[y,x]++;
    }
  }

  # From the right
  for ( y = y_max -1; y > 1; y-- ) {
    m = data[y,x_max];
    for ( x = x_max - 1; x > 1; x-- ) {
      if ( data[y,x] <= m )
        continue;
      m = data[y,x];
      if ( hit[y,x] == 0 )
        ans++;
      hit[y,x]++;
    }
  }

  # From the bottom
  for ( x = x_max - 1; x > 1; x-- ) {
    m = data[y_max,x];
    for ( y = y_max -1; y > 1; y-- ) {
      if ( data[y,x] <= m )
        continue;
      m = data[y,x];
      if ( hit[y,x] == 0 )
        ans++;
      hit[y,x]++;
    }
  }

  # Include the edge trees
  print "Answer: " ans + 2 * ( x_max - 1 + y_max - 1 );
}
