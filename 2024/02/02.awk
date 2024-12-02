{
  delete diff;
  for ( i = 1; i < NF; i++ )
    diff[i] = $(i + 1) - $i;
  if ( (diff[1] >= 1) && (diff[1] <= 3) ) {
    for ( i = 2; i < NF; i++ ) {
      if ( (diff[i] < 1) || (diff[i] > 3) )
        invalid[NR]++;
    }
  } else if ( (diff[1] >= -3) && (diff[1] <= -1) ) {
    for ( i = 2; i < NF; i++ ) {
      if ( (diff[i] > -1) || (diff[i] < -3) )
        invalid[NR]++;
    }
  } else
    invalid[NR]++;
  if ( invalid[NR] == 0 )
    valid++;
}
END{
  print "Answer:", valid;
}
