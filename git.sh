#!/bin/sh

echo "# TTInputPanel" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin "https://github.com/simpossible/TTInputPanel.git"
git push -u origin master