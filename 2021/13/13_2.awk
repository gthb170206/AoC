{
  if ( NF == 1 ) {
    split($0, a, /,/);
    x = a[1];
    y = a[2];
    if ( max_y == "" || y > max_y )
      max_y = y;
    if ( min_y == "" || y < min_y )
      min_y = y;
    if ( max_x == "" || x > max_x )
      max_x = x;
    if ( min_x == "" || x < min_x )
      min_x = x;
    dots[y,x]++;
  } else if ( /^fold along / )
    folds[++i] = $NF;
}
END {
  # Fold according to instructions
  for ( i = 1; i <= length(folds); i++ ) {
    split(folds[i], a, /=/);
    if ( a[1] == "x" ) {
      for ( y = min_y; y <= max_y; y++ ) {
        for ( x = min_x; x < a[2]; x++ ) {
          c = y SUBSEP (max_x - x);
          if ( c in dots ) {
            dots[y,x]++;
            delete dots[c];
          }
        }
      }
      max_x = a[2] - 1;
    } else if ( a[1] == "y" ) {
      for ( x = min_x; x <= max_x; x++ ) {
        for ( y = min_y; y < a[2]; y++ ) {
          c = (max_y - y) SUBSEP x;
          if ( c in dots ) {
            dots[y,x]++;
            delete dots[c];
          }
        }
      }
      max_y = a[2] - 1;
    }
  }

  # Print array
  for ( y = min_y; y <= max_y; y++ ) {
    for ( x = min_x; x <= max_x; x++ ) {
      c = y SUBSEP x;
      if ( c in dots )
        printf("%s", "#");
      else
        printf("%s", " ");
    }
    print "";
  }
}
