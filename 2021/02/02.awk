/^f/ { v += $2; }
/^u/ { h -= $2; }
/^d/ { h += $2; }
END{
  print "Answer: " h * v;
}
