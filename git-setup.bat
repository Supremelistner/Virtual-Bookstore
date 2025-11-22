@echo off
echo Setting up Git repository for Virtual BookStore...

cd /d C:\Users\MANISH\Projects

echo Initializing Git repository...
git init

echo Adding all files...
git add .

echo Creating initial commit...
git commit -m "Initial commit: Virtual BookStore Microservices"

echo Adding remote repository...
echo Please create a new repository on GitHub first, then run:
echo git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
echo git branch -M main
echo git push -u origin main

pause