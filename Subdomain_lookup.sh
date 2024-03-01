#!/bin/bash

bold_txt=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
reset=$(tput sgr0)

tools=("assetfinder" "httprobe")

end(){	 
	 echo "$yellow ============================ $reset"
	 echo "$red $bold_txt *** Subdomain Enumeration *** $reset Completed $green $bold_txt THANK YOU <3$reset"
	 }
	 
sts(){	 
	 echo "$yellow- - - - - - - - - - - - - - - - - -  $reset"
	 echo "$blue Live Subdomains of $domain_Name $reset"
	 echo "$yellow- - - - - - - - - - - - - - - - - -  $reset"
	}
	 
waits(){
		echo "$purple \/\/ Just wait and see \/\/ $reset"
}	 

echo "$yellow ******************************************* $reset"

echo "$bold_txt Hello$blue $USER $reset WELCOME TO $red $bold_txt SUBDOMAIN-LOOKUP$reset"

echo "$yellow ******************************************* $reset"

for tool in "${tools[@]}"; do
	if ! which "$tool" >/dev/null 2>&1; then
		echo "$red $tool  is not installed$reset"
		read -p "Do you want to install $red $tool$reset ? (y/n):" choice
		if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
			sudo apt install $tool
			echo "$green $tool installed successfully!$reset"
	else 
		echo "Skipping installation of $red$tool$reset"
		exit 0
	fi
		
	else 
		echo "$green $tool  is installed$reset"
		
	fi	
			
done
	

echo "$green $bold_txt Good to Go  $reset"
	

read -p "$blue Enter the domain to lookup:$reset " domain_Name
	
	
read -p "save to $red $PWD $reset ?(y/n)" Path_Choice
waits	
if [ "$Path_Choice" = "y" ] || [ "$Path_Choice" = "Y" ]; then
	assetfinder -subs-only $domain_Name | httprobe | sort -u > Subdomains_list.txt

sts
	 cat Subdomains_list.txt
	 
	 echo "$yellow- - - - - - - - - - - - - - - $reset"
	 echo " File saved in $blue Subdomains_list.txt$reset"
	 
  
end
else 
	 read -p "Specify the path to save the file :  " File_Path
	 if [ ! -d "$File_Path" ]; then
	 	echo "$red Error: No such file or directory$reset"
	 	exit 1
	 else
waits
	 assetfinder -subs-only $domain_Name | httprobe | sort -u > $File_Path/Subdomains_list.txt
	 
sts
	 cat $File_Path/Subdomains_list.txt
	 echo "File Saved in $blue $File_Path/Subdomains_list.txt$reset"
end
	fi
fi
