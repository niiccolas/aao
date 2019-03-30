# Development Environment

## The Text Editor
First, we have to write code somewhere. For this, we will use a text editor. Here at App Academy, we will use Atom, an open source editor developed by GitHub. At first glance, it resembles a word processor like Microsoft Word. If we peer into its functionality, though, we'll see a lot of differences.

Microsoft Word is designed to compose, edit, format, and print documents. Therefore, it includes an abundance of features for text formatting (color, size, font), paragraph formatting (bullet points, double spaces, etc.), printing options and settings, and even ways to track changes and suggestions.

Similarly, text editors are designed for working with plain text, text without formatting. The plain text we are writing will eventually be run as code, so we will take advantage of one of the many text editors that are specifically designed to write code. They include features like language-specific keyword highlighting, shortcuts to quickly change code or move the cursor position, syntax error linting to warn you about problems before you even run the code, and some even have live coding shells. Each text editor comes with a different suite of features, though most will have significant overlap to cover the basics. We'll introduce you to some common keyboard shortcuts for Atom in a future section.

## The Terminal
Finder is a Mac Program that allows users to interact with the computer’s filesystem. Finder employs a graphical user interface (GUI), which allows the user to tell the application what to do based on mouse clicks and movements.

Terminal is another application that allows the user to interact with the computer’s filesystem (and more!). Unlike Finder, however, the terminal provides a text-based interface, commonly referred to as the command line interface (CLI). Simply put, Terminal allows us to write text that will make our computer do stuff. We can do things such as open a file, rename a folder (also known as a directory) move a file to another directory, run some code, or even search the contents of every file on our computer. Soon you will know how to do all of these.

The text we will write in the CLI is determined by the language the terminal interpreter uses. There are a number of different languages available, but at App Academy we will use the default language for most Unix-based operating systems: Bash.

With practice, most common actions can be performed much more quickly in Terminal compared to using Finder’s GUI. For this reason, learning how to use Terminal well will be critical to your success at App Academy and as a software engineer.

## Language Environment
Languages are just software themselves. As such, they are continuously being improved and new features are added to the language. Some of these changes can dramatically affect or even break the functionality of code written in a previous version. In this course, we will use the rbenv package to manage our Ruby versions.

<br />


# Ruby Environment Setup

## Setting up a Development Environment
Being a developer isn't just about hacking away into the wee hours of the morning or debugging a new feature. In order to become a well-rounded developer we should also understand what tools we need and a minimum understanding of how they work. This includes setting up our computers for development.

Here at App Academy we work with a Ruby on Rails, JavaScript, React, Redux, and PostgresSQL stack. A stack is simply a collection of software and hardware used in development of an application. For our specific purposes we are using Ruby on Rails on the backend/server, PostgreSQL to house our database, and JavaScript + React + Redux for frontend rendering and logic.

Don't be overwhelmed! We'll trickle in these new technologies overtime. This Foundations course will focus purely on Ruby for now, so let's get our machines ready!

### Phase 0: Preparing your machine

Follow the insatllation walkthrough above. The commands you need to enter are listed below. Here we will install basic developer tools, such as homebrew (a 3rd party package manager for MacOS), Xcode (a library of developer tools provided by Apple), git (a version control system we will be using throughout the course), and VS Code (a full-featured text-editor).

### Chrome
Here at App Academy, our browser of choice is Google Chrome. This isn't super important at the beginning of the course, but once we get into frontend development the Chrome Devtools (think frontend debugging) are going to play a very important role.

To install, download from the Google Chrome and install.

### Xcode
Let's start with Xcode. The Xcode command line tools are a requirement for installing the homebrew package manager in the next step.

NOTE: If you are using a Linux machine you will not be able to install Xcode or homebrew. Instead please follow these git installation directions and then these rbenv installation directions (up to and including "Installing Ruby versions") to download rbenv using git. Once you are finished, skip to the section on Git and ignore all commands involving homebrew.

Install the Xcode command line tools by running the following from the console.

```$ xcode-select --install```

To conclude the installation you will need to agree to the Xcode license. Start the Xcode app, click "Agree", and allow the installation to finish. Then you can go ahead and quit the Xcode app.

### Homebrew
Homebrew is kind of like a low-tech App Store. It allows us access to and the ability to install a wide variety of software and command line tools from the console. These are distinct from those hosted on the App Store and will need to be managed by Homebrew.

