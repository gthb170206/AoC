{
  lines[NR] = $0;
}
END {
  n = length(lines[1]);

  for ( idx = 1; idx <= 2; idx++ ) {
    # Initial pattern
    m = "^";

    # Copy the lines array
    for ( line in lines )
      data[line] = lines[line];

    # Loop over the indices
    for ( j = 1; j <= n; j++ ) {
      # Empty statistics array
      delete stat;

      # Count the occurrence of the values in column j of data
      for ( i in data )
        stat[substr(data[i], j, 1)]++;

      # Extend the pattern
      if ( idx % 2 == 1 && stat[0] > stat[1] ||
           idx % 2 == 0 && stat[0] <= stat[1] )
        m = m "0";
      else
        m = m "1";

      # Filter the data
      for ( line in data )
        if ( data[line] !~ m )
          delete data[line];
      if ( length(data) == 1 )
        break;
    }

    # Process the data
    for ( line in data ) {
      l = split(data[line], a, //);
      for ( k = 1; k <= l; k++ )
        value[idx] += a[k] * 2 ** (l - k);
    }
  }
  print "Answer: " value[1] * value[2];
}
