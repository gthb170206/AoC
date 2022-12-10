BEGIN{
  c = 0;
  x = 1;
}
{
  if ( /^noop/ )
    v[++c] = x;
  else if ( /^addx / ) {
    v[++c] = x;
    v[++c] = x;
    x += $2;
  }
}
END{
  for ( i = 20; i <= 220; i += 40 )
    ans += i * v[i];
  print "Answer: " ans;
}
