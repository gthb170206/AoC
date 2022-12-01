function bin2dec(bin, _bin, _dec, _n) {
  _n = split(bin, _bin, //)
  for ( _i = 1; _i <= _n; _i++ )
    _dec += _bin[_i] * 2 ** ( _n - _i )
  return _dec
}

function enhance(arr, turn, _a, _dx, _dy, _n, _t, _x, _y) {
  for ( _y = min_y - 3; _y <= max_y + 3; _y++ ) {
    for ( _x = min_x - 3; _x <= max_x + 3; _x++ ) {
      _n = "";
      #printf("arr[%d,%d] = %d\n", _y, _x, arr[_y,_x]);
      for ( _dy = -1; _dy <= 1; _dy++ ) {
        for ( _dx = -1; _dx <= 1; _dx++ ) {
          _t = (_y + _dy) SUBSEP (_x + _dx)
          if ( _t in arr )
            _n = _n sprintf("%d", arr[_t])
          else if ( turn == 1 )
            _n = _n "0"
          else if ( turn % 2 == 0 && iea[0] )
            _n = _n iea[0]
          else
            _n = _n "0"
        }
      }
      _t = _y SUBSEP _x
      oarr[_t] = iea[bin2dec(_n)]
    }
  }
}
{
  if ( NR == 1 ) {
    # Convert the image enhancer data to binary
    gsub(/\./, "0");
    gsub(/\#/, "1");

    # Make an array
    n = split($0, iea, //);

    # Make the array zero indexed
    for ( i = 1; i <= n; i++ )
      iea[i - 1] = iea[i];

    # Delete the last element of the image enhancing array
    delete iea[n];
  } else if ( $0 == "" ) {
    # Determine the row diff (should be 2, but anyway...)
    dr = NR;
  } else {
    # Convert to binary
    gsub(/\./, "0");
    gsub(/\#/, "1");

    # Make an array
    n = split($0, a, //);
    y = NR - dr;

    # Add image data to a two dimensional array
    for ( x = 1; x <= n; x++ ) {
      img[y,x] = a[x];
    }

    # Set initial image boundaries
    min_x = 1;
    max_x = n;
    min_y = 1;
    max_y = y;
  }
}
END{
  # Loop and enhance the image
  for ( t = 1; t <= 50; t++ ) {
    enhance(img, t);
    delete img;
    for ( yx in oarr )
      img[yx] = oarr[yx];
    delete oarr;

    # Extend the image boundaries by one
    min_x--;
    max_x++;
    min_y--;
    max_y++;
  }

  # Count number of lit pixels
  sum = 0;
  for ( yx in img )
    sum += img[yx];

  print "Answer: " sum " (after " t - 1 " enhancement rounds)";
}
