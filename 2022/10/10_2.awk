function abs(s) {
  if ( s < 0 )
    return -s;
  return s;
}
BEGIN{
  x = 1;
}
{
  if ( abs(x-c%40) <= 1 )
    crt[int(c/40),c%40] = "#";
  else
    crt[int(c/40),c%40] = ".";
  c++;
  if ( /^addx / ) {
    if ( abs(x-c%40) <= 1 )
      crt[int(c/40),c%40] = "#";
    else
      crt[int(c/40),c%40] = ".";
    c++;
    x += $2;
  }
}
END{
  for ( y = 0; y <= int((length(crt)-1)/40); y++ ) {
    for ( x = 0; x <= (length(crt)-1)%40; x++ )
      printf("%s", crt[y,x]);
    print "";
  }
}