Enter the following in your terminal to download and install Homebrew:

```/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"```

You will be given a list of dependencies that will be installed and prompted to continue or abort. Press RETURN to continue.

Let's break this command down a bit. curl, a command-line tool commonly used for downloading files from the internet, is used to download the Homebrew installation file. The "$(...)" transforms the file content into a string. Finally, the string is passed to our Ruby executable (/usr/bin/ruby is where this the system Ruby executable file is stored on our machine) with the -e flag to tell Ruby to run the argument as code.

Check out the Homebrew website to learn the basic commands.

### Git
Git is a version control system that allows us to track, commit and revert changes to files within a directory. Here we will install it and add global user info.

```
# install git
brew install git

# makes git terminal output pretty
git config --global color.ui true

# this will mark you as the 'author' of each committed change
git config --global user.name "your name here"

# use the email associated with your GitHub account
git config --global user.email your_email_here
```

### VS Code
This one is pretty easy. Go to code.visualstudio.com, then download and install VS Code.

To verify that the shell commands were installed correctly, run which code in your terminal. If code is not a recognized command, open the VS Code editor, open the Command Palette (Cmd+Shift+P on macOS ,Ctrl+Shift+P on Linux) and type shell command to find the Shell Command: Install 'code' command in PATH command. Then restart the terminal. This allows you to easily open files in VS Code from the terminal using the code command followed by a file or directory.

Next, we'll want to install a few useful VS Code extensions and configure VS Code to play nice with these extensions. Download this zip file, which contains a scripts that will do the work for you. Unzip the file and open the setup_vscode directory. Then open that directory in the terminal (drag and drop it over the terminal icon on macOS or right click in the directory and select Open in Terminal on most Linux distributions). To run the script, type ./setup_vscode.sh. The script will do the rest. Simply restart VS Code and you'll be good to go. (Note that there's a second script, called setup_vscode_linter.sh. We can't run this script yet but will do so in due time.)

## Phase 1: Ruby

Follow the insatllation walkthrough above. The commands you need to enter are listed below.. Here we will be setting up Ruby with the help of rbenv, a Ruby environment manager. We like rbenv because it allows us to switch between versions of Ruby easily and setup default versions to use within project directories. This will install instances of Ruby in addition to the system version, which comes pre-installed.

### Rbenv + Ruby
First we will install rbenv, then use it to install our desired version of Ruby.

```
# install rbenv
brew install rbenv

# add to the PATH (rbenv commands are now available from terminal)
# .bashrc is the file that contains all of our terminal settings
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

# initialize rbenv everytime you open a new console window (otherwise our system ruby version will take over when we start a new terminal session)
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# update current console window with new settings
source ~/.bashrc

# source .bashrc from .bash_profile (necessary on some machines)
echo 'source ~/.bashrc' >> ~/.bash_profile

# install Ruby version 2.5.1
rbenv install 2.5.1

# set version 2.5.1 to be our global default
rbenv global 2.5.1

# the 'rehash' command updates the environment to your configuration
rbenv rehash

# and let's verify everything is correct
# check the version
ruby -v # => 2.5.1

# check that we are using rbenv (this tells you where the version of ruby you are using is installed)
which ruby # => /Users/your-username/.rbenv/shims/ruby
```

### Gems
There are a few gems we will want to access globally.

Bundler allows us to define project dependencies inside a Gemfile and gives us a bunch of commands to update, remove and install them. Check out the Bundler docs for more info.
Pry is an alternative to the Irb (the default Ruby REPL). It is not only more powerful, but also easier to use than Irb and should be your go-to for running and debugging Ruby code. Check out the Pry website for more info and a super useful tutorial.
Byebug is feature-rich debugging tool for Ruby. With Byebug you can halt the execution of your code and inspect/track variables and the flow of execution. Lots of cool features in here, so check out the Byebug docs!
Let's install them.

```
gem install bundler pry byebug
Continue To Next Page ➞
```

<br />


# How To Complete Projects
The following video demonstrates a basic workflow for projects in the Alpha Course. This includes opening your project in a text editor, installing gems, and running specs. Please do not be afraid to ask for help if you get stuck on any project or have any problems with your development workflow. We are here to help you succeed!

https://player.vimeo.com/video/255818770

