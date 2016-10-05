Write-Host "Num Files:" $args.Length;

if ($args.count[0]){
    foreach ($arg in $args)
    {
    Write-Host "File: $arg";
    Copy-Item -force $arg .\processing
    cd .\processing
    (Get-Content $arg).replace('.md', '.html') | Set-Content $arg
    gi $arg |foreach{pandoc --filter pandoc-citeproc $_.name -f markdown -c ..\Stylesheets\github-pandoc.css --self-contained -t html -s -o  "$($_.basename).html" --bibliography=..\bibliography\bibliography.bib --webtex  }
    cd ..
    Move-Item -force .\processing\*.html .\
    }
}
else{
    Copy-Item -force *.md .\processing
    cd .\processing
    gci -r -i *.md |foreach{(Get-Content $_).replace('.md', '.html') | Set-Content $_}
    gi *.md |foreach{pandoc --filter pandoc-citeproc $_.name -f markdown -c ..\Stylesheets\github-pandoc.css --self-contained -t html -s -o  "$($_.basename).html" --bibliography=..\bibliography\bibliography.bib --webtex  }
    cd ..
    Move-Item -force .\processing\*.html .\
}