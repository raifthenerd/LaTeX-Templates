# README #

This is a repository for hosting personal LaTeX templates.

Mater branch only includes basic files such as manuals, setting files, etc. To use the template, checkout to one of these branches:

- article
- beamer
- cv

Every template has corresponding branches for demo. Simply put `demo-` before the template branch

To compile the template, type the command in terminal.

```
#!bash

latexmk -xelatex _main && latexmk -c
```
