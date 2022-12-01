# Get column index of string chr in string str
function index_of(str, chr, _arr, _i) {
  split(str, _arr);
  for ( _i = 1; _i <= length(_arr); _i++ )
    if ( _arr[_i] == chr )
      return _i;
  return 0;
}
#
# Convert the letter string to binary
function digit_to_binary(digit, _binstr, _i, _idx, _refarr, _refstr) {
  _refstr = "abcdefg";
  split(_refstr, _refarr, //);
  _binstr = "";
  for ( _i = 1; _i <= length(_refarr); _i++ ) {
    _idx = index(digit, _refarr[_i]);
    if ( _idx == 0 )
      _binstr = _binstr "0";
    else
      _binstr = _binstr "1";
  }
  return _binstr;
}
#
# Sort string alphabetically
function sort_string(str, _binarr, _binstr, _i, _refstr, _refarr, _sstr) {
  _refstr = "abcdefg";
  split(_refstr, _refarr, //);
  _binstr = digit_to_binary(str);
  split(_binstr, _binarr, //);
  _sstr = "";
  for ( _i = 1; _i <= length(_binarr); _i++ )
    if ( _binarr[_i] == 1 )
      _sstr = _sstr _refarr[_i];
  return _sstr;
}
#
# Sum of the elements of the binary string
function sum_binstring(str, _arr, _i, _sum) {
  split(str, _arr, //);
  _sum = 0;
  for ( _i = 1; _i <= length(_arr); _i++ )
    _sum += _arr[_i];
  return _sum;
}
#
# Return the sums of the columns of the array values
function col_sums(arr, _a, _i, _key) {
  for ( _key in arr ) {
    split(arr[_key], _a, //);
    for ( _i = 1; _i <= length(_a); _i++ )
      colsums[_i] += _a[_i]
  }
}
#
# Perform binary and on the strings and return the result string
function bin_and(str1, str2, _i, _rstr) {
  for ( _i = 1; _i <= length(str1); _i++ )
    _rstr = _rstr substr(str1, _i, 1) * substr(str2, _i, 1);
  return _rstr;
}
#
# Perform binary or on the strings and return the result string
function bin_or(str1, str2, _i, _rstr) {
  for ( _i = 1; _i <= length(str1); _i++ )
    if ( substr(str1, _i, 1) == 1 ||
         substr(str2, _i, 1) == 1 )
      _rstr = _rstr "1";
    else
      _rstr = _rstr "0";
  return _rstr;
}#
# Perform binary xor on the strings and return the result string
function bin_xor(str1, str2, _i, _rstr) {
  for ( _i = 1; _i <= length(str1); _i++ )
    if ( substr(str1, _i, 1) != substr(str2, _i, 1) )
      _rstr = _rstr "1";
    else
      _rstr = _rstr "0";
  return _rstr;
}
BEGIN{
  dig[2] = 1;
  dig[3] = 7;
  dig[4] = 4;
  dig[7] = 8;
}
{
  delete binarr;
  delete key;
  delete rkey;

  pipe_idx = index_of($0, "|");

  # Process the first elements of the line (before the pipe)
  for ( i = 1; i < pipe_idx; i++ ) {
    # Normalize
    str = sort_string($i);

    # Convert to binary
    if ( str in binarr )
      ;
    else
      binarr[str] = digit_to_binary(str);
    binstr = binarr[str];

    # Check if we have a hit in the dig array
    ecnt = sum_binstring(binstr);
    if ( ecnt in dig ) {
      key[str] = dig[ecnt];
      rkey[dig[ecnt]] = str;
    }
  }

  # Find 2 (has an inactive element that is active in all other digits)
  delete colsums
  col_sums(binarr);
  for ( i = 1; i <= length(colsums); i++ ) {
    if ( colsums[i] == 9 ) {
      for ( str in binarr )
        if ( substr(binarr[str], i, 1) == 0 ) {
          key[str] = 2;
          rkey[2] = str;
          break;
        }
      break;
    }
  }

  # Find 5 (not in key, length 5 and only 1 active element in common with 1)
  for ( str in binarr ) {
    if ( str in key )
      continue;
    if ( length(str) == 5 &&
         sum_binstring(bin_and(binarr[str], binarr[rkey[1]])) == 1 ) {
      key[str] = 5;
      rkey[5] = str;
      break;
    }
  }

  # Find 3 (not in key and length 5)
  for ( str in binarr ) {
    if ( str in key )
      continue;
    if ( length(str) == 5 ) {
      key[str] = 3;
      rkey[3] = str;
      break;
    }
  }

  # Find 6 (length 6 and only 1 active elements in common with 1)
  for ( str in binarr ) {
    if ( length(str) == 6 &&
         sum_binstring(bin_and(binarr[str], binarr[rkey[1]])) == 1 ) {
      key[str] = 6;
      rkey[6] = str;
      break;
    }
  }

  # Find 9 (not in key, length 6 and 1 element not in common with 5)
  for ( str in binarr ) {
    if ( str in key )
      continue;
    if ( length(str) == 6 &&
         sum_binstring(bin_xor(binarr[str], binarr[rkey[5]])) == 1 ) {
      key[str] = 9;
      rkey[9] = str;
      break;
    }
  }

  # Find 0 (not in key and length 6)
  for ( str in binarr ) {
    if ( str in key )
      continue;
    if ( length(str) == 6 ) {
      key[str] = 0;
      rkey[0] = str;
      break;
    }
  }

  # Process the elements after the pipe
  row_output = "";
  for ( i = pipe_idx + 1; i <= NF; i++ )
    row_output = row_output key[sort_string($i)];

  # Add the row output to the sum
  sum += row_output;
}
END{
  print "Answer: " sum;
}
