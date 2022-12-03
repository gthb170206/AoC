BEGIN{
  prio = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
}
{
  if ( NR % 3 == 0 ) {
    n = split($0, a, //);
    for ( i = 1; i <= n; i++ )
      t[a[i]]++;
    for ( c in t )
      if ( index(l[1], c) && index(l[2], c) )
        ans += index(prio, c);
    delete l;
    delete t;
  } else
    l[NR % 3] = $0;
}
END{
  print "Answer:", ans;
}
