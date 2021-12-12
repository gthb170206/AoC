function index_of(str, chr) {
  n = split(str, arr);
  for ( i = 1; i <= n; i++ )
    if ( arr[i] == chr )
      return i;
  return 0;
}
BEGIN{
  dig[2] = 1;
  dig[3] = 7;
  dig[4] = 4;
  dig[7] = 8;
}
{
  pipe_idx = index_of($0, "|");
  for ( i = pipe_idx + 1; i <= NF; i++ )
    cnt[length($i)]++;
}
END{
  for ( i in cnt ) {
    if ( i in dig )
      sum += cnt[i];
  }
  print "Answer: " sum;
}
