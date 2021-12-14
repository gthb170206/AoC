{
  if ( NR == 1 )
    tmpl = $0;
  else if ( / -> / )
    rules[$1] = $3;
}
END {
  # Get the initial pairs
  for ( j = 1; j < length(tmpl); j++ )
    pairs[substr(tmpl, j, 2)]++;

  # Process the substitutions
  for ( i = 1; i <= 40; i++ ) {
    delete opairs;
    for ( pair in pairs ) {
      split(pair, a, //);
      if ( pair in rules ) {
        opairs[a[1] rules[pair]] += pairs[pair];
        opairs[rules[pair] a[2]] += pairs[pair];
      } else {
        opairs[pair] += pairs[pair];
      }
    }
    delete pairs;
    for ( pair in opairs )
      pairs[pair] = opairs[pair]
  }

  # Generate statistics (only count the first character in the pairs)
  for ( pair in pairs ) {
    split(pair, a, //);
    stat[a[1]] += pairs[pair];
  }
  
  # Add the final character from the template to the statistics
  stat[substr(tmpl, length(tmpl))]++;

  # Process the statistics
  for ( s in stat ) {
    v = stat[s];
    print "stat[" s "]: " v;
    if ( max == "" || v > max )
      max = v;
    if ( min == "" || v < min )
      min = v;
  }
  print "Answer: " max - min;
}