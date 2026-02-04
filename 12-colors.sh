#!/bin/bash

echo -e "\e[31mhello colors\e[0m"

echo "hello no colors"





# ✅ Correct ways to reset your terminal color
# ✔️ Option 1 (best & simple)
# echo -e "\e[0m"

# ✔️ Option 2 (most reliable)
# reset

# ✔️ Option 3 (using printf – preferred in scripts)
# printf "\e[0m"


# 💡 Best practice going forward

# When using colors:

# echo -e "\e[32mSUCCESS\e[0m"


# or (better):

# printf "\e[32mSUCCESS\e[0m\n"

# Pro tip (for scripts)

# Define color variables once:

# GREEN="\e[32m"
# RED="\e[31m"
# RESET="\e[0m"

# echo -e "${GREEN}Installed successfully${RESET}"

#-e allows echo to interpret special characters and colors