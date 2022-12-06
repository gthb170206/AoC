{n=split($0,a,//);}END{for(l=4;l<=14;l+=10)for(i=1;i<=n-l+1;i++){for(o=0;o<l;o++)t[a[i+o]]++;if(length(t)==l){print "Answer",int(l/10) + 1":",i+l-1;break;}delete t;}}
