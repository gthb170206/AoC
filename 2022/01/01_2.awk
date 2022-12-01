BEGIN{
  max = 0;
  a[1] = 0;
  a[2] = 0;
  a[3] = 0;
}
{
  if ( /^$/ ) {
    for (j = 1; j <= 3; j++) {
      if ( s > a[j] ) {
        for ( m = 3; m > j; m-- )
          a[m] = a[m-1];
        a[j] = s;
        break;
      }
    }
    s = 0;
  } else {
    s += $1;
  }
}
END {
  for (j = 1; j <= 3; j++) {
    if ( s > a[j] ) {
      for ( m = 3; m > j; m-- )
        a[m] = a[m-1];
      a[j] = s;
      break;
    }
  }
  sum = 0;
  for (j = 1; j <= 3; j++)
    sum += a[j];
  print "Sum: "sum;
}
