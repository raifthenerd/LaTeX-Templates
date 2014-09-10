# README #

Repository for hosting personal LaTeX templates.

Master branch only includes basic files such as manuals, setting files, etc. To use the template, checkout to one of these branches:

- article
- beamer
- cv

이 템플릿으로 한글문서를 작성하고자 하는 경우에는 [한글출판인회의](http://www.kopus.org/Default.aspx)의 KoPub바탕체와 KoPub돋음체가 필요합니다.  [여기서](http://www.kopus.org/Biz/electronic/Font.aspx) 다운로드 받을 수 있습니다.

To compile the template, type the command in terminal.

```bash
latexmk -xelatex _main && latexmk -c
```
