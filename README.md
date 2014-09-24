# README #

Repository for hosting personal LaTeX templates.

Master branch only includes basic files such as manuals, setting files, etc. To use the template, checkout to one of these branches:

- article
- beamer
- cv

This template uses [TeX Gyre Heros](http://www.tug.dk/FontCatalogue/tgheros/) and [DejaVu Sans Mono](http://dejavu-fonts.org/wiki/Main_Page).

이 템플릿은 [한글출판인회의](http://www.kopus.org/Default.aspx)의 KoPub바탕체와 KoPub돋음체를 사용합니다.

To compile the template, type the command in terminal.

```bash
latexmk -pvc -xelatex -interaction=nonstopmode _main && latexmk -c
```
