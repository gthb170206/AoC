{
  split($1, one, /,/);
  split($3, two, /,/);
  if ( one[1] == two[1] || one[2] == two[2] ) {
    start_x = one[1];
    end_x = two[1];
    start_y = one[2];
    end_y = two[2];
  } else
    next;

  # Process coordinates
  for ( i = 0; ; i++ ) {
    if ( start_x <= end_x && (start_x + i) <= end_x )
      x = start_x + i;
    else if ( start_x >= end_x && (start_x - i) >= end_x )
      x = start_x - i;
    else
      x = start_x;

    if ( start_y <= end_y && (start_y + i) <= end_y )
      y = start_y + i;
    else if ( start_y >= end_y && (start_y - i) >= end_y )
      y = start_y - i;
    else
      y = start_y;

    # Plot points
    board[x,y]++;

    # Get max x/y values
    if ( max_x == "" || x > max_x )
      max_x = x;
    if ( max_y == "" || y > max_y )
      max_y = y;

    # Exit loop when all points have been plotted
    if ( x == end_x && y == end_y )
      break;
  }
}
END {
  # Print board (if no more than 24 rows/cols)
  if ( max_x <= 24 ) {
    for ( y = 0; y <= max_y; y++ ) {
      for ( x = 0; x <= max_x; x++ )
        if ( board[x,y] == "" )
          printf("%s", ".");
        else
          printf("%d", board[x,y]);
      print "";
    }
    for ( x = 0; x <= max_x; x++ )
      printf("%s", "=");
    print "";
  }

  # Count points with at least two overlaps
  for ( i in board ) {
    if ( board[i] >= 2)
      cnt++;
  }
  print "Answer: " cnt;
}
