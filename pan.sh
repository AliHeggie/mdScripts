if [ $# -ne 0 ]
  then

 	for var in "$@"
		do
		    echo "$var"
			#copy $var md file to processing
			find . -maxdepth 1 -name $var -exec sh -c 'hercule "${0}" -o "./processing/${0}"' {} \;

			#change directory to processing
			cd processing
			#replace '.md' with  '.html' in all the files so that any links work. Note, need to call pan.sh sperately for the linked files too
			find . -name $var -exec sed -i "s/.md/.html/g" {} \;

			#padoc all the .md files using citeproc filters
			find . -name $var -exec sh -c 'pandoc --self-contained --filter pandoc-citeproc "${0}" -f markdown -t html -s -o  "${0%.md}.html" --bibliography=../Bibliography/bibliography.bib --mathml' {} \;

			name=$(echo $var | cut -f 1 -d '.')

			#move html files back to main directory
			find . -name $name.html -type f  -print0 | xargs -0 mv -t ".." 

			#change directory back to main
			cd ..

		done
fi


if [ $# -eq 0 ]
  then
    echo "No arguments supplied"

#copy all *.md files to processing
find . -maxdepth 1 -name '*.md' -type f -not -path "./processing" -print0 | xargs -0 cp -t "./processing" 

#change directory to processing
cd processing
#replace '.md' with  '.html' in all the files so that any links work. Note, need to call pan.sh sperately for the linked files too
find . -name \*.md -exec sed -i "s/.md/.html/g" {} \;

#padoc all the .md files using citeproc filters
find . -name \*.md -exec sh -c 'pandoc --filter pandoc-citeproc "${0}" -f markdown -t html -s -o  "${0%.md}.html" --bibliography=../Bibliography/bibliography.bib --mathjax' {} \;

#move html files back to main directory
find . -name '*.html' -type f  -print0 | xargs -0 mv -t ".." 

#change directory back to main
cd ..

fi
