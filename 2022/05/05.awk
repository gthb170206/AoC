{
  if ( NF != 0 && /\[/ )
    lines[++i] = $0;
  else if ( NF == 0 ) {
    for ( i = length(lines) ; i >= 1; i-- ) {
      n = split(lines[i], a, //);
      j = 1;
      for ( p = 2; p < length(lines[i]); p += 4 ) {
        if ( a[p] != " " )
          if ( piles[j] )
            piles[j] = piles[j] a[p];
          else
            piles[j] = a[p];
        j++;
      }
    }
  } else if ( /^move/ ) {
    c = $2;
    f = $4;
    t = $6;
    for ( n = 1; n <= c; n++ ) {
      piles[t] = piles[t] substr(piles[f], length(piles[f]), 1);
      piles[f] = substr(piles[f], 1, length(piles[f]) - 1);
    }
  }
}
END {
  printf "Answer: ";
  for ( p = 1; p <= length(piles); p++ )
    printf "%s", substr(piles[p], length(piles[p]), 1);
  print "";
}
