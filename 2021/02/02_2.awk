/^f/ { v += $2; h += a * $2; }
/^u/ { a -= $2; }
/^d/ { a += $2; }
END{ print h" * "v" = "h * v; }
