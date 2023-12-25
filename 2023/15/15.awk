BEGIN{
  ord["-"] = 45;
  for ( i = 0; i <= 9; i++ ) ord[i] = 48 + i;
  ord["="] = 61;
  n = split("ABCDEFGHIJKLMNOPQRSTUVWXYZ", a, //);
  for ( i = 1; i <= n; i ++ ) ord[a[i]] = 64 + i;
  n = split("abcdefghijklmnopqrstuvwxyz", a, //);
  for ( i = 1; i <= n; i ++ ) ord[a[i]] = 96 + i;
}
{
  n = split($0, a, /,/);
  for ( i = 1; i <= n; i++ ) {
    s = 0;
    m = split(a[i], b, //);
    for ( j = 1; j <= m; j++ )
      s = 17 * ( s + ord[b[j]] ) % 256;
    ans += s;
  }
}
END{
  print "Answer: " ans;
}
