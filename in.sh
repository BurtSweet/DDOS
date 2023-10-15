#!/bin/bash
#安装必要的包
# Define commands to install
commands=("python3-venv" "python3-pip" "python3" "git" "libcurl4" "libssl-dev" "make" "automake" "autoconf" "m4" "build-essential")
package_manager=""
install_command=""

# Determine the package manager and install command
if [ -x "$(command -v apt)" ]; then
  package_manager="apt"
  install_command="sudo apt install -y"
elif [ -x "$(command -v yum)" ]; then
  package_manager="yum"
  install_command="sudo yum install -y"
else
  echo "Unsupported package manager."
  exit 1
fi

# Function to install missing commands
install_missing_commands() {
  for cmd in "${commands[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "Installing $cmd..."
      $install_command "$cmd"
      if [ $? -eq 0 ]; then
        echo "$cmd installed successfully."
      else
        echo "Failed to install $cmd."
        exit 1
      fi
    else
      echo "$cmd is already installed."
    fi
  done
}

# Check and install missing commands
install_missing_commands

# Clone the GitHub repository
git clone https://github.com/seagullz4/DDOS DDOS

# Create a Python virtual environment
if python3 -m venv love; then
  echo "Virtual environment created successfully."
else
  echo "Failed to create the virtual environment."
  exit 1
fi

# Activate the virtual environment
source love/bin/activate

# Change to the DDOS directory
cd DDOS

# Install Python requirements
if [[ "$VIRTUAL_ENV" != "" ]]; then
  pip3 install -r requirements.txt
else
  echo "Not in a virtual environment. Activate it first."
  exit 1
fi

# Deactivate the virtual environment
deactivate
