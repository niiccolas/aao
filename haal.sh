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
  # Helper variables
  hr="—— 🤖 ——"
  hr_n="\n—— 🤖 ——\n"
  editor=""

  # Handle Invalid Arguments
  if [ $# -eq 0 ] # no arguments
  then
    echo "I must take a project URL as argument"
    return
  elif [[ $1 = "sing" ]] # talented haal
  then
    echo $hr
    echo "Daisy, Daisy,\ngive me your answer do."
    echo "I'm half crazy,\nall for the love of you.\n"
    echo "It won't be a stylish marriage,\nI can't afford a carriage."
    echo "But you'll look sweet,\nupon the seat,\nof a bicycle built for two."
    return
  elif [[ $1 != https://* ]] # crude URL validation
  then
    echo "I'm afraid I can't do that. Pass a valid URL"
    return
  fi

  # Download ZIP file from URL
  echo $hr"\nDownload project ZIP files"
  curl -O ${1}

  # Set unzip PATH acc. to optional 2nd argument
  if [ ! -z $2 ]
    then
      unzip=$(unzip master.zip -d $2)
    else
      unzip=$(unzip master.zip)
  fi

  # Delete zip file
  rm master.zip

  # Capture, enter & display unzip PATH
  unzip_path=$(echo $unzip | grep -m1 'creating:' |cut -d ' ' -f5-)
  cd $unzip_path
  echo $hr_n"Unzip & enter project local folder\n$(pwd)"

  # Install project gems
  echo $hr_n"Install Project gems"
  bundle install

  # Open current folder with local editor
  if which atom &> /dev/null
    then
    editor="Atom"
  elif which code &> /dev/null
    then
    editor="VSCode"
  elif which subl &> /dev/null
    then
    editor="Sublime"
  elif which vi &> /dev/null
    then
    editor="Vim"
  else
    echo "Sorry, I am afraid I cannot find a code editor"
  fi
  echo $hr_n"Open current directory with "$editor

  # haal parting tip
  echo $hr_n"Project set. You can now run your tests by typing:"
  echo "bundle exec rspec --color\n"
}
