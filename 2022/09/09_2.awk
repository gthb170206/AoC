function abs(s) {
  if ( s < 0 )
    return -s;
  return s;
}

BEGIN{
  # Register start position
  cov[0,0]++;

  # Initial positions
  for ( i = 0; i <= 9; i++ )
    t[i] = 0 SUBSEP 0;
}
{
  if ( /^[UDLR] [0-9]+$/ ) {
    d = $1;
    s = $2
    split(t[0], h, SUBSEP);
    for ( m = 1; m <= s; m++ ) {
      # Move head
      if      ( d == "U" )
        h[2]++;
      else if ( d == "D" )
        h[2]--;
      else if ( d == "R" )
        h[1]++;
      else if ( d == "L" )
        h[1]--;

      # Save new head position
      t[0] = h[1] SUBSEP h[2];

      # Check if tail needs to move
      for ( i = 1; i <= 9; i++ ) {
        split(t[i-1], p, SUBSEP);
        split(t[i],   a, SUBSEP);
        if     ( p[1] == a[1] ) {
          if      ( p[2] - a[2] > 1 )
            a[2]++;
          else if ( p[2] - a[2] < -1 )
            a[2]--;
        } else if ( p[2] == a[2] ) {
          if      ( p[1] - a[1] > 1 )
            a[1]++;
          else if ( p[1] - a[1] < -1 )
            a[1]--;
        } else if ( abs(p[1] - a[1]) > 1 || abs(p[2] - a[2]) > 1 ) {
          if      ( p[1] > a[1] )
            a[1]++;
          else if ( p[1] < a[1]  )
            a[1]--;
          if      ( p[2] > a[2] )
            a[2]++;
          else if ( p[2] < a[2] )
            a[2]--;
        }

        # Save new position
        t[i] = a[1] SUBSEP a[2];

        # Register tail position
        if ( i == 9 )
          cov[a[1],a[2]]++;
      }
    }
  }
}
END{
  print "Answer: " length(cov);
}
