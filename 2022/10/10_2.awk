function abs(s) {
  if ( s < 0 )
    return -s;
  return s;
}
BEGIN{
  c = 0;
  x = 1;
}
{
  if ( /^noop/ ) {
    if ( abs(x-c%40) <= 1 )
      crt[int(c/40),c%40] = "#";
    else
      crt[int(c/40),c%40] = ".";
    c++;
  } else if ( /^addx / ) {
    for ( i = 1; i <= 2; i++ ) {
      if ( abs(x-c%40) <= 1 )
        crt[int(c/40),c%40] = "#";
      else
        crt[int(c/40),c%40] = ".";
      c++;
    }
    x += $2;
  }
}
END{
  y_max = int((length(crt)-1)/40);
  x_max = (length(crt)-1)%40;
  for ( y = 0; y <= y_max; y++ ) {
    for ( x = 0; x <= x_max; x++ )
      printf("%s", crt[y,x]);
    print "";
  }
}