## Summary
 1. Click download link to download archived project folder
 1. Extract the contents by clicking in Chrome or double clicking in Finder
 1. Open the Terminal application
 1. Drag the newly extracted folder from Finder down to your dock and drop it onto the Terminal application (this is an easy way to change directory into that folder!)
 1. Run the bundle install command to install the gems specified by the Gemfile
 1. Run the bundle exec rspec --color command to run your tests
 1. Run the atom . command to open up the current directory in the Atom
 1. Open the lib folder and write the code to pass the specs
 1. Return to the Terminal and run the specs again until everything is passing

## When you are finished
 1. Open your project folder in Finder, right-click it and choose "Rename"
 1. Name the folder #{firstname}_#{lastname}_#{projectname}
 1. Right-click the renamed folder and choose "Compress..." (Linux users will have to use the command zip -r {zippedfoldername} {foldername} in the terminal).
 1. Return to the task on AppAcademy Online and click the submit button to upload your finished project.

## Additional Tips
 * Make sure the Terminal application is pinned to your dock for easy access by right clicking it in your dock and selecting Options > “Keep In Dock”
* If you do not have the atom command in Terminal, open up Atom and go to Atom > Install Shell Commands, then restart your Terminal application
* Use the expected and got output from running rspec to help you pass the tests

<br />


# Command Line and Atom

## Command Line Exercises and Shortcuts
Today, we're going to become comfortable using the command line. The more you can do without leaving the terminal, the more efficient you will be as a developer. Seconds saved during common operations may seem trivial at the moment, but summed over the course of your career they will be invaluable. Furthermore, the less you need to worry about coding "logistics," the more you can focus on coding itself!

A quick note before we start: whenever you are learning a new concept in development, never copy and paste code. You will remember it much better if you type it out. Take the extra few seconds, or even minutes if necessary.

Let us begin!

### Commands to Master

*   `ls`
*   `pwd`
*   `cd`
*   `mkdir`
*   `touch`
*   `atom`
*   `cp`
*   `mv`
*   `rm`
*   `man`
*   `zip`
*   `unzip`
*   `clear`
*   `open`

### Spotlight Search
1. Start by pressing ⌘-SPACE to open Spotlight Search.

1. Type in terminal and press enter to open the Terminal app.

1. Terminal will start in what is called the HOME directory, denoted by ~.

#### `ls`
List out all the contents in your home directory with ls.
```
ls
```
You should see a number of directories here, such as:
```
Applications Documents    Library      Music        Public
Desktop      Downloads    Movies       Pictures
```
If you don't, try using this command before using ls. We will cover it soon.

```
cd
```

#### `pwd`
To see what directory you are currently in, use `pwd`, which stands for "print working directory."
```
pwd
```
This should print out something like this:
```
/Users/username/
```

This is the path to our home directory, denoted by ~. Most of the files and directories we work with will be contained inside this directory. Levels above our home directory, for instance at `/Users/` or just `/,` contain information that our operating system uses to run. Feel free to poke around, but don't change anything.

#### `cd`

Our current working directory (CWD) is the directory that is currently being looked at by the terminal. Right now, that is the home directory (~).

`cd` stands for "change directory".

Change your current working directory to the Desktop by using the cd command.
```
cd Desktop
```
Note: You can avoid typing out the entire name of any file or folder by using the 'tab' key to autocomplete.

List out all the content in this directory. These are the contents of your Desktop.

The pwd command we used earlier prints our CWD (current working directory). Use it to see our new current working directory. It should now look something like this:
```
~/Desktop$
```
Earlier, we used the cd command without a directory. The cd command will default to ~, the HOME directory.

#### `mkdir`
Make your own directory called my_directory by using the mkdir command.
```
mkdir my_directory
```
List out the contents to see this new directory.

Change your current working directory to be your new directory and make another called my_subdirectory inside of my_directory

#### `touch`
Go into your sub directory and create a new file called my_file.txt with the touch command.
```
touch my_file.txt
atom
```
Open up your newly created file in the Atom text editor by using the atom command.

#### `atom .`
The . denotes the CWD.

Add some text to your file and save it!

#### `cp`

It would be a shame to lose your hard work. Create a copy of your file my_copied_file.txt with the cp command.
```
cp my_file.txt my_copied_file.txt
```
List out all the contents here to see it.

Move up to the parent directory with:

#### `cd ..`

As . denotes our current directory, `..` denotes the directory above our current directory, or in other words, the parent of our current directory.

