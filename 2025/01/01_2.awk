BEGIN{
  pos = 50;
  sum = 0;
}
{
  d = substr($0, 1, 1);
  c = substr($0, 2);
  ppos = pos;
  if ( d == "L" ) {
    ds = int(c / 100);
    pos -= c % 100;
    if ( ppos != 0 && pos == 0 )
      ds++;
    else if ( pos < 0 ) {
      if ( ppos != 0 ) ds++;
      pos += 100;
    }
  } else {
    ds = int(c / 100);
    pos += c % 100;
    if ( ppos != 0 && pos == 0 )
      ds++;
    else if ( pos >= 100 ) {
      ds++;
      pos -= 100;
    }
  }
  sum += ds;
}
END{
  print "==============";
  print "Answer:", sum;
}
