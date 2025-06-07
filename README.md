# Instructions to do HPC assignments & use GitHub

1. Use VSCode for ssh setup using SSH FS Kelvin.vscode-sshfs
2. Host: ```mlogin01.hrz.tu-freiberg.de```, Username: <YOUR_TUBAF_USERNAME>
3. IMPORTANT: Password: <prompt>, Keep Prompt field empty --> This triggers password entering every time you try to connect
4. In SSH FS extension, next to tubaf_hpc connection, click on the "folder-like" button to open workspace (of whole HPC Cluster)
5. Under ```/home/rn14pyry``` you can find all HPC codes. Manually navigate here. 

# Setup GitHub

Follow these commands:
1. init your git
```git init```
2. check status (ideally all files should be ready for adding)
```git status```
3. first commit
```git commit -m "adding all HPC assignment files form TUBAF cluster"```
4. check status again using ```git status```
5. Create a repo on your github profile. At top right of the newly created repo, get the link for the remote repo. Then link your local TUBAF repo. to the remote github repo. 
```git remote add origin https://github.com/<YOUR_GITHUB_USRNAME>/<YOUR_REPO_NAME>.git```
6. Push code to remote
```git push -u origin master```
7. Now you can check status again if needed. 
8. Optionally set up ```.gitignore``` to prohibit C++ executables from being tracked to GitHub. Ideally GitHub should be the place for your code only. 

# Compiling C++ scripts & trial runs on login node