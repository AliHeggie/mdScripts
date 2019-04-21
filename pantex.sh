if [ $# -ne 0 ]
    then
    for var in "$@"
    do
        echo "$var"
        #copy $var md file to processing
        find . -maxdepth 1 -name $var -exec sh -c 'hercule "${0}" -o "./processing/${0}"' {} \;
        #change directory to processing
        cd processing
        #replace '.md' with  '.html' in all the filesz
        find . -name $var -exec sed -i "s/.md/.html/g" {} \;
        #padoc all the .md files using citeproc filters
        find . -name $var -exec sh -c 'pandoc "${0}" --filter pandoc-crossref --natbib -f markdown -o  "${0%.md}.tex"  --mathml' {} \;
        name=$(echo $var | cut -f 1 -d '.')
	sed -i 's/\\cite[t,p]{/\\cite{/g' $name.tex 
        #move pdf files back to main directory
        find . -name $name.tex -type f  -print0 | xargs -0 mv -t ".." 
        #change directory back to main
        cd ..
    done
fi

