# Git

## What is this thing called Git?

Git is a Version Control System.

So far, we've been working on small projects with small groups. If we make mistakes, it isn't too hard to backtrack. However, as we begin to work on larger projects with larger groups, revising and adding code can become a tricky endeavor. What if one team member accidentally overwrites important code written by another team member? What if two team members try to edit a section of code at the same time? Disaster could ensue!

Enter Version Control Systems. Version Control Systems allow us to:

*   Keep a log of changes made to a project
*   Revert the project back to a previous state if we mess something up

Git also provides us an easier workflow to develop as a team, such as the ability to separate our work from others using branches. A branch is like a private copy of the main project that can be changed without modifying the original. These branches, when complete, may be merged back into the main project, bringing with it the accumulation of all the little changes made on it.

## How Git Stores Things

Two important concepts:

1.  Git stores data as a series of snapshots.

*   Every time you make a commit, or store your data, Git takes a snapshot of all the changes you've made and stores a reference to that snapshot. We can easily look through previous commits and see what changes were made in each one. This concept of a "stream of snapshots" is what makes Git different from most other Version Control Systems.

1.  Git performs most operations locally.

![distributed-centralized](https://git-scm.com/book/en/v2/book/05-distributed-git/images/centralized_workflow.png)

Git is distributed but centralized. What does that mean?

While a "master copy" of each repository (aka project) often lives in a remote location such as Github, each project contributor also keeps a copy of the repo, along with its version history, locally. When we want to look through past changes or save new changes to the project, we look to our local repo - no need to fetch data from the server every time.

Only when we want to push our changes up to the remote "master copy" or grab other people's changes do we fetch from or push to Github.

For more details on how Git works and how it's different from other Version Control Systems, check out [this excellent and detailed reading](https://git-scm.com/book/en/v2/Getting-Started-Git-Basics).

## The Three States of Git

So, how do we actually take advantage of Git's version control system? First, lets learn about the three states of Git.

![git-stages](https://git-scm.com/book/en/v2/book/01-introduction/images/areas.png)

Files can live in three different states: modified, staged, and committed. A typical Git workflow goes like this:

1.  You make changes in your working directory. Your files are now **modified**.
2.  You decide which files you want to add to your next commit and add them to the staging area. Your files are now **staged**. Don't want a change to be committed? Simple - don't stage that file.
3.  You commit all of the files in your staging area and create a snapshot which permanently lives in your local Git directory. Your files are now **committed**.

(Note: all of this happens locally. Pushing files to your remote repository is a separate business.)

Ok, so how do we actually stage and commit files? To be explained in the following readings!

<br/>

# Git summary

### `git init`

*   When you first begin your project, use `git init` to setup a git repository. You should do this before you write any code.

### `git status`

*   Use this to see what modified files have not been staged, what files are untracked.

    ~/aa/ruby-curriculum$ git status
    # On branch master
    # Changes not staged for commit:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #       modified:   README.md
    #       modified:   git.md
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       git-summary.md
    no changes added to commit (use "git add" and/or "git commit -a")

### `git add`

*   Use this to add files to staging. When you `git add` a file, the next time you commit, this version will be saved in the repo.
*   NOTE: `git add` only adds the changes you have made thus far. This means that is you add a file's changes to staging, make more changes to it, then commit without re-`git add`ing it, those recent changes will not be committed.

    ~/aa/ruby-curriculum$ git status
    # On branch master
    # Changes not staged for commit:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #       modified:   README.md
    #       modified:   git.md
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       git-summary.md
    no changes added to commit (use "git add" and/or "git commit -a")
    ~/aa/ruby-curriculum$ git add git.md
    ~/aa/ruby-curriculum$ git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       modified:   git.md
    #
    # Changes not staged for commit:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #       modified:   README.md
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       git-summary.md

### `git commit`

This will save the work currently staged (from `git add`) into the history by creating a new _commit_. A commit is a checkpoint that you can return to later if your code gets screwed up.

**Commit frequently**. As you add small bits of functionality, write fine-grained commits. Do not wait until you've written half your program to commit.

Every time you are about to make a major change to your program, you may want to commit what you have. That way, if you screw up, you can undo easily.

You will be hard-pressed to over-commit when starting out. You probably want to commit at least once every 5min. You may commit more often if you add quick-to-write features.

*   `git reset`

If you add something you don't want to add, and would like to unstage all staged changes (so that the staged files return to "Changes not staged for commit"), use `git reset`.

## Later

*   `git clone`
*   `git fetch`

<br/>

## Simple Git Workflow

Git is a powerful tool, and it will take time to take full advantage of its features. When starting out, however, you only need a few commands to protect your work.

## Setup

You should use Git's command line interface. When starting your project, there are two essential commands.

    git init
    git remote add your_alias https://github.com/your_username/your_repo_name

Let's break this down line by line:

### `git init`

This creates an empty repo in the current directory. Git looks at the current directory and its children: this means that you should create the repo at the root level of your project. In particular, in a Rails project, you want to run `rails new`, `cd` into the directory you just created, then run `git init`.

### `git remote add your_alias https://github.com/your_username/your_repo_name`

This command breaks down into the following components:

*   `git remote` accesses the git commands that interact with remote repos
*   `add` (not to be confused with `git add`) is a `git remote` command that adds a remote repo to the current repo
*   `your_alias` sets a name you can use locally to refer to the remote repo; use `origin` unless you have a reason not to
*   `https://github.com/your_username/your_repo_name` sets the location of the repo (this example is for HTTPS; for SSH, it will look different). You will have to create this separately, either in the browser or through the command line

At this point, you have a local repo (stored in the .git directory) and a remote repo, which you can reference with `your_alias`; time to start working.

## Working

Now you've written some code and are ready to commit. You need three commands:

    # add/update specific files
    git add <files>
    # add/update all files
    git add -A

    git commit -m "Some comment"
    git push

Line by line:

*   `git add <files>`: adds changes to listed files to staging area
*   `git add -A`: adds changes to all files in the working directory to the staging area

So far, all we've done is told git to prepare to commit; nothing is persisted to the repository.

*   `git commit -m '[Your commit message here]'`: takes currently staged changes and stores them in the repository. `-m` is a flag indicating that we want to write our commit message on the command line rather than in our default editor. A commit message is a brief summary of the changes that we're committing. Your commit message should be descriptive and written in the imperative, so that someone reading your commit history (maybe you!) can understand what you changed. Always start your commit messages with with a capital letter, an imperative verb and leave off any trailing punctuation.

At this point, our local repository has a record of the commit, but we haven't touched the remote repo.

*   `git push`: pushes our local commits to the remote repository. The first time you run this, you need to run the command as `git push -u your_alias master`, which will set the master branch in the remote repo `your_alias` as the upstream tracking branch for your local branch. Once you have set this up, you will be able to run `git push` and git will direct the push to the upstream repo. To push to a particular remote, use `git push remote_name branch_name` (for example, `git push origin master`).

If you are using HTTPS, you will need to authenticate with GitHub when you push; when using SSH, your computer and the server will use your SSH key to handle this for you. For this reason, it is worth setting up SSH on your dev machine. On App Academy machines, use HTTPS.

## How Often to Commit and Push

Frequently.

Pushing to GitHub is one of the most useful features we have in Git. This is because, ultimately, code problems are always fixable: if you can create a bug, you can eliminate it through debugging alone (not that you shouldn't revert to a previous commit if that is the best solution). Pushing to a remote does a few additional things:

*   Backs up your work
*   Makes your code portable
*   Gets you green squares

A good rule of thumb is to commit whenever you make something and confirm that it works (the second part is important; you don't want non-functional commits cluttering your repos). Most commits will be small; this is good, as it reduces the cost of reverting to a previous stage. You don't have to push every time you commit, but there is usually no reason not to.

## Reference

When you create a new GitHub repository in the browser, GitHub will provide a summary of the commands needed to connect it to a local repository.

For common git commands, check out the [git summary](git-summary).

*   Accessing this on GitHub? Use [this link](https://github.com/appacademy/curriculum/blob/master/ruby/readings/git-summary.md).

For more on writing good commit messages, check out [this post](http://chris.beams.io/posts/git-commit/) by Chris Beams.

<br/>

# RubyGems

Sometimes, developers writing code notice that they've written something that might be useful to others. If they are nice people, they package that code up into a **gem** (also often called a **library** outside Ruby contexts) and share it with the world. This can be anything from a few short methods to a web framework as large as Rails.

Let's see how to find, install and use a gem.

## Finding gems

The single best place to find gems to use is GitHub. I often just simply Google around for what I want to do, read StackOverflow for suggestions, and then look at the gem's GitHub repo to see if it's what I want.

On GitHub you can see how many people have followed the repository, and how recently it has been updated. Gems that have >1k follows are mainstream and can be relied upon to be pretty much rock-solid and typically very well documented. Gems with more than 500 follows are fairly popular, but it may be harder to find answers to problems by searching around. Gems with less than 500 follows are not super popular, and might not be be quite as well maintained. Generally I won't use a gem with <100 follows; I like to let others solve bugs for me :-)

## Installing gems

Let's check out [Awesome Print](https://github.com/awesome-print/awesome_print), a library that "pretty prints" Ruby output (**NB**: pry already prettifies output, so awesome_print won't seem as awesome as if we were using plain irb).

The Awesome Print GitHub shows us how to install the gem: `gem install awesome_print`. That's it!

## `sudo gem install` and rbenv

> **This section is OS X and Linux specific**. Windows users cannot install rbenv: it's only for *nix systems. However, Windows users who have installed Ruby through RubyInstaller can already install gems without using `sudo` and are already using an up-to-date Ruby.

If you aren't using rbenv, you will run into an error like this:

    ~$ gem install awesome_print
    Fetching: awesome_print-1.1.0.gem (100%)
    ERROR:  While executing gem ... (Gem::FilePermissionError)
        You don't have write permissions into the /Library/Ruby/Gems/1.8 directory.

This is because the built-in Ruby that comes with OS X installs gems in a system directory where you need superuser permissions to create files. You'll read in some places that you should use `sudo gem install awesome_print`; **DO NOT DO THIS!**

Instead, setup rbenv (See [the dev environment setup instructions](setting-up-a-development-environment-phase-1) for more details). Accessing this on GitHub? Use [this link](https://github.com/appacademy/curriculum/blob/master/course/readings/dev-setup.md). Once rbenv is installed, there will be no need to use `sudo` and you should no longer get this error. However, you must **never** use `sudo gem install` with rbenv or you'll wind up with [permissions issues again](http://stackoverflow.com/questions/28846165/permission-error-when-trying-to-install-rails-osx).

## Using gems

We should now be able to require source files provided by the gem:

    [1] pry(main)> require 'awesome_print'
    => true
    [2] pry(main)> ap({:this => "is totally awesome!"})
    {
        :this => "is totally awesome!"
    }
    => nil

You'll need to read up on how to use your newly installed gem. The github often has examples that show you the most common methods and how they are used. Well documented libraries like RSpec have whole websites of [documentation](https://www.relishapp.com/rspec). Documentation is normally linked to on the GitHub page; else I do a quick Google search.

Documentation can often be spotty and incomplete. In that case, you may have to explore the code itself on GitHub to try to figure out how things work.

<br/>

# Git

## A Brief History

Version control has been around as long as writing has been around. In print, this existed as the numbering of different book editions. However, version control became much more complicated when the era of computing began. Software developers needed a way to work simultaneously on the same project, while also keeping previous versions in case newer versions contained bugs. Thus, the version control system (VCS) was born.

Git was developed in April 2005 after Larry McVoy withdrew free use of BitKeeper, the VCS that the Linux kernel community had been using. (Note: BitKeeper was originally proprietary software but has been released as open source software as of May 9, 2016). Linus Torvalds, creator of Linux, decided that none of the current free VCSs met his needs for performance. He wanted to design a system where:

*   patching would take no more than three seconds

*   workflow would be distributed

*   there would be very strong safeguards against corruption.

Development began on April 3, the project was announced on April 6th, and it became self-hosting on April 7th. The first merge of multiple branches happened on April 18th. In July 2005, Linus handed over maintenance of the Git project to Junio Hamano.

Since then, Git installations have skyrocketed and many users have switched over from other VCSs.

## Alternatives and Usage

Today, Git is by far the most widely used VCS. However, there are various other systems with different benefits. This is by no means an exhaustive list, but here are a few alternatives to Git.

### Git

Before we dive in to alternatives, let's talk about some characteristics of Git. Git is a free open source distributed version control system. Unlike its predecessors, branch operations are fairly cheap. It uses a distributed (peer-to-peer) model and full history trees are available offline. Git works very well for many developers working on the same project, but is not necessarily the best for single developers. While powerful, the learning curve for Git is steep. In addition, there is limited Windows support compared to Linux.

Currently Used By: Intel, Netflix, Yahoo, GitHub

### Concurrent Versions System (CVS)

CVS has been around since the 80s and is considered one of the most mature version control systems. It was released under the GNU license as free open source software. However, there has not been a new version released since May 2008\. Several factors account for its fall from popularity. In CVS, moving or renaming a file, or changing a file connected via a symbolic link does not register as a change; both of these actions are recognized by Git as a change. In addition, commits are not atomic, and branch operations are expensive.

### Apache Subversion (SVN)

SVN is another free, open source software, released under the Apache license. SVN improves upon CVS with atomic operations and cheaper branch operations. However, compared to other VCSs, it is still slow and doesn't have as many repository management commands. It is important to note that SVN is server-based rather than peer-to-peer, which may work better for some situations than others. It does not fix the bugs that CVS had with renaming files and directories.

Currently Used By: LinkedIn, Atmel

### Mercurial

Like Git, Mercurial uses a distributed model and branching is relatively inexpensive. Many developers chose Mercurial over Git because of the similarities it shares with SVN, and because it has better support for Windows users. Because Mercurial is implemented primarily in Python rather than C, it is also easier to add extended functionality.

Currently Used By: Bitbucket, OpenOffice

<span></span>

## Vocabulary

#### Version control aka revision control or source control.

Versions are usually identified by some number/code, a timestamp, and the person who made the change.

Ex: "Version control lets the user compare versions, revert to a previous version, or merge versions."

#### Open source software

Software where the original source code is available to be redistributed and modified.

Ex: "I believe in open source software, like Linux."

#### Proprietary software

Software that is owned by an individual or company. There are usually restrictions to use and source code is often kept secret. Proprietary software that comes free of charge is called freeware.

Ex: "macOS is proprietary software - that's why building hackintoshes is illegal."

#### Server-based

There exists a single central repository that each client synchronizes with.

Ex: "Gmail is a server-based application."

#### Peer-to-peer

Each client holds a complete repository and synchronizes by exchanging patches peer-to-peer. This is an example of a **distributed system**.

Ex: "Napster was one of the first major peer-to-peer applications."

#### Atomic operations

Operations whose changes are rolled back if they are somehow interrupted before completion. This helps prevent source corruption.

Ex: "The SQL standard requires database operations to be atomic."

#### Repository (repo)

A collection of commits, and branches and tags to identify commits.

Ex: "I wanted to be able to access it from home, so I pushed it to my Github repo."

#### Semantic versioning (a.b.c or x.y.z versioning)

Given a version number MAJOR.MINOR.PATCH (e.g. 2.0.6), increment the MAJOR version when you add any backwards incompatible changes, the MINOR version when you add backwards compatible features, and the PATCH version when you make backwards compatible bug fixes.

Ex: "Based on the semantic versioning, I can tell that the new version of Ruby isn't backwards compatible."

<br/>

# Agile

Agile is a rapid application software development methodology that focuses on highly iterative design. The term was coined in 2001 with the publication of the _Manifesto for Agile Software Development_, which was written by a group of software developers who wanted to share what they had learned about project management. Agile is the latest popular example of a lightweight software development method. The first of these were developed in the 1990s as an alternative to the prevailing heavyweight methods, which were heavily micro-managed and rigidly planned. Many of Agile's lightweight predecessors are now considered agile methods.

Agile methodology operates on a number of core principles. Key to these principles is the idea of rapid, iterative design. The agile philosophy is that a product should be broken up into small parts that can be rapidly developed so that results can be shown to the client constantly. If the requirements for any piece of the product or the whole product itself should change at any point, the team can respond quickly to those changes because they haven't been developing something too unwieldy to redesign.

Team management is also critical. Each team must be **cross-functional** -- that is, a team that can organize and manage itself throughout the entirety of their piece of the project and each iteration of that piece. This means that a single team is continuously working in every step of development, from planning and design, to coding and testing. It can therefore respond quickly to any changes, instead of needing to wait upon another department or team.

Agile development has become the norm. While each company might have their own personalized implementation of agile, the basic principles are incredibly popular. Companies such as Microsoft, Facebook, Amazon, Spotify, and even teams at Google are using agile methodologies to respond to the needs of their clients and to rapidly get products published.

## Terms

**Co-location** is a critical part of agile methodology. This is the idea that a team is all working out of the same space. Face to face communication allows for team building, faster communication and collaboration, and an easier time responding to the iterative process of agile development.

**Pair programming** is an agile technique that results in a significant improvement to product quality. Two people approaching a task bring with them different backgrounds, experiences, information, and expertise. Open discussion about how to approach and solve a particular problem often leads to a better solution than a programmer working solo, who might try to implement the first solution they devise.

**Test-driven development** leads to more agile code. The better unit tests are in place, the easier it is to keep code error-free and rapidly iterate upon it. Writing tests before writing code means that all the design work is done first, so that the product will do exactly what it needs to do. Similarly, **refactoring** is a key principle. Because each piece of code is iterated upon so often in the agile process, constant refactoring is important to keep clutter down and to keep code easy to maintain. With the presence of tests, developers can refactor safely, knowing that their refactoring won't have broken a key aspect of their product.

**Continuous integration** is the process of integrating newly developed code back into a main branch multiple times a day. With robust enough tests in place, code can safely be merged as soon as even a small feature is complete. This prevents needing to reconcile massive merge conflicts, which can be fairly common if multiple developers were working on multiple feature branches. Resolving these conflicts can sometimes take longer than writing the feature itself.

## Alternatives

One of the oldest methodologies is the **waterfall** method. In the waterfall method, each phase in the development process is fully completed before moving on to the next one. For example, all the planning and design gets done and is approved before any of the coding starts, and all the code gets written before any testing happens. While this does lead to a well-documented, very stable path of development, the process does not lend itself well to any alterations made to the product partway through the process.

**Prototyping** consists of making multiple prototypes that will eventually be refined towards a final product. This allows a client to provide feedback on these prototypes and get a sense of actually working with the product, instead of having to produce feedback based only on documentation or descriptions.

The **spiral** method is an iterative design methodology that blends aspects of other methodologies based on risk analysis. Each iteration goes through distinct phases, and repeatedly passes through these phases until completion. Depending on the stage of development and the risk factors involved, the spiral method pulls in elements of the waterfall method, prototyping, or a basic incremental method in which projects are built in small pieces at a time.

<br/>

## HTML Form Element

Forms in HTML allow for users/clients to interact with your application/website by inputting data. We create form elements using `<form></form>` tags and then fill the form with a selection of different types of control elements.

The following list references the HTML Forms Guide, excellent documentation written by the Mozilla Developer Network. Teaching and remembering every aspect of HTML would be both difficult and fairly unneccessary. Instead we should get used to being able to quickly search correct HTML syntax and practice reading online documentation.

The table contains links to references about the most popular HTML form elements, their most popular attributes and some of those attribute's most popular values. Read through the docs as well as the notes below and then use both to complete tonight's exercise.

<table>

<thead>

<tr>

<th>Popular Elements</th>

<th>Popular Attributes</th>

<th>Popular Values</th>

</tr>

</thead>

<tbody>

<tr>

<td>[Form](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/form)</td>

<td>[action](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/form#attr-action), [method](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/form#attr-method)</td>

<td>Action takes a URI like "/example.com" and Method takes a HTTP request method of either "GET" or "POST."</td>

</tr>

<tr>

<td>[Input](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input)</td>

<td>[type](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#attr-type)</td>

<td>button, checkbox, color, date, email, hidden, number, password, radio, search, url</td>

</tr>

<tr>

<td>[Input](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input)</td>

<td>[checked](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#attr-checked), [name](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#attr-name), [placeholder](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#placeholder), [value](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#value)</td>

<td>These values depend on the attribute but are usually just "Text." Checked is either "true" or "false."</td>

</tr>

<tr>

<td>[Label](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/label)</td>

<td>[for](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/label#for)</td>

<td>The for attribute takes text corresponding to the id attribute of the element being labeled.</td>

</tr>

<tr>

<td>[Select](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/select)</td>

<td>name, disabled</td>

<td>These values depend on the attribute but are usually just "Text." Disabled is either "true" or "false."</td>

</tr>

<tr>

<td>[Option](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/option)</td>

<td>value, selected, disabled</td>

<td>These values depend on the attribute but are usually just "Text." Disabled/Selected is either "true" or "false."</td>

</tr>

<tr>

<td>[Textarea](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea)</td>

<td>maxlength, minlength, name, rows, cols, wrap, spellcheck</td>

<td>These values depend on the attribute but are usually just "Text" or numbers like "123."</td>

</tr>

</tbody>

</table>

## Notes

Some Notes on these popular HTML Elements:

*   Input Elements are by far the most common and special element of a form because they can take on completely different functionalities depending on their attribute type.

*   Labels can be written two ways, by wrapping the input element or by using the `for` attribute and applying a corresponding `id` attribute to the input.

*   Submitting forms makes a default post request with parameters made up by the provided values for each name attribute.

*   By giving each radio input element the same name attribute value, the radio buttons will only allow the user to select one per radio of that name per form.

*   `Option` elements are defined inside a `select` element and the value attributes for each option display what will be inside the dropdown.

<br/>

# Serialization and Persistence

## Goals

*   Know what serialization and persistence are.
*   Know how to transfer between a Ruby object and a [JSON](http://en.wikipedia.org/wiki/JSON) or [YAML](http://en.wikipedia.org/wiki/Yaml) representation.
*   Know how to save these to a file you might read again later.

## Serialization

Ruby objects live within the context of a Ruby program. You may want to send your Ruby object to another computer across a network. Alternatively, you may want to save your Ruby object to the hard drive, so that when you run your program again later, it might be reloaded. You cannot do either of these things directly.

To do this you need to first convert the Ruby object into a representation that can be saved to disk or sent over a network. This process is called **serialization**.

There are many, many serialization **formats**, or ways of representing data. Probably the most important in the web world is JSON:

    { "fieldA": "valueA",
      "fieldB": [1, 2, 3] }

JSON supports a few primitive forms of data: numbers, strings, arrays and hashes. It is descended from JavaScript, and is commonly used as the message format for web APIs. The format is pretty easy to read, but it's not essential that you be able to write JSON yourself; we'll see how to get Ruby to do that for us.

You can easily serialize basic Ruby objects to a JSON string:

    > require 'json'
    > { "a" => "always",
        "b" => "be",
        "c" => "closing" }.to_json
    => '{"a":"always","b":"be","c":"closing"}'
    > JSON.parse('{"a":"always","b":"be","c":"closing"}')
    => {"a"=>"always", "b"=>"be", "c"=>"closing"}

JSON doesn't know how to serialize more complicated classes though:

    > Cat.new("Breakfast", 8, "San Francisco").to_json
    => '"#<Cat:0x007fb87c81b398>"'

You can fix this somewhat by defining a `to_json` method on your classes, but that involves you writing custom serialization code. It will also be a pain to do the opposite translation.

## YAML

YAML is meant to solve the problem of saving custom classes.

    [11] pry(main)> require 'yaml'
    [12] pry(main)> c = Cat.new("Breakfast", 8, "San Francisco")
    => #<Cat:0x007ff434926690 @age=8, @city="San Francisco", @name="Breakfast">
    [13] pry(main)> puts c.to_yaml
    --- !ruby/object:Cat
    name: Breakfast
    age: 8
    city: San Francisco
    => nil
    [14] pry(main)> serialized_cat = c.to_yaml
    => "--- !ruby/object:Cat\nname: Breakfast\nage: 8\ncity: San Francisco\n"
    [15] pry(main)> puts serialized_cat
    --- !ruby/object:Cat
    name: Breakfast
    age: 8
    city: San Francisco
    => nil
    [16] pry(main)> c2 = YAML::load(serialized_cat)
    => #<Cat:0x007ff4348098e8 @age=8, @city="San Francisco", @name="Breakfast">

Notice that YAML has saved the instance variables of the object, as well as recording the class of object that was saved.

Note that `c` and `c2` are different objects; serialization and deserialization are sometimes used as a very lazy man's clone. Don't do this: it is inefficient and spares you the valuable learning experience of figuring out how to properly create a deep copy of an object.

JSON is the dominant serialization technology on the web (XML is a close second); we'll write Rails apps which we can communicate with by sending and receiving JSON data.

In the world of server-side Ruby, YAML is the leader because of its better support for deserializing classes.

<br/>

# Using Git `add`

Use `git add <files>` or `git add -A` instead of `git add .` or `git add -u`.

## The Background

When you run `git add .` you're telling git, "take everything that's new or has changed in my current directory and add it to the staging area". We discourage this, because we usually are only working on a few files at a time and it is easy to accidentally include files that have sensitive information (such as API Keys, etc.).

When you run `git add -A` you are telling git, "take my all the changes from my entire project up to my top level directory(where the .git directory resides) and add those to my staging area". We also discourage this, because we usually are only working on a few files at a time and it is easy to accidentally include changes that have nothing to do with the current commit.

What should I do instead?

*   You should be adding individual files as you create them and running `git add <file>`.
    *   This way you avoid adding any unwanted files and your commits are isolated.

NOTE: `-A` and `-u` are options of the `git add` command. They use the project directory if you don't explicitly give them a filepath, e.g. `git add -u lib/board`. For example, `.` is the filepath that you pass in as an argument to `git add`.

`git add -u` adds all new and updated files (but doesn't include deleted files!) - this command isn't as relevant when using Git 2.0\.

## The Visuals

<div>

<table>

<tbody>

<tr>

<td>**Command**</td>

<td>**`git add .`** (current directory)</td>

<td>**`git add -u`** (update)</td>

<td>**`git add -A`** (all)</td>

<td>**Recommended: `git add <files>`</files>** (explicit)</td>

</tr>

<tr>

<td>Effect</td>

<td>Adds everything that is new/has changed in the current directory.</td>

<td>Updates already tracked files and removes them from staging area if they're not in the working directory.</td>

<td>Finds new files as well as updating old files. (git add . + git add -u)</td>

<td>Adds, updates or deletes listed files.</td>

</tr>

<tr>

<td>Downside</td>

<td>Easy to accidentally include changes that have nothing to do with current commit</td>

<td>Doesn't track new files!</td>

<td>Easy to accidentally include changes that have nothing to do with current commit</td>

<td>Can be tedious for many files.</td>

</tr>

</tbody>

</table>

</div>

<br/>

# Git Repository Clean Up

So, you and your partner have finished the day's work and are ready to push to GitHub. But, you don't want to create _another_ repository. Wouldn't it be nice if you could put all your a/A projects into one tidy repository and still keep all your pretty green commit squares?

## Warning

**This is optional!**

Merging multiple projects into one 'super-repo' isn't a typical git pattern. All your various projects' commits will live in one branch of one repo. This pattern works OK for archived projects, but makes less sense for projects you'll be updating often. In that scenario, just keep your repos separate.

If you still want all your a/A projects in one repo, then...

## Here's how it's done:

### Pre-requisite -- do this only once!

1.  Create a new repo on GitHub -- call it `AppAcademyProjects` or something like that.

### At the end of each day

1.  Open your project's root directory and create a folder named after the day, e.g. `w1d5`.
2.  Move all of your project's content into that folder.
    *   This namespaces the days folders and files so that they don't conflict with other days' folders/files.
    *   **Don't move your .git folder!** Leave it at the root level.
3.  Commit this change.
    *   `git add .`
    *   `git commit -m "namespace w1d5 work"`

### Once for each partner

1.  Create a new branch.
    *   `git checkout -b <your name>`
2.  [Fix your authorship.](fixing-git-commit-authorship)
    *   Accessing this on GitHub? Use [this link](https://github.com/appacademy/curriculum/tree/master/ruby/readings/git-fix-authorship.md)
3.  Add a remote to your `AppAcademyProjects` repository and name it after yourself.
    *   `git remote add <your name> <your AppAcademyProjects' address>`
4.  Merge your remote repository into your local repository.
    *   `git pull <your name> master --no-edit --allow-unrelated-histories`
    *   `--no-edit` tells Git that you don't want to edit the commit message.
    *   `--allow-unrelated-histories` tells Git to perform the pull even though the local repo and remote repo don't share commit histories.
5.  Push your merges to your remote repository.
    *   `git push <your name> <your name>:master`
    *   This pushes the local `<your name>` branch to your `AppAcademyProjects` master branch.
6.  Switch back to `master` and repeat.
    *   `git checkout master`


<br/>

# Aliases are your friend

## What's an alias?

An alias is a shell command that enables the replacement of a word with another string. Aliases are not a git-specific tool, but git is a great use case. For example, instead of

    git commit -m 'add password length validation'

you can type

    gcm 'add password length validation'

If you're doing git right, you're making a lot of commits, so even a small optimization like this quickly becomes worthwhile. Aliasing your most commonly used git commands can make the difference between you lazily neglecting to make commits vs. committing frequently.

## Creating an alias

To create a persistent alias, you add a line to your shell's configuration file. The specific name of this file can vary between systems. On my Mac, `~/.bash_profile` does the job; on other systems, you might want `~/.bashrc` or `~/.zshrc`. Open your config file (ex. `code ~/.bash_profile`) and add your desired alias on a new line at the end of file, formatted like so:

    alias gcm='git commit -m'

Save the config file and **open a new terminal tab**. You can now use your alias.

## Adding aliases

Whenever I find myself typing a command repeatedly, I create an alias for it. Here's (more or less) what [my ~./bash_profile](http://assets.aaonline.io/fullstack/ruby/assets/bash_profile) looks like. I have aliases for git commands, filesystem navigation, and Rails-related commands. (Don't worry if you don't understand what all of the commands do.) I don't recommend copying this file directly, though. It's better to build up your own personal set of aliases based on which commands you use frequently and which abbreviations make sense to you.

I add shell aliases frequently enough that, somewhat recursively, I added an alias to open my shell configuration file, so that I can easily add a new alias: `alias bp='code ~/.bash_profile'`.

<br/>

# Fixing Git Commit Authorship

So you and your pair are doing it right, committing each piece of functionality for the day's project as you go along. Then the day ends, and you decide to push your work to GitHub to receive some precious _green squares_. But what's this? All the commits are attributed to App Academy Student! Or worse, a classmate accidentally added `--global` to the `git config` command, and now all the attributions are belong to them!

But there's still hope. Though you may not know it yet, you have the power to rewrite a Git repository's history. This means you can change the recorded author name and email, even after the history has been written. This power can be quite dangerous if not yielded with the utmost care and wisdom. Therefore, take heed of the advice that follows, lest you lose your beloved code.

## Caveats

*   Never rewrite history in a repo you're sharing with someone else who already has the commits on their computer. Rewriting history changes the commit hashes, so the other person will have huge issues pulling and pushing if you change the hashes of existing commits on the shared repo.
*   If you've cloned the repo from somewhere (e.g. a project skeleton), this command will rewrite the authorship for all commits, even those that aren't yours. This probably isn't what you want; unearned squares just don't feel the same.

## The Command

Follow these steps to rewrite your history so all commits have your name and email.

1.  **Create a backup branch.** That way, if something goes wrong, you can always get back to your original state.

        git branch wrong-author

    Seriously, any time you rewrite commits **for any reason**, backup the branch first!

2.  Run this command in the Terminal from within your repo's root directory, _being sure to put your information in place of the placeholders_

        git filter-branch -f --env-filter "GIT_AUTHOR_NAME='your_full_name'; GIT_AUTHOR_EMAIL='your_email'; GIT_COMMITTER_NAME='your_full_name'; GIT_COMMITTER_EMAIL='your_email';" HEAD

3.  If you've already pushed your repo to GitHub (or elsewhere), add `-f` to `git push` to _force push_, as all your commits now have different hash's from what they were before you rewrote the history.

4.  Go to your GitHub profile and bask in the glory of your newly-acquired green squares.

<br/>

### Projects:
* [HTML Forms]()
* [Screwedoku]()
* [Minesweeper]()