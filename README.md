# CI Kit

This repository provides baseline pipelines for language-agnostic CI test steps.


## Content
The included scripts check
* commit message format
* code format
* file content
* customizable blacklist
A subset of them is called by the default pipelines. Pick and chose!

Supporting CI templates for
- [x] GITLAB
- [x] GITHUB
- [ ] BITBUCKET
- [ ] AZUREDEVOPS

## Installation
There are two modes of installation:
1. add `ci_kit` as submodule.

    This is the recommended way of installation because it makes udpates easy and avoids duplication of code if you use `ci_kit` in several projects. If you need customizations, fork this repo and add your fork as submodule. `[THIS_REPO_URL]` has to use HTTPS, not SSH.
    ```bash
    git submodule add [THIS_REPO_URL]
    ```
2. clone `ci_kit` to any path on your machine `[YOUR_CI_KIT_PATH]`

    Using this option, you will be able to chose and select more, which scripts you need which you don't. Copying them to your repo is made easy with the provided `setup.sh` scripts.
    ```bash
    git clone [THIS_REPO_URL]
    ```

### CI steps
To install a basic pipeline file, calling some basic scripts to check the sanity of your code, execute e.g.
```bash
[YOUR_CI_KIT_PATH]/setup_ci.sh GITLAB  # other options are GITHUB, AZUREDEVOPS, BITBUCKET
```

### Git hooks
To allow an instantaneous sanity check of the code you are about to commit, use git hooks. They are code snippets triggering on git events, such as committing or pushing. To install the hooks, call
```
./ci_kit/githooks/setup.sh --install  # if you have included ci_kit as git submodule
[YOUR_CI_KIT_PATH]/githooks/setup.sh --install  # if you have cloned ci_kit to another path on your machine
```
The option `--remove` resets the git hooks to the default.

## Contribution
Since CI syntax will continue being updated frequently, the git hosting service specific files are expected to outdate relatively quickly. Contributions to fix them and adapt them to the newest changes & standards are very welcome!
