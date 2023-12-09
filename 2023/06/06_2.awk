{
  if ( /^Time:/ ) {
    gsub(/[^0-9]/, "");
    time = $0;
  } else if ( /^Distance:/ ) {
    gsub(/[^0-9]/, "");
    dist = $0;
  }
}
END{
  # Find the first value
  for ( t = 1; t <= time; t++ )
    if ( (time - t) > (dist / t) )
      break;
  first = t;

  # Find the last value
  for ( t = time - 1; t > first; t-- )
    if ( (time - t) > (dist / t) )
      break;
  last = t;

  ans = last - first + 1;
  print "Answer: "ans;
}
