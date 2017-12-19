if [ $# -ne 0 ]
  then

 	for var in "$@"
		do
		    echo "$var"
		    #Stitch files together with hercule and copy to processing
			find . -maxdepth 1 -name $var -exec sh -c 'hercule "${0}" -o "./processing/${0}"' {} \;

			cd processing

			#replace '.md' with  '.html' in all the files
			find . -name $var -exec sed -i "s/.md/.html/g" {} \;

			#padoc all the .md files using citeproc and tikz filters
			find . -name $var -exec sh -c 'pandoc --filter pandoc-citeproc --filter tikz.py "${0}" -f markdown -t html -s -o  "${0%.md}.html" --bibliography=../Bibliography/bibliography.bib --mathjax' {} \;
			
			name=$(echo $var | cut -f 1 -d '.')

			#move html files back to main directory
			find . -name $name.html -type f  -print0 | xargs -0 mv -t ".." 
			rsync  --remove-source-files "tikz-images" "../tikz-images"

			#change directory back to main
			cd ..



		done
fi

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"


	#Stitch files together with hercule and copy to processing
	find . -maxdepth 1 -name '*.md' -exec sh -c 'hercule "${0}" -o "./processing/${0}"' {} \;

	cd processing

	#replace '.md' with  '.html' in all the files
	find . -name \*.md -exec sed -i "s/.md/.html/g" {} \;

	#padoc all the .md files using citeproc and tikz filters
	find . -name \*.md -exec sh -c 'pandoc --filter pandoc-citeproc --filter tikz.py "${0}" -f markdown -t html -s -o  "${0%.md}.html" --bibliography=../Bibliography/bibliography.bib --mathjax' {} \;

	#move html files back to main directory
	find . -name '*.html' -type f  -print0 | xargs -0 mv -t ".." 
	rm -r "../tikz-images"
	mv "tikz-images" ".." 

	#change directory back to main
	cd ..

fi