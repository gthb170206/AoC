BEGIN{
  x = 1;
}
{
  v[++c] = x;
  if ( /^addx / ) {
    v[++c] = x;
    x += $2;
  }
}
END{
  for ( i = 20; i <= c; i += 40 )
    ans += i * v[i];
  print "Answer: " ans;
}
