function is_lower(str, _lower) {
  _lower = "abcdefghijklmnopqrstuvwxyz";

  return index(_lower, substr(str, 1, 1));
}

function is_upper(str, _upper) {
  _upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  index(_upper, substr(str, 1, 1));
}

function find_path(path, _path, _str) {
  pstr = pstr "," path;
  if ( is_lower(path) ) {
    used[path]++;
    if ( used[path] == 2 )
      lower_used_twice = path;
  }

  for ( _path in paths ) {
    if ( match(_path, "(^|-)start(-|$)") )
      continue;
    if ( match(_path, "(^|-)"path"(-|$)") ) {
      if ( RSTART == 1 )
        _path = substr(_path, RLENGTH + 1);
      else
        _path = substr(_path, 1, RSTART - 1);

      # Skip lower case paths that have already been used
      if ( _path in used && lower_used_twice != "" )
          continue;

      # Skip lower case dead end paths
      if ( path in used &&
           conns[_path] == 1 &&
           ( lower_used_twice != "" ||
           used[path] > 1 ) )
        continue;

      # End of path found
      if ( _path == "end" ) {
        pstrs[pstr ",end"]++;
        pcount++;
        continue;
      } else {
        find_path(_path);
      }
    }
  }

  # Remove entry from used
  if ( path in used ) {
    if ( used[path] == 2 ) {
      if ( lower_used_twice == path )
        lower_used_twice = "";
      used[path]--;
    } else
      delete used[path];
  }

  # Remove final part from path string
  sub(","path"$", "", pstr);
}
{
  paths[$0]++;
  split($0, a, /-/);
  conns[a[1]]++;
  conns[a[2]]++;
}
END{
  for ( path in paths ) {
    if ( match(path, "(^|-)start(-|$)") ) {
      delete used;
      used["start"]++
        if ( RSTART == 1 )
          path = substr(path, RLENGTH + 1);
        else
          path = substr(path, 1, RSTART - 1);
        pstr="start"
      find_path(path)
    }
  }
  i = 0;
  print "Answer: " pcount;
}