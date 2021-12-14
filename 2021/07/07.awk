{
  n = split($0, a, /,/);
}
END{
  for ( i = 1; i <= n; i++ ) {
    data[i]++;
    if ( max == "" || a[i] > max )
      max = a[i];
    if ( min == "" || a[i] < min )
      min = a[i];
  }
  for ( j = min; j <= max; j++ ) {
    if ( j in data )
      ;
    else
      continue;
    fuel = "";
    for ( i = 1; i <= n; i++ )
      if ( a[i] >= j )
        fuel += a[i] - j;
      else
        fuel += j - a[i];
    if ( min_fuel == "" || fuel < min_fuel )
      min_fuel = fuel;
    else
      break;
  }
  print "Answer: " min_fuel " at " j;
}
