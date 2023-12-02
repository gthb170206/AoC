{
  gsub(/[a-z]/, "")
  n = split($0, a, //);
  sum += 10 * a[1] + a[n];
}
END {
  print "Answer: "sum;
}
