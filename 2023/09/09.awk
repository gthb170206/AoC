{
  delete data;
  data[0] = $0;
  for ( i = 1; ; i++ ) {
    n = split(data[i-1], a, / +/);
    sum = 0
    for ( j = 2; j <= n; j++ ) {
      d = a[j] - a[j-1];
      if ( data[i] != "" )
        data[i] = data[i]" "d;
      else
        data[i] = d;
      sum += d;
    }
    if ( sum == 0 )
      break;
  }
  for ( c = length(data) - 1; c >= 1; c-- ) {
    n = split(data[c-1], a, / +/);
    m = split(data[c], b, / +/);
    v = b[m] + a[n];
    data[c-1] = data[c-1]" "v;
    if ( c == 1 )
      ans += v;
  }
}
END{
  print "Answer: "ans;
}
