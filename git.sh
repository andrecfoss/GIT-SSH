#!/bin/bash
set -e

# Check if Git is installed
if ! command -v git &> /dev/null; then
  sudo apt update && sudo apt install git -y
else
  echo "Git is already installed!"
fi

echo -e $(git --version) "\n"
sleep 1

# Check GitHub Credentials
if [ -z "$(git config --global user.name)" ] || [ -z "$(git config --global user.email)" ]; then
  read -p "Enter GitHub username: " username
  read -p "Enter GitHub e-mail address: " email
  git config --global user.name "$username"
  git config --global user-email "$email"
  echo "GitHub credentials set successfully!"
else
  echo "GitHub credentials already set!"
fi

echo -e $(git config --list) "\n"
sleep 1

# Check SSH Key
if [ ! -f ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -C "$email"
else
  echo "SSH Key already generated previously!"
  echo -e "To check the key: cat ~/.ssh/id_ed25519.pub\n"
fi

sleep 1

if [ -f ~/.ssh/id_ed25519.pub ]; then
  if ! grep -q "$(cat ~/.ssh/id_ed25519.pub)" ~/.ssh/authorized_keys; then
    cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
  else
    echo "SSH public key is already present in authorized_keys."
  fi
else
  echo "No public SSH key found to append."
fi

# sudo chmod +x ~/git.sh
