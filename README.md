# CMSC 330 Nix Flake

This repo can be used to install all required packages for CMSC 300, using Nix.

## Usage
First, clone this repository and enter the directory.

Then, enter the Nix dev-shell with the dependencies installed manually, or use [`direnv`](https://direnv.net) to automatically enter the dev-shell when you enter the directory:

```sh
nix develop
# or, even better:
direnv allow
```
Then, clone every project/discussion into this directory, and when you enter that directory, the dependencies from this flake will be used.

This works best with the `direnv` method, as you can have it integrate with the [Direnv VSCode Plugin](https://marketplace.visualstudio.com/items?itemName=mkhl.direnv) to automatically enter the dev-shell when you open the project in VSCode.

