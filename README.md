# GIT - Basics

This repository contains all the GIT Basics.

### 1. Install GIT
```shell
sudo apt install git -y
```

### 2. Initial Configuration
```shell
git config --global user.name "user"
git config --global user.email "user@email.com"

git config --list
git config --list --show-origin
```
- [NOTE]- your GitHub Credentials need to match on the GIT Configuration you set.

### 3. Add an SSH Key onto your GitHub Account
```shell
ssh-keygen -t ed25519 -C "user@email.com"
Enter Passphrase: [SSH-KEY]

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

### 4. Adding a new Repository
```shell
git clone git@github.com:andrecfoss/GIT-Sample.git

echo "# GIT-Sample" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main

If it requires remote origin on a first time:
git remote add origin git@github.com:andrecfoss/GIT-Sample.git
git push -u origin main
```