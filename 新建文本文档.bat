@echo off
echo Starting Git Bash from "Notes"
start " "  "C:\Program Files\Git\git-bash.exe"

echo Checking for updates...
git status

echo Committing changes...
git add .
set d=%date:~0,10%
set t=%time:~0,8%
git commit -m "%d% %t%"

echo Pushing to remote respository
git push origin main