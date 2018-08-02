#!/bin/bash 

_version=$(aws --version 2>&1 |awk -F"/" '{print $2}'|awk -F" " '{print $1}')

major=1
minor=15
maintenance=66

IFS='.' read -a arr <<< "$_version"

display_arr() 
{
    for i in ${arr[@]}; do echo $i; done
}

errecho(){ >&2 echo $@; }

if [[ "${arr[0]}" -ge "${major}" ]]; then
    
   if [[ "${arr[1]}" -ge "${minor}" ]]; then 

      if [[ "${arr[2]}" -ge "${maintenance}" ]]; then
         echo "passed"
      else
         errecho "maintenance is below ${maintenance}"
         exit 1
      fi 
   
   else
      errecho "minor release is below ${minor}"
      exit 1
   fi

else
  errecho "major relase is below required release of ${major}"
  exit 1
fi

