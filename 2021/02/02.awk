/^forward/ { v += $2; }
/^up/      { h -= $2; }
/^down/    { h += $2; }
END{ print h * v; }
