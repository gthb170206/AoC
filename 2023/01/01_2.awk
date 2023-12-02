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
      l = 2;
      while ( l < length($0) ) {
        ss = substr($0, length($0) - l);
        if ( match(ss, /[1-9]/) )
          l = length($0);
        else if ( match(ss, reg) ) {
          m = substr(ss, RSTART, RLENGTH);
          sub(m, num[m], ss);
          $0 = substr($0, 1, length($0) - l - 1) ss;
          l = length($0);
        } else
          l++;
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
