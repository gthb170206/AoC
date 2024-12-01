function abs(v) {return v < 0 ? -v : v}
{
  sum += abs($1 - $2);
}
END{
  if ( sum < 0 )
    printf "%d\n", -sum;
  else
    printf "%d\n", sum;
}
