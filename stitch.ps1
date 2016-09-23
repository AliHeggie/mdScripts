gi *.md |foreach{hercule $_ -o (Join-Path .\processing\ $_.name)}

cd .\processing

gci -r -i *.md |foreach{(Get-Content $_).replace('.md', '.html') | Set-Content $_}

gi *.md |foreach{pandoc --filter pandoc-citeproc $_.name -f markdown -s -c ..\Stylesheets\github-pandoc.css --self-contained -t html -o  "$($_.basename).html" --bibliography=..\bibliography\bibliography.bib}

cd ..

Move-Item -force .\processing\*.html .\
