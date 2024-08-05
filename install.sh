#!/bin/bash

# Check if the directory already exists
if [ -d "$HOME/foundry-telliot-helper" ]; then
  echo "The folder 'foundry-telliot-helper' already exists. Please remove or rename it."
  exit 1
fi

# Prompt the user for the environment to clone
echo "Choose an option"
read -p "type dev or main:" branch

# Clone the repository with the selected branch
echo "Cloning repo..."
git clone -b "$branch" git@github.com:EmanuellQA/foundry-telliot-helper.git

if [ $? -eq 0 ]; then
  echo "Repository cloned successfully."
else
  echo "Failed to clone repository."
  exit 1
fi

echo "Updating package list..."
sudo apt update

echo "Installing Python 3.10 and venv..."
sudo apt install -y python3.10 python3.10-venv python3-pip curl

# Create and activate the virtual environment
echo "Creating virtual environment..."
python3.10 -m venv foundryVenv

# Upgrade pip inside the virtual environment
echo "Upgrading pip..."
source foundryVenv/bin/activate
pip install --upgrade pip

# Install the `python-dotenv` module
echo "Installing python-dotenv..."
pip install python-dotenv

# Install Python dependencies
echo "Installing Python dependencies..."
pip install -r requirements.txt

# Install Foundry
echo "Installing Foundry..."
curl -L https://foundry.paradigm.xyz | bash

# Optional: Add Foundry to PATH
echo "Adding Foundry to PATH..."
# Assuming you are using a bash shell
echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

echo "Installation complete! Remember to activate your virtual environment with:"
echo "source foundryVenv/bin/activate"

