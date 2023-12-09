{
  if ( /^Time:/ )
    for ( i = 2; i <= NF; i++ )
      time[i - 1] = $i;
  else if ( /^Distance:/ )
    for ( i = 2; i <= NF; i++ )
      dist[i - 1] = $i;
}
END{
  for ( i = 1; i <= length(time); i++ ) {
    for ( t = 1; t < time[i]; t++ )
      if ( (time[i] - t) > (dist[i] / t) )
        wins[i]++;
      else if ( wins[i] )
        break;
  }
  ans = 1;
  for ( w in wins )
    ans *= wins[w];
  print "Answer: "ans;
}
