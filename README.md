# ci_kit

This repository provides baseline pipelines for language-agnostic CI test steps.

## Installation

### Git hooks
To allow an instantaneous sanity check of the code you are about to commit, use git hooks. They are code snippets triggering on git events. To install the hooks, call
```
./ci_kit/githooks/setup.sh --install  # if you have included ci_kit as git submodule
[YOUR_CI_KIT_PATH]/githooks/setup.sh --install  # if you have cloned ci_kit to another path on your machine
```
The option `--remove` resets the git hooks to the default.

## Contribution
Since CI syntax will continue being updated frequently, the git hosting service specific files are expected to outdate relatively quickly. Contributions to fix them and adapt them to the newest changes & standards are very welcome!
