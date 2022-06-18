---
title: "Pref Image Extension - Pandoc lua filter to use \"best\" image file available"
author: "Christophe Agathon"
---

Pref Image Extension
=======

Choose the "best" image extension depending on image files which are available and on the output format

v1.0. Copyright: © 2022 Christophe Agathon
  <christophe.agathon@gmail.com>
License:  MIT - see LICENSE file for details.

Introduction
------------

As an author I want to produce multiple document format from the
same sources using the more appropriate image file available in
order to get the "best" result (image quality, document weight,
...).


Usage
-----

### Formating the document

Simply use normal image insertion synthax that Pandoc can process. 
**You can omit the file extension**

```markdown
![Image 2](media/image2)
```


### Rendering the document

Copy `pref-image-extension.lua` in your document folder or in your
pandoc data directory (details in
[Pandoc's manual](https://pandoc.org/MANUAL.html#option--lua-filter)).
Run it on your document with a `--luafilter` option:

```bash
pandoc --luafilter pref-image-extension.lua SOURCE.md -o OUTPUT.pdf

```

or specify it in a defaults file (details in
[Pandoc's manual](https://pandoc.org/MANUAL.html#option--defaults)).

The "best" image file extension will be used :

* html documents :
   * by order of preference : 'svg'; 'jpg'; 'jpeg'; 'png'
   * if no files are found with one of these extensions, the image
     file path is kept unchanged.
* latex and pdf documents :
   * by order of preference : 'pdf'; 'png'; 'jpg'; 'jpeg'
   * if no files are found with one of these extensions, the image
     file extension is stripped. We rely on LaTeX to choose one
if/when an image file will be available.

## Limitations

This filter is active only for LaTeX, PDF and HTML output. It does
nothing with other output document format.

The working directory where the `pandoc` command is invoked must
be the main document directory in order to process relative image
file paths.

Contributing
------------

PRs welcome.

