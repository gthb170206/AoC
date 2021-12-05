{
  lines[NR] = $0;
}
END {
  n = length(lines[1]);

  for ( idx = 1; idx <= 2; idx++ ) {
    # Initial pattern
    m = "^";

    # Copy the lines array
    for ( i in lines )
      data[i] = lines[i];

    # Loop over the indices
    for ( j = 1; j <= n; j++ ) {
      # Empty statistics array
      delete stat;

      # Count the occurrence of the values in column j of data
      for ( i in data )
        stat[substr(data[i], j, 1)]++;

      # Extend the pattern
      if ( ( idx % 2 ) == 1 && stat[0] > stat[1] ||
           ( idx % 2 ) == 0 && stat[0] <= stat[1] )
        m = m"0";
      else
        m = m"1";

      # Filter the list
      for ( i in data )
        if ( data[i] !~ m )
          delete data[i];
      if ( length(data) == 1 )
        break;
    }

    for ( i in data ) {
      l = split(data[i], a, //);
      for ( k = 1; k <= l; k++ )
        value[idx] += a[k] * 2 ** (l - k);
    }
  }
  print "ans: " value[1] * value[2] " (" value[1] " * " value[2] ")";
}
