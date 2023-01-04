function snafu_to_dec(s, _ans) {
  n = split(s, a, //);
  for ( i = 0; i < n; i++ )
    if ( a[n - i] == "=" )
      _ans -= 2 * 5 ^ i;
    else if ( a[n - i] == "-" )
      _ans -= 5 ^ i;
    else
      _ans += a[n - i] * 5 ^ i;
  return _ans;
}
function dec_to_snafu(n, _ans) {
  while ( n != 0 )
    if ( n % 5 == 4 ) {
      _ans = "-" _ans;
      n = int((n + 1) / 5);
    } else if ( n % 5 == 3 ) {
      _ans = "=" _ans;
      n = int((n + 2) / 5);
    } else {
      _ans = (n % 5) _ans;
      n = int(n / 5);
    }
  return _ans;
}
{
  ans += snafu_to_dec($0);
}
END{
  print "Answer: " dec_to_snafu(ans);
}
