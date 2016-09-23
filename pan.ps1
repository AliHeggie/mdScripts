Copy-Item -force *.md .\processing

cd .\processing

gci -r -i *.md |foreach{(Get-Content $_).replace('.md', '.html') | Set-Content $_}

gi *.md |foreach{pandoc --filter pandoc-citeproc $_.name -f markdown -c ..\Stylesheets\github-pandoc.css --self-contained -t html -s -o  "$($_.basename).html" --bibliography=..\bibliography\bibliography.bib --webtex  }

cd ..

Move-Item -force .\processing\*.html .\
