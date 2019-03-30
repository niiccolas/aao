# Homework with Git

Starting today, and for the duration of your cohort, you will use git to submit all of your homework assignments. All homework assignments will be accumulated into a single repo on GitHub. Each day's homework will be done in a local copy and pushed up to GitHub daily.

The homework for the day should be submitted before 9 AM of the day in question. Homework scheduled for W1D5 needs to be submitted on W1D5 before 9 AM.

## Setup

Let's initialize our repo and setup a GitHub remote before moving on to adding homeworks.

*   Create a new folder in the directory of your choosing, the name of your directory should contain the word _homework_ with any App Academy related prefix/suffix.

        cd path-to-some-directory
        mkdir aA-homeworks

*   Initialize empty git repository in your new directory

        cd aA-homeworks
        git init

*   Create a basic README file and initial commit

        touch README.md # makes file in current directory
        echo "# App Academy Homeworks" >> README.md # "creates 'App Academy Homeworks' header in README"
        git add README.md
        git status # let's get in the habit of making sure we commit the intended files
        git commit -m "Initial commit"

*   Create remote repository on GitHub

    *   Login to GitHub and click the "New Repository" button.
    *   Use the default settings and click "Create Repository".
*   Add GitHub remote repository to local version and make first `push`.

    *   You will need the url for your newly created remote. This will be `https://www.github.com/<username>/<repo-name>.git`. Note the `.git` at the end.

        git remote add origin https://www.github.com/<username>/<repo-name>.git
        git push origin master

*   We've now successfully setup a repo on GitHub and made our first push.

## Submitting homework

We want to do our homework within our _homeworks_ repo. If we've just initialized our homeworks repo then we already have the most up-to-date version on our machine, but if we are doing our homework from a different machine we will need to _clone_ our remote repo to make a new local copy we can work from.

As we progress, we will create a new directory for each day's work. The following directory structure is an example of how your Github repository should look like. As developers we need to follow the directory naming and structure conventions of the company we work for, AppAcademy is not the exception; **not following AppAcademy directory convention will result in your homework not being accepted.**

    aA-homeworks/ (root directory)
    ├── W1D3
    │   └── recursion.rb
    ├── W1D4
    │   └── rabbit.txt
    ├── W1D5
    │   ├── map.rb
    │   ├── queue.rb
    │   └── stack.rb
    └── W3D4
        ├── active_record_warmup
        │   ├── Gemfile
        │   ├── Gemfile.lock
        │   ├── lib
        │   └── spec
        └── n_plus_1_buster
            ├── Gemfile
            ├── Gemfile.lock
            ├── lib
            └── spec

Before beginning the day's homework, ensure your local repo is up-to-date with the remote:

*   If we have a local copy, check if it is up-to-date. Type command `git status` in terminal. If local is up-to-date, we should see `Your branch is up-to-date with 'origin/master'`. Otherwise type command `git pull` in terminal to update your local version.
*   If we do not have a local copy, use `git clone`. This will create a new copy of your repo in the current directory.

        git clone https://www.github.com/<username>/<repo-name>.git

To add homework, start by creating a new folder _WXDX_ in your _homeworks_ directory. Do your homework in that directory, and commit often! When you are done, simply run:

    git push origin master

*   **NB: git commit messages should start with capitalized verbs in the imperative mood that tell what the commit does and should not have any trailing punctuation**

