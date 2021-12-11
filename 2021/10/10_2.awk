BEGIN{
  value[")"] = 1;
  value["]"] = 2;
  value["}"] = 3;
  value[">"] = 4;
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
      if ( open[length(open)] != start )
        break;
      else
        delete open[length(open)];
    }
    if ( i == n && length(open) >= 1 ) {
      o = "";
      for ( j = 1; j <= length(open); j++ )
        o = o open[j];
      added = "";
      for ( j = length(open); j >= 1; j-- ) {
        c = substr(chars, index(chars, open[j]) + 1, 1);
        added = added c;
        points[NR] = points[NR] * 5 + value[c];
      }
    }
  }
}
END{
  for ( i in points ) {
    v = points[i]
    if ( length(answer) == 0 ) {
      answer[1] = points[i];
      continue;
    }
    for ( j = 1; j <= length(answer); j++ ) {
      if ( j == 1 && v < answer[j] )
        idx = j;
      else if ( j == length(answer) && v > answer[j] )
        idx = j+ 1;
      else if ( v < answer[j] )
        idx = j;
      else
        continue;
      break;
    }
    if ( idx > length(answer) )
      answer[idx] = v;
    else {
      for ( j = length(answer); j >= idx; j-- )
        answer[j+1] = answer[j];
      answer[idx] = v;
    }
  }
  idx = (length(answer) + 1) / 2;
  print "Answer (" idx "/" length(answer) "): " answer[idx];
}