What if we want to copy an entire directory, including all of its contents? We can provide the cp command a -r flag, or option, to tell cp to recursively copy my_subdirectory as my_copied_subdirectory. By recursively copying, it will continue to copy any nested subdirectories until it copies all subdirectories and files inside of them. We will learn more about recursion in the main curriculum.
```
cp -r my_subdirectory my_copied_subdirectory
```
List out the contents of your CWD to see it.

List out the contents of your newly copied subdirectory:
```
ls my_copied_subdirectory
```
Note: The default for ls is to list the contents of ., the CWD.

#### `mv`

Moving and renaming both happen with the same command, mv. Rename my_copied_subdirectory as my_moved_subdirectory by moving it with the mv command.
```
mv my_copied_subdirectory my_moved_subdirectory
```
List contents.

If we move a file or directory to a name of an existing directory, it will move it inside of that directory. Move my_moved_subdirectory into my_subdirectory.
```
mv my_moved_subdirectory my_subdirectory
```
List contents to check that it moved.

Be careful with mv and files! If we mv a file be the same name of another file in that directory, it will overwrite that file without warning.

When using commands that reference directories, we can chain them together until we get where we want. Let's cd into my_moved subdirectory, which is inside of my_subdirectory.
```
cd my_subdirectory/my_moved_subdirectory
```
See what's in here.

#### `rm`

We can delete, or remove, directories and files from the command line using the rm command. When using rm, we have to handle files and directories differently. We can delete files easily, let's delete our text file in our CWD.
```
ls
rm my_file.txt
```
Check that it's gone.

Directories are different in that they could have contents inside of them. Because of this, we must first recursively delete all of the contents inside the directory before deleting the directory itself. To achieve this, we use the -r flag, similar to cp -r. If we try to delete a directory without the -r flag, we will get an error. Let's move up one directory, and then delete my_moved_subdirectory.
```
cd ..
ls
rm -r my_moved_subdirectory
```
Make sure it's gone.

When we say the rm command deletes something, the item removed doesn't get put it in the Trash. It's gone... forever. This command is incredibly powerful, and with great power comes great responsibility: be absolutely sure you want to delete a file or directory with all its sub-directories before running this command. There's no going back.

#### `man`

That was warm up! We'll find that there are a lot of useful tips and documentation right in our terminal and tools. Let's get serious by opening up the manual for the zip command using man.
```
man zip
```
We are viewing the manual for the zip command in a program called less. We have to navigate it using our keyboard. Spend a minute or two trying out the following sets of commands:

There are a few layouts to move up and down one line:
* `e` and `y`
* `j` and `k`
* `up-arrow` and `down-arrow`

Take your pick!

Move up `u` and down `d` half of a page

Move to the top `g` and bottom `G` of the whole document.

Search for a word or phrase with `/` followed by the word. This will appear in the bottom line of your terminal. Press `enter` to search.
```
/archive
```
Skim the manual and figure out how to zip directories with zip. The USE section will be useful here. Feel free to search for it!

When you're done, press q to exit the doc. We can use man to explore the uses of any command line function. Who needs Google? The answers lie within.

#### `zip`

Use your new found knowledge to create a zip of my_directory.
```
zip -r my_directory.zip my_directory
```
Check that it's there.

Now that you've compressed your files, you can delete the originals by using rm -r.

Don't forget to check that it's gone.

#### `unzip`

Fear not. Whenever you need your files, just use the unzip command with your zip file.
```
unzip my_directory.zip
ls
```

#### `clear`

Clean up your terminal window. Use clear to clear your scrollable history.
```
clear
```
You can also do this by pressing `⌘-k`.

#### `open`

The open command will open a file or folder with the default application. The default application for a folder is Finder. While you may be more comfortable using a GUI right now, using the terminal is markedly more efficient for most common tasks. So try to use it as much as possible! Stay a while and you'll learn to love it.

Open your CWD in Finder:
```
open .
```

#### `say`

Lastly, have countless hours of fun talking to your computer with the say [text] command.
```
say hello world
```
Keyboard Shortcuts
Just like using the terminal, these keyboard shortcuts will make development much faster. Use them often and they will become second nature in no time. When someone is cruising around their code with shortcuts on the job or in an interview, it demonstrates experience and dedication towards making their development workflow more efficient.

[VS Code Shortcuts Cheat Sheet](https://github.com/jlollis/AAA-AppAcademy/blob/master/vscode-keyboard-shortcuts-windows.pdf)

