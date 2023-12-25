{
  l[NR] = $0;
}
END{
  for ( i = 1; i <= length(l); i++ ) {
    #print "li: " l[i];
    split(l[i], t, / */);

    n = split(t[2], a, /,/);
    re = "";
    tl = n - 1;
    for ( j = 1; j <= n; j++ ) {
      re = re ? re"[.?]+[#?]{"a[j]"}" : "[#?]{"a[j]"}";
      tl += a[j]
    }
    ts = t[1];
    #print "ts: " ts;
    sub(/^\.+/, "", ts);
    sub(/\.+$/, "", ts);
    gsub(/\.{2,}/, ".", ts);
    #gsub(/\?\.{2,}\?/, "?.?", ts);
    #print "ts': " ts;
    #print "re: " re;
    if ( match(ts, re) ) {
      ms = substr(ts, RSTART, RLENGTH);
      #print "ms: " ms " (" RLENGTH " :: " tl ")";

      if ( RLENGTH == tl ) {
        #print "Arrangements: 1";
        print "Arrangements (" i "): 1";
        ans++;
      } else {
        m = split(ms, b, /\./);
        if ( n == m ) {
          #printf "%s:", "Groups";
          arr = 1;
          for ( k = 1; k <= m; k++ ) {
            #printf " %s :: %s", a[k], b[k];
            arr *= length(b[k]) - a[k] + 1;
          }
          #print "";
          #print "Arrangements: " arr;
          print "Arrangements (" i "): " arr;
          ans += arr
        } else if ( ms ~ /^#/ ) {
          ms = substr(ms, a[1] + 1);
          #print "ms' = " ms " (" length(ms) ")";
          if ( index(ms, ".") == 0 ) {
            c = 0;
            for ( k = 2; k <= n; k++ )
              c += a[k];
            c += n - 2;
            arr = (length(ms) - c) * (length(ms) - c + 1) / 2;
            print "Arrangements (" i "): " arr;
            ans += arr
          } else {
            print "li = " l[i] " (" i ")";
            print "ts = " ts;
            print "re = " re;
            print "ms = " ms;
            print "index(" ms ", \".\") = " index(ms, ".");
          }
        } else if ( ms ~ /#$/ ) {
          print "ms: " ms;
          ms = substr(ms, 1, length(ms) - a[n] - 1);
          print "li = " l[i] " (" i ")";
          print "ts = " ts;
          print "re = " re;
          print "ms' = " ms " (" length(ms) ")";
          if ( index(ms, ".") == 0 ) {
            c = 0;
            for ( k = 1; k < n; k++ )
              c += a[k];
            c += n - 2;
            arr = (length(ms) - c) * (length(ms) - c + 1) / 2;
            #print "Arrangements: " arr;
            print "Arrangements (" i "): " arr;
            ans += arr
          } else
            print "index(" ms ", \".\") = " index(ms, ".");
        } else {
          print "li = " l[i] " (" i ")";
          print "ts = " ts;
          print "re = " re;
          print "ms = " ms;
          print "No arrangements found (" i ")";
        }
      }
    } else
      print "ERROR: No match!";
    if ( i != length(l) )
      print "===";
  }

  print "Answer: " ans;
}
