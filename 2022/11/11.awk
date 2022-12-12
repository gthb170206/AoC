{
  if ( match($0, /^Monkey /) >= 1 )
    idx = substr($0, RSTART + RLENGTH, index($0, ":") - RSTART - RLENGTH);
  else if ( match($0, /^ +Starting items: /) >= 1 )
    items[idx] = substr($0, RSTART + RLENGTH);
  else if ( match($0, /^ +Operation: new = /) >= 1 )
    operation[idx] = substr($0, RSTART + RLENGTH);
  else if ( /^ +Test: / )
    test[idx] = $NF;
  else if ( /^ +If true: / )
    action[idx] = $NF;
  else if ( /^ +If false: / )
    action[idx] = action[idx] ":" $NF
}
END{
  for ( round = 1; round <= 20; round++ ) {
    for ( idx = 0; idx < length(items); idx++ ) {
      n = split(items[idx], a, /, /);
      # Handle each item
      for ( i = 1; i <= n; i++ ) {
        inspected[idx]++;
        old = a[i];

        # Operation
        op = operation[idx];
        gsub(/old/, old, op);
        m = split(op, b, / /);
        if ( b[2] == "+" )
          new = b[1] + b[3];
        else if ( b[2] == "*" )
          new = b[1] * b[3];
        new = int(new / 3);

        # Test => Action
        split(action[idx], t, /:/);
        if ( new % test[idx] == 0 )
          r = t[1];
        else
          r = t[2];

        # Throw item
        if ( items[r] == "" )
          items[r] = new;
        else
          items[r] = items[r] ", " new;
      }

      # Empty list
      items[idx] = "";
    }
  }

  # Get the two most active monkeys
  for ( idx = 0; idx < length(inspected); idx++ ) {
    if ( inspected[idx] >= f ) {
      s = f;
      f = inspected[idx];
    } else if ( inspected[idx] > s )
      s = inspected[idx];
  }
  print "Answer: " f * s;
}
