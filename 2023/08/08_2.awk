{
  if ( NF == 1 ) {
    gsub(/L/, 1);
    gsub(/R/, 2);
    n = split($1, lr, //);
  } else if ( NF == 4 ) {
    gsub(/[()]/, "");
    sub(/, /, ",");
    node[$1] = $NF;
    if ( $1 ~ /A$/ )
      pos[++idx] = $1;
  }
}
END{
  max = 0;
  for ( p = 1; p <= length(pos); p++ ) {
    for ( step = 0; ; step++ ) {
      idx = step % length(lr) + 1;
      split(node[pos[p]], a, /,/);
      pos[p] = a[lr[idx]];
      if ( pos[p] ~ /Z$/ ) {
        steps[p] = step + 1;
        if ( steps[p] > max ) {
          m_idx = p;
          max = steps[p];
        }
        break;
      }
    }
  }

  for ( i = 1; ; i++ ) {
    hit = 0;
    for ( j = 1; j <= length(steps); j++ ) {
      if ( j == m_idx )
        continue;
      t = (max * i) % steps[j];
      if ( t != 0 )
        break;
      hit++;
    }
    if ( hit == length(steps) - 1 ) {
      f = i;
      break;
    }
  }

  print "Answer: " max * f;
}
