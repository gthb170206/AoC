{
  split($0, fish, /,/);
  for ( i in fish )
    data[fish[i]]++;
}
END{
  days = 256;
  for ( i = 1; i <= days; i++ ) {
    sum = 0;
    for ( j = 0; j <= 8; j++ ) {
      sum += data[j];
      data[j-1] = data[j];
    }
    sum += data[-1];
    data[6] += data[-1];
    data[8] = data[-1];
    delete data[-1];
  }
  print "Number of fish: " sum " after " days " days";
}
