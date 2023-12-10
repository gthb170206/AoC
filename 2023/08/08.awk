{
  if ( NF == 1 ) {
    gsub(/L/, 1);
    gsub(/R/, 2);
    n = split($1, lr, //);
  } else if ( NF == 4 ) {
    gsub(/[()]/, "");
    sub(/, /, ",");
    node[$1] = $NF;
  }
}
END{
  pos = "AAA";
  idx = 1;
  while ( pos != "ZZZ" ) {
    split(node[pos], a, /,/);
    pos = a[lr[idx]];
    if ( idx == n )
      idx = 1;
    else
      idx++;
    steps++;
  }
  print "Answer: "steps;
}
