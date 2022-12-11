{
  if ( /^Monkey [0-9]:/ ) {
    gsub(/[a-zA-Z: ]/, "");
    idx = $0;
  } else if ( /Starting items: / ) {
    gsub(/[a-zA-Z: ]/, "");
    items[idx] = $0;
  } else if ( /Operation: / ) {
    sub(/^ *Operation: new = /, "");
    operation[idx] = $0;
  } else if ( /Test: / ) {
    test[idx] = $NF;
    if ( idx == 0 )
      div = test[idx];
    else
      div *= test[idx];
  } else if ( /^ *If true: / ) {
    action[idx] = $NF;
  } else if ( /^ *If false: / ) {
    action[idx] = action[idx] ":" $NF;
  }
}
END{
  for ( round = 1; round <= 10000; round++ ) {
    for ( idx = 0; idx < length(items); idx++ ) {
      n = split(items[idx], a, /,/);
      # Handle each item
      for ( i = 1; i <= n; i++ ) {
        inspected[idx]++;

        # Operation
        old = a[i];
        op = operation[idx];
        gsub(/old/, old, op);
        m = split(op, b, / /);
        if ( b[2] == "+" )
          new = b[1] + b[3];
        else if ( b[2] == "*" )
          new = b[1] * b[3];

        # Test => Action
        split(action[idx], t, /:/);
        if ( new % test[idx] == 0 )
          r = t[1];
        else
          r = t[2];

        # Throw item
        if ( items[r] == "" )
          items[r] = new % div;
        else
          items[r] = items[r] "," new % div;
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
