BEGIN{
  cubes["blue"] = 14;
  cubes["green"] = 13;
  cubes["red"] = 12;
}
{
  str = $0;
  sub(/^Game [0-9]*: /, "", str);
  game = $2;
  sub(/:/, "", game);
  while ( match(str, /[0-9]+ (blue|green|red)/) ) {
    m = substr(str, RSTART, RLENGTH);
    n = split(m, a, / +/);
    if ( cubes[a[2]] < a[1] )
      next;
    str = substr(str, RSTART + RLENGTH);
  }
  sum += game;
}
END{
  if ( sum > 0 )
    print "Answer: "sum;
}
