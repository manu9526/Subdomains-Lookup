#!/bin/bash

bold_txt=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
reset=$(tput sgr0)
tools=("assetfinder" "httprobe")

echo "$yellow - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  $reset"

echo "$bold_txt Hello$blue $USER $reset WELCOME TO $red $bold_txt SUBDOMAIN-LOOKUP$reset"

echo "$yellow - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - $reset"
echo "
for tool in "${tools[@]}"; do
	if ! which "$tool" >/dev/null 2>&1; then
		echo "$red $tool $reset is not installed"
		read -p "Do you want to install $tool? (y/n): " choice
		if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
		sudo apt install $tool
	else 
		echo "Skipping installation of $tool"
		exit 0
		fi
		
		else 
		echo "$tool is installed"
		fi	
	done

	read -p "Enter the domain name to lookup: " domain_Name
	echo "You entered : $domain_Name"
	
	read -p "save to $PWD ?(y/n)" Path_Choice
	if [ "$Path_Choice" = "y" ] || [ "$Path_Choice" = "Y" ]; then
	
	 assetfinder -subs-only $domain_Name | httprobe | sort -u > Subdomains_list.txt
	 cat Subdomains_list.txt
	 echo "File saved in Subdomains_list.txt"
	 
	 else 
	 	read -p "Specify the path to save the file :  " File_Path
	 	
	 	assetfinder -subs-only $domain_Name | httprobe | sort -u > $File_Path/Subdomains_list.txt
	 	cat $File_Path/Subdomains_list.txt
	 	echo "File Saved in $File_Path/Subdomains_list.txt"
	 	fi
	 
	 	
