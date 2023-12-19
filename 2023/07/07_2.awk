BEGIN{
  ltrs="A,B,C,D,E,F,G,H,I,J,K,L,M";
  cards="J,2,3,4,5,6,7,8,9,T,Q,K,A";
  n = split(cards, a, /,/);
  m = split(ltrs, b, /,/);
  for ( i = 1; i <= n; i++ ) {
    card[a[i]] = i + 1;
    ltr[a[i]] = b[i];
  }
}
{
  delete test;
  hand[NR] = $1;
  n = split($1, h, //);
  for ( c = 1; c <= n; c++ ) {
    test[ltr[h[c]]]++;
    s = ( c == 1 ) ? ltr[h[c]] : s ltr[h[c]];
  }
  str[NR] = s;
  bet[s] = $2;

  point = 0;
  if ( length(test) == 5 ) {
    if ( index(s, "A") == 0 )
      point = 1; # five different cards
    else
      point = 2; # one pair
  } else if ( length(test) == 4 ) {
    if ( index(s, "A") == 0 )
      point = 2; # one pair
    else
      point = 4; # three of a kind
  } else if ( length(test) == 3 ) {
    for ( t in test )
      if ( test[t] == 3 ) {
        if ( index(s, "A") == 0 )
          point = 4; # three of a kind
        else
          point = 6; # four of a kind
      } else if ( !point && test[t] == 2 ) {
        if ( index(s, "A") == 0 )
          point = 3; # two pairs
        else if ( test["A"] == 1 )
          point = 5; # full house
        else
          point = 6; # four of a kind
    }
  } else if ( length(test) == 2 ) {
    if ( index(s, "A") == 0 ) {
      for ( t in test )
        if ( test[t] == 4 )
          point = 6; # four of a kind
        else if ( test[t] == 3 )
          point = 5; # full house
    } else
      point = 7; # five of a kind
  } else if ( length(test) == 1 )
    point = 7; # five of a kind
  points[point] = points[point] ? points[point]","NR : NR;
}
END{
  for ( i = 1; i <= 7; i++ )
    if ( points[i] ) {
      delete arr;
      delete sarr;
      n = split(points[i], a, /,/);
      for ( j = 1; j <= n; j++ )
        arr[str[a[j]]]++;
      sort(arr, sarr);
      for ( v = 1; v <= length(sarr); v++ )
        ans += ++rank * bet[sarr[v]];
    }
  print "Answer: "ans;
}

function sort(arr, idxs, args, i, str, cmd) {
  for (i in arr) {
    gsub(/\047/, "\047\\\047\047", i);
    str = str i ORS;
  }

  cmd = "printf \047%s\047 \047" str "\047 | sort " args;

  i = 0;
  while ( (cmd | getline idx) > 0 )
    idxs[++i] = idx;

  close(cmd);

  return i;
}
