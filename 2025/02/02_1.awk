BEGIN{
  FS = "-";
  RS = ",";
  OFS = " ";
  dbg = 0;
  sum = 0;
}
{
  sub(/\n/, "", $2);
  a = $1;
  b = $2;
  if ( length($1) % 2 == 1 )
    a = 10 ^ length($1);
  if ( length($2) % 2 == 1 )
    b = 10 ^ (length($2)-1) - 1;
  if ( dbg != 0 ) {
    if ( a != $1 || b != $2 )
      print $0" => "a"-"b":";
    else
      print a"-"b":";
  }
  if ( a <= b ) {
    l = int(substr(a, 1, length(a) / 2));
    h = int(substr(b, 1, length(b) / 2))
    if ( dbg != 0 ) print "limits:", l, ":", h;
    for ( i = l; i <= h; i++ ) {
      t = sprintf("%0.0f%0.0f", i , i);
      if ( dbg != 0 ) print i, "->" t;
      if ( t >= a && t <= b ) {
        if ( dbg != 0 ) printf "  * %0.0f => ", t;
        sum += t;
        if ( dbg != 0 ) print sum;
      }
    }
  }
}
END{
  print "Answer:", sum;
}
