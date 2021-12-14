function find_path(path, _path, _str) {
  pstr = pstr "," path;
  for ( _path in paths ) {
    if ( match(_path, "(^|-)start(-|$)") )
      continue;
    if ( match(_path, "(^|-)"path"(-|$)") ) {
      if ( RSTART == 1 )
        _path = substr(_path, RLENGTH + 1);
      else
        _path = substr(_path, 1, RSTART - 1);

      # Skip lower case paths that have already been used
      if ( _path in used && used[_path] >= 1 &&
           index(upper, substr(_path, 1, 1)) == 0 ) {
        continue;
      }

      # Skip dead end paths
      if ( conns[_path] == 1 &&
           index(upper, substr(path, 1, 1)) == 0 ) {
        continue;
      }

      # End of path found
      if ( _path == "end" ) {
        pstrs[pstr ",end"]++;
        pcount++;
        continue;
      } else {
        used[path]++
        find_path(_path)
      }
      used[path]--;
    }
  }
  sub(","path"$", "", pstr);
}
BEGIN{
  upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
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
  print "Answer: " pcount;
}