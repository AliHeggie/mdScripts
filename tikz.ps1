#copy all *.md files to processing
Copy-Item -force *.md .\processing
#change directory to processing
cd .\processing
#replace '.md' with  '.html' in all the files
gci -r -i *.md |foreach{(Get-Content $_).replace('.md', '.html') | Set-Content $_}

#padoc all the .md files using citeproc and tikz filters
#gi *.md |foreach{pandoc --filter pandoc-citeproc $_.name -f markdown -c ..\Stylesheets\github-pandoc.css --self-contained -t html -s -o  "$($_.basename).html" --bibliography=..\bibliography\bibliography.bib --mathjax}

gi *.md |foreach{pandoc --filter pandoc-citeproc --filter tikz.py $_.name -f markdown -c ..\Stylesheets\github-pandoc.css --self-contained -t html -s -o  "$($_.basename).html" --bibliography=..\bibliography\bibliography.bib --mathjax}

cd ..

Move-Item -force .\processing\*.html .\
