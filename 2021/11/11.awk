BEGIN{
  delta[-1]++;
  delta[0]++;
  delta[1]++;
  rounds = 100;
}
{
  size_x = split($0, l, //);
  for ( j = 1; j <= size_x; j++ )
    data[NR,j] = l[j];
  size_y = NR;
}
END{
  # Run for the number of rounds specified above
  for ( round = 1; round <= rounds; round++ ) {
    f = 0;
    delete fl;

    # Increment all cells
    for ( yx in data )
      data[yx]++;

    # Process adjacent changes
    do {
      c = 0;
      delete ten;

      for ( yx in data )
        if ( data[yx] == 10 )
          ten[yx]++;

      for ( yx in ten ) {
        split(yx, a, SUBSEP);
        y = a[1];
        x = a[2];
        for ( dy in delta ) {
          for ( dx in delta ) {
            c++;
            t = y + dy SUBSEP x + dx;
            if ( t in data )
              if ( data[t] <= 9 || t == yx )
                data[t]++;
          }
        }
      }
    } while ( c > 0 );

    # Record changes and reset cells that have flashed
    for ( yx in data )
      if ( data[yx] >= 10 ) {
        flashes++;
        data[yx] = 0;
      }
  }
  print "Answer (after " rounds "rounds): " flashes;
}