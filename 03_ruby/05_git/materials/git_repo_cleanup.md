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
