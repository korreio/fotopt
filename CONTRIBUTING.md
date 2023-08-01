# CONTRIBUTING.md

## Contributing to foto@pt - Fotografia em Português

First off, thank you for considering contributing to foto@pt. It's people like you that make the foto@pt community such a great one.

### 1. Where do I go from here?

If you've noticed a bug or have a question, check the existing issues if there's one similar. If not, you can open a new issue.

### 2. Fork & create a branch

If this is something you think you can fix or implement, then fork foto@pt and create a branch with a descriptive name.

A good branch name would be (where issue #123 is the ticket you're working on):

```sh
git checkout -b 123-contribution
```

### 3. Code

You're now ready to make your changes! Feel free to ask for help; everyone is a beginner at first.

### 4. Submit your Pull Request

At this point, you should switch back to your master branch and make sure it's up to date with foto@pt's master branch:

```sh
git remote add upstream git@github.com:original/foto@pt.git
git checkout master
git pull upstream master
```

Then update your feature branch from your local copy of master and push your update to your fork:

```sh
git checkout 123-contribution
git rebase master
git push --set-upstream origin 123-contribution
```

Finally, go to GitHub and make a Pull Request.
