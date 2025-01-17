#!/usr/bin/env bash
set -e

# Function to check if Git is installed
check_git() {
  if ! command -v git &> /dev/null; then
    sudo apt update && sudo apt install git -y
  else
    echo "Git is already installed!"
  fi
}

# Function to check GitHub credentials
check_github_credentials() {
  if [ -z "$(git config --global user.name)" ] || [ -z "$(git config --global user.email)" ]; then
    read -r -p "Enter GitHub username: " username
    read -r -p "Enter GitHub e-mail address: " email
    git config --global user.name "$username"
    git config --global user.email "$email"
    echo "GitHub credentials set successfully!"
  else
    echo "GitHub credentials already set!"
  fi
}

# Function to check SSH key
check_ssh_key() {
  if [ ! -f ~/.ssh/id_ed25519 ]; then
    if [ -z "$email" ]; then
      read -r -p "Enter your email for SSH key: " email
    fi
    ssh-keygen -t ed25519 -C "$email"
  else
    echo "SSH key already exists!"
  fi
}

# Main script execution
check_git
echo -e "$(git --version)\n"
sleep 1

check_github_credentials
echo -e "$(git config --list)"
sleep 1

check_ssh_key

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
