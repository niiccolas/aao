#!/bin/bash

haal() {
  # Input validation
  if [[ $# -eq 0 ]] # no arguments
  then
    printf "🤖 Assign me a project URL please\n"
    exit
  elif [[ $1 = "zip" ]] # ZIP
  then
    read -p "Are you in the project folder? (y/n) " answer
    case "$answer" in
      "y"|"YES")
        read -p "Please type your name:         " name
        read -p "Please type your lastname:     " lastname
        read -p "Please type the project name:  " section
        printf "🚀 creating "$name"_"$lastname"_"$section".zip in the parent folder...\n"

        filename="../"$name"_"$lastname"_"$section""
        zip -r $filename .
        printf "🤖 Done\n"
      ;;
      "n"|"NO")
        printf "Navigate to the project folder first\n"
      ;;
      *)
        printf "Wrong input, start again\n"
      ;;
    esac
    exit
  elif [[ $1 = "sing" ]] # talented haal
  then
    printf "🤖 “Daisy, Daisy,\ngive me your answer do.\n"
    printf "I'm half crazy,\nall for the love of you.\n\n"
    printf "It won't be a stylish marriage,\nI can't afford a carriage.\n"
    printf "But you'll look sweet,\nupon the seat,\nof a bicycle built for two.”\n"
    exit
  fi

  # Clear screen before haal sets up a new project
  clear
  # Download distant ZIP file passed as argument...
  printf "🤖 Download project ZIP files\n"
  # ...rename with random temporary name
  curl -o ./haal_zip_tmp_RSrtZMZ59.zip ${1}

  # Set unzip PATH acc. to optional 2nd argument
  if [ ! -z $2 ]
    then
      unzip=$(unzip haal_zip_tmp_RSrtZMZ59.zip -d $2)
    else
      unzip=$(unzip haal_zip_tmp_RSrtZMZ59.zip)
  fi

  # Delete zip file
  rm haal_zip_tmp_RSrtZMZ59.zip

  # Capture, enter & display unzip PATH
  unzip_path=$(printf "%s" "$unzip" | grep -m1 'creating:' |cut -d ' ' -f5-)
  cd $unzip_path
  printf "🤖 Unzip & enter project local folder $(pwd)\n"
  # Install project gems
  printf "🤖 Install Project gems\n"
  bundle install

  # Open current folder with local editor
  if which atom &> /dev/null
    then
    editor="Atom"
    atom ..
  elif which code &> /dev/null
    then
    editor="VSCode"
    code ..
  elif which subl &> /dev/null
    then
    editor="Sublime"
    subl ..
  elif which vi &> /dev/null
    then
    editor="Vim"
    vi ..
  else
    printf "🤖 Sorry $(whoami), I am afraid I cannot find a code editor\n"
  fi

  printf "🚀 Open current directory with $editor\n"

  # haal parting tip
  printf "🤖 Done. You can now run your tests by typing:\n"
  printf "bundle exec rspec --color\n\n"
}

haal $1 $2