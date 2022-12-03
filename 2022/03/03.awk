BEGIN{
  prio = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
}
{
  n = split(substr($0, length($0)/2+1), a, //);
  a[0] = substr($0, 1, length($0)/2);
  for ( i = 1; i <= n; i++ )
    t[a[i]]++;
  for ( c in t )
    if ( index(a[0], c) )
      ans += index(prio, c);;
  delete t;
}
END{
  print "Answer:", ans;
}
