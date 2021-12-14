{
  if ( /,/ ) {
    n = split($0, bnums, /,/);
  } else if ( NF == 0 ) {
    board++;
    row = 0;
  } else {
    row++;
    for ( col = 1; col <= NF; col++ ) {
      if ( $col in bpos )
        bpos[$col] = bpos[$col]":"board","row","col;
      else
        bpos[$col] = board","row","col;
      sums[board] += $col
    }
    if ( r_max == "" || row > r_max )
      r_max = row;
    if ( c_max == "" || NF > c_max )
      c_max = NF;
  }
}
END {
  for ( idx = 1; idx <= n; idx++ ) {
    split(bpos[bnums[idx]], brc, /:/);
    for ( pos in brc ) {
      split(brc[pos], a, /,/);
      bc = a[1] SUBSEP a[3];
      br = a[1] SUBSEP a[2];
      bcurr = a[1];

      # Skip board that we have already won
      if ( bcurr in bwon && bwon[bcurr] >= 1 )
        continue;

      # Increment the board sum
      bsum[bcurr] += bnums[idx];

      # Row
      rsum[br]++;
      if ( rsum[br] == r_max ) {
        btype = "row";
        bwon[bcurr]++;
      }

      # Col
      csum[bc]++;
      if ( csum[bc] == c_max ) {
        btype = "col";
        bwon[bcurr]++;
      }

      # Exit when we have won our first board
      if ( length(bwon) == 1 )
        break;
    }

    # Exit when we have won our first board
    if ( length(bwon) == 1 )
      break;
  }

  print "First bingo (" btype ") for board #" bcurr " at round "\
    idx ": " bnums[idx];
  print "Answer: " (sums[a[1]] - bsum[a[1]]) * bnums[idx];
}
