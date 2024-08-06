#!/bin/bash

# Check if the directory already exists
if [ -d "$HOME/foundry-telliot-helper" ]; then
  echo "The folder 'foundry-telliot-helper' already exists. Please remove or rename it."
  exit 1
fi

echo 
echo "This script will install Python, Foundry and may mess with your dev env."
echo "If installing in your main machine, please read the install.sh before continuing!"
echo
echo "Choose the environment to clone and install:"
echo "1 - main"
echo "2 - dev"
read -p "Enter 1-main or 2-dev: " environment_choice

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
echo

# Clone the repository with the selected branch
echo "Cloning repo..."
git clone -b "$branch" git@github.com:EmanuellQA/foundry-telliot-helper.git

if [ $? -eq 0 ]; then
  echo "Repository cloned successfully."
else
  echo "Failed to clone repository."
  exit 1
fi

echo
echo "Moving to foundry-telliot-helper folder..."
cd "$HOME/foundry-telliot-helper"

echo
echo "Installing Python 3.10 and venv..."
sudo apt install -y python3.10 python3.10-venv python3-pip curl

# Create and activate the virtual environment
echo
echo "Creating and entering virtual environment..."
python3.10 -m venv foundryVenv
source foundryVenv/bin/activate

# Upgrade pip inside the virtual environment
echo
echo "Upgrading pip..."
pip install --upgrade pip

# Install the `python-dotenv` module
echo
echo "Installing python-dotenv..."
pip install python-dotenv

# Install Python dependencies
echo
echo "Installing Python dependencies..."
pip install -r requirements.txt

# Install Foundry
echo
echo "Installing Foundry..."
curl -L https://foundry.paradigm.xyz | bash

# Add Foundry to PATH
echo "Adding Foundry to PATH..."
echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.bashrc
source "$HOME/.bashrc"
echo
echo "Running foundryup to install Foundry..."
foundryup

echo
echo "Installation complete!"
echo
echo -e "Run 'cd ~/foundry-telliot-helper' to get in the folder\n Then run 'source foundryVenv/bin/activate' to activate python venv\n Don't forget to copy and edit the '.env.example' file!\n\n To run the tool: 'python3 main.py'"
