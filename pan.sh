#copy all *.md files to processing
find . -maxdepth 1 -name '*.md' -type f -not -path "./processing" -print0 | xargs -0 cp -t "./processing" 

#change directory to processing
cd processing
#replace '.md' with  '.html' in all the filesz
find . -name \*.md -exec sed -i "s/.md/.html/g" {} \;

#padoc all the .md files using citeproc filters
find . -name \*.md -exec sh -c 'pandoc --filter pandoc-citeproc "${0}" -f markdown -t html -s -o  "${0%.md}.html" --bibliography=../Bibliography/bibliography.bib --mathjax' {} \;

#move html files back to main directory
find . -name '*.html' -type f  -print0 | xargs -0 mv -t ".." 

#change directory back to main
cd ..