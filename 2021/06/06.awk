{
  split($0, fish, /,/);
}
END{
  days = 80;
  for ( i = 1; i <= days; i++ ){
    stop = length(fish);
    for ( j = 1; j <= stop; j++ ) {
      if ( fish[j] == 0 ) {
        fish[j] = 6;
        fish[length(fish) + 1] = 8;
      } else
        fish[j]--;
    }
  }
  print "Number of fish: "length(fish)" after "days" days";
}