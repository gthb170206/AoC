BEGIN{
  value[")"] = 3;
  value["]"] = 57;
  value["}"] = 1197;
  value[">"] = 25137;
  chars = "()[]{}<>";
}
{
  n = split($0, a, //);
  delete open;
  for ( i = 1; i <= n; i++ ) {
    chr = a[i];
    idx = index(chars, chr);
    if ( idx % 2 == 1 )
      open[length(open) + 1] = chr;
    else {
      start = substr(chars, idx - 1, 1);
      if ( open[length(open)] != start ) {
        sum += value[chr];
        break;
      } else {
        start = open[length(open)];
        delete open[length(open)];
      }
    }
  }
}
END{
  print "Answer: " sum;
}
