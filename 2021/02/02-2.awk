/^forward/ { v+=$2; h+=a * $2 }
/^up/ { a-=$2; }
/^down/ { a+=$2; }
END{ print h * v; }
