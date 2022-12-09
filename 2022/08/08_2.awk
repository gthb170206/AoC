{
  n = split($0, a, //);
  x_max = n;
  y_max = NR;
  for ( i = 1; i <= n; i++ )
    data[NR,i] = a[i];
}
END{
  # Check all trees
  for ( y = 2; y < y_max; y++ )
    for ( x = 2; x < x_max; x++ ) {
      curr = data[y,x];

      # Look up
      for ( u = 1; u < y; u++ )
        if ( y-u == 1  ||
             data[y-u,x] >= curr )
          break;

      # Look down
      for ( d = 1; d <= y_max - y; d++ )
        if ( y+d == y_max ||
             data[y+d,x] >= curr )
          break;

      # Look left
      for ( l = 1; l < x; l++ )
        if ( x-l == 1 ||
             data[y,x-l] >= curr )
          break;


      # Look right
      for ( r = 1; r <= x_max - x; r++ )
        if ( x+r == x_max ||
             data[y,x+r] >= curr )
          break;

      score[y,x] = u * d * l * r;
      #print "score[" y "," x "] = " u "*" d "*" l "*" r " => " score[y,x];
    }

  ans=0;
  for ( yx in score ) {
    if ( score[yx] > ans )
      ans = score[yx];
  }
  print "Answer: " ans;
}
