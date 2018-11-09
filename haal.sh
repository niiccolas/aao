#!/bin/bash

# haal (1.0)
# Helper for App Academy onLine projects local setup
#
# USAGE
# haal [URL] [PATH (optional)]
#
# DESCRIPTION
# haal is a friendly bot than will help you set up App Academy Online
# projects on your local machine. Feed haal a project/exercise URL
# from the curriculum at https://www.aaonline.io/ and let him setup
# the boring stuff for you:
#
#   1. Download & unzip project in current directory or optional path
#   2. Delete downloaded zip file
#   3. Enter unzipped project folder
#   4. Install project gems
#   5. Open project folder with your code editor (Atom, VSCode, Sublime, Vim)
#
# AUTHOR
# niiccolas
#
# Nov. 2, 2018

haal() {
  # Handle Invalid Arguments
  if [[ $# -eq 0 ]] # no arguments
  then
    printf "🔴: Assign me a project URL please\n"
    exit
  elif [[ $1 = "sing" ]] # talented haal
  then
    # printf "%s\n" "$hr"
    printf "🔴: “Daisy, Daisy,\ngive me your answer do.\n"
    # printf "“Daisy, Daisy,\ngive me your answer do.\n"
    printf "I'm half crazy,\nall for the love of you.\n\n"
    printf "It won't be a stylish marriage,\nI can't afford a carriage.\n"
    printf "But you'll look sweet,\nupon the seat,\nof a bicycle built for two.”\n"
    exit
  elif [[ $1 != https://* ]] # crude URL validation
  then
    printf "🔴: I'm sorry, $(whoami). I'm afraid I can't do that\n"
    exit
  fi

  # Download distant ZIP file passed as argument...
  printf "🔴: Download project ZIP files\n"
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
  printf "🔴: Unzip & enter project local folder $(pwd)\n"
  # Install project gems
  printf "🔴: Install Project gems\n"
  bundle install

  # Open current folder with local editor
  if which atom &> /dev/null
    then
    editor="Atom"
    atom .
  elif which code &> /dev/null
    then
    editor="VSCode"
    code .
  elif which subl &> /dev/null
    then
    editor="Sublime"
    subl .
  elif which vi &> /dev/null
    then
    editor="Vim"
    vi .
  else
    printf "🔴: Sorry $(whoami), I am afraid I cannot find a code editor\n"
  fi

  printf "🔴: Open current directory with $editor\n"

  # haal parting tip
  printf "🔴: Project set. You can now run your tests by typing:\n"
  printf "bundle exec rspec --color\n\n"
}

haal $1 $2