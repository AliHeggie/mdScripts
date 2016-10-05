Write-Host "Num Files:" $args.Length;

if ($args.count[0]){
    foreach ($arg in $args)
        {
            gi $arg |foreach{hercule $_ -o (Join-Path .\processing\ $_.name)}
            cd .\processing
            gci -r -i $arg |foreach{(Get-Content $_).replace('.md', '.html') | Set-Content $_}
            gi $arg |foreach{pandoc --filter pandoc-citeproc $_.name --filter ./tikz.py -f markdown -s -c ..\Stylesheets\github-pandoc.css --self-contained -t html -o  "$($_.basename).html" --bibliography=..\bibliography\bibliography.bib --webtex}
            cd ..
            Move-Item -force .\processing\*.html .\
        }
    }
else
    {
    gi *.md |foreach{hercule $_ -o (Join-Path .\processing\ $_.name)}
    cd .\processing
    gci -r -i *.md |foreach{(Get-Content $_).replace('.md', '.html') | Set-Content $_}
    gi *.md |foreach{pandoc --filter pandoc-citeproc $_.name --filter ./tikz.py -f markdown -s -c ..\Stylesheets\github-pandoc.css --self-contained -t html -o  "$($_.basename).html" --bibliography=..\bibliography\bibliography.bib --webtex}
    cd ..
    Move-Item -force .\processing\*.html .\
    }