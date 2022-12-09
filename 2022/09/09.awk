function abs(s) {
  if ( s < 0 )
    return -s;
  return s;
}

BEGIN{
  # Register start position
  cov[0,0]++;

  # Initial positions
  h_x = 0;
  h_y = 0;
  t_x = 0;
  t_y = 0;
}
{
  if ( /^[UDLR] [0-9]+$/ ) {
    d = $1;
    s = $2
    for ( i = 1; i <= s; i++ ) {
      # Move head
      if      ( d == "U" )
        h_y++;
      else if ( d == "D" )
        h_y--;
      else if ( d == "R" )
        h_x++;
      else if ( d == "L" )
        h_x--;

      # Check if tail needs to move
      if     ( h_x == t_x ) {
        if      ( h_y - t_y > 1 )
          t_y++;
        else if ( h_y - t_y < -1 )
          t_y--;
      } else if ( h_y == t_y ) {
        if      ( h_x - t_x > 1 )
          t_x++;
        else if ( h_x - t_x < -1 )
          t_x--;
      } else if ( abs(h_x - t_x) > 1 || abs(h_y - t_y) > 1 ) {
        if      ( h_x > t_x )
          t_x++;
        else if ( h_x < t_x  )
          t_x--;
        if      ( h_y > t_y )
          t_y++;
        else if ( h_y < t_y )
          t_y--;
      }

      # Register tail position
      cov[t_x,t_y]++;
    }
  }
}
END{
  print "Answer: " length(cov);
}
