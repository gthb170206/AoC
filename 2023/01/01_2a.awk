BEGIN{
  sum = 0;
  reg = "one|two|three|four|five|six|seven|eight|nine";
  n = split(reg, a, /\|/);
  for ( i in a )
    num[a[i]] = i;
}
{
  if ( !/^[1-9]/ || !/[1-9]$/ ) {
    # First digit
    if ( !/^[1-9]/ && match($0, reg) ) {
      m = substr($0, RSTART, RLENGTH);
      s = RSTART;
      if ( s < match($0, /[1-9]/) || !match($0, /[1-9]/) )
        sub(m, num[m]);
    }

    # Last digit
    if ( !/[1-9]$/ ) {
      if ( match($0, reg) ) {
        n = 0;
        s = 0;
        t = $0;
        while ( match(t, reg) ) {
          m = substr(t, RSTART, RLENGTH)
          s += RSTART + n;
          t = substr(t, RSTART + RLENGTH - 1);
          n = RLENGTH - 2;
        }
        if ( t !~ /[1-9]/ )
          $0 = substr($0, 1, s - 1) num[m] substr(t, 2);
      }
    }
  }
  gsub(/[a-z]/, "");
  n = split($0, a, //);
  sum += 10 * a[1] + a[n];
}
END {
  print "Answer: "sum;
}
