#!/bin/bash

# Update package list and install necessary system packages
echo "Updating package list..."
sudo apt update

echo "Cloning repo..."
git clone git@github.com:EmanuellQA/foundry-telliot-helper.git

if [ -d "~/foundry-telliot-helper" ]; then
  echo "Moving to foundry-telliot-helper folder..."
  cd ~/foundry-telliot-helper
else
  echo "Failed to clone repository or directory does not exist."
fi

echo "Installing Python 3.10 and venv..."
sudo apt install -y python3.10 python3.10-venv python3-pip curl

# Create and activate the virtual environment
echo "Creating virtual environment..."
python3.10 -m venv foundryVenv

# Upgrade pip inside the virtual environment
echo "Upgrading pip..."
pip install --upgrade pip

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

