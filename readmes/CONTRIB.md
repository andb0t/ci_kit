# CONTRIBUTION

This is a short guideline for efficient collaboration on the codebase.


### Git Repository
* branches
  * the `master` branch is used for tested and production ready code
  * the `staging` branch is used for testing code about to go to production
  * the `develop` branch is used for development and is the default branch
  * issue solution should be done on feature branches, using a `WIP: `-preceded merge request with a link to the issue they correspond to
* merge requests
  * all merge requests must be done with respect to the default branch
  * all merge conflicts must be solved by the creator prior to review
  * the CI must run without failure prior to review
  * removing the `WIP: ` tag indicates readiness for review
  * feature branches should be deleted after the merge request is approved


### Coding style
A unified coding style is necessary to ensure readability across the codebase and keep git diffs relevant and minimal. The following are the conventions. The ticked requirements are tested by the githooks and pipelines in this repository:
* security
  * [ ] secrets must not be committed
  * [ ] customer data must not be committed
  * [x] jupyter workbooks have to be emptied before committing to keep analysis results private and diffs practical
* language style
  * [ ] python style as requested by `pylint` and defined in `.pylintrc`. This follows the [python PEP8 standard](https://www.python.org/dev/peps/pep-0008/).
  * [x] shell script style as requested by `shellcheck`.
* lines
  * [x] all files have to end with a newline ([POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206)). This avoids problems for some programs with the last line. An example for different behavior is `cat`.
  * [x] lines should not end with trailing whitespaces to make diffs uniform
  * [x] line endings must be UNIX-style, i.e. LF and not windows CRLF. Failure to do this can result in script execution problems in Linux containers and large unnecessary diffs
* commit messages
  * [x] should start with a capital letter
  * [ ] should start with a verb in imperative form (e.g. "Fix parsing error")
  * [x] should be short and concise

Most of the above can and should be configured to run automatically in every modern text editor or IDE.
