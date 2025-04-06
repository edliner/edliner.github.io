rm -rf index.md web
mkdir web
for file in *.md; do
    date=$(echo "$file" | cut -d- -f1-3)
    path=$(echo "$file" | cut -d- -f4- | cut -d. -f1)
    title=$(head -1 "$file" | cut -d" " -f2-)
    echo $date
    echo $path
    mkdir "web/$path"
    set -x; pandoc "$file" --template "template.html" -V "ispost=ispost" -V "title=$title" -V "date=$date" -o "web/$path/index.html"; set +x
    echo "$date - <a href=\"$path/\">$title</a>" >> index.md
done
set -x; pandoc "index.md" --template "template.html" -V "title=Ed's Blog" -o "web/index.html"; set +x
rm -f index.md
