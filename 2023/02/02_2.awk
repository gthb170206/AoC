{
  str = $0;
  sub(/^Game [0-9]*: /, "", str);
  game = $2;
  sub(/:/, "", game);
  while ( match(str, /[0-9]+ (blue|green|red)/) ) {
    m = substr(str, RSTART, RLENGTH);
    n = split(m, a, / +/);
    if ( cubes[a[2]] < a[1] )
      cubes[a[2]] = a[1];
    str = substr(str, RSTART + RLENGTH);
  }
  pow = 1;
  for ( c in cubes )
    pow *= cubes[c];
  sum += pow;
  delete cubes;
}
END{
  if ( sum > 0 )
    print "Answer: "sum;
}
