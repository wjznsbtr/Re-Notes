@echo off
echo Starting Git Bash from "Notes"
start " "  "C:\Program Files\Git\git-bash.exe"

set REPO_PATH = C:\Users\wjzns\Desktop\Notes
cd %REPO_PATH%

echo Checking for updates...
git status

echo Committing changes...
git add .
set /p cmt = 请输入commit：
git commit -m "%cmt%"

echo Pushing to remote respository
git push origin main