n() {
	if [[ $* =~ .*\.md ]]
	then $EDITOR ~/Dropbox/Notes/"$*"
	else $EDITOR ~/Dropbox/Notes/"$*".md
	fi
}

#lists files in Notes containing a pattern in filename ignoring .html files
nls() {
        ls -c ~/Dropbox/Notes/ -I *.html | grep "$*" -i
}

nrm() {
       	if [[ $* =~ .*\.md ]]
	then rm ~/Dropbox/Notes/"$*"
	else rm ~/Dropbox/Notes/"$*".md
	fi
}


#Search using grep. Exludes files containing %old tag. Excluding html files
# Use \| and .* for OR and AND 
ngr() {
        grep -v -i -l \%old ~/Dropbox/Notes/* 2>/dev/null | grep  -l -i --exclude='*.html' -E "$*" ~/Dropbox/Notes/*  2>/dev/null 
}

#Find all unique % tags
nt () {
    grep -o -h  --exclude='*.html' '%[a-zA-Z][a-zA-Z]*' Dropbox/Notes/* 2>/dev/null | sort | uniq
}
