#!/bin/bash

# Check if the directory already exists
if [ -d "$HOME/foundry-telliot-helper" ]; then
  echo "The folder 'foundry-telliot-helper' already exists. Please remove or rename it."
  exit 1
fi

echo "Choose the environment to clone:"
echo "1 - main"
echo "2 - dev"
read -p "Enter 1 for main or 2 for dev: " environment_choice

echo "You entered: $environment_choice"

case $environment_choice in
  1)
    branch="main"
    ;;
  2)
    branch="dev"
    ;;
  *)
    echo "Invalid choice. Please enter 1 for main or 2 for dev."
    exit 1
    ;;
esac

echo "Cloning branch: $branch"

# Clone the repository with the selected branch
echo "Cloning repo..."
git clone -b "$branch" git@github.com:EmanuellQA/foundry-telliot-helper.git

if [ $? -eq 0 ]; then
  echo "Repository cloned successfully."
else
  echo "Failed to clone repository."
  exit 1
fi

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

