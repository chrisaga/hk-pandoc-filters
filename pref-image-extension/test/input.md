---
title: pref-image-extension lua filter test file
author: Christophe Agathon

---

# Image filename with extension

Extension will be changed based on the output document format and
the image files available.

![Image](image.jpg)

# Image filename without extension

An extension will be choosen based on the output document format
and the image files available.

![Image 2](image2)

# Image not available (yet)

Do nothing unless output format is latex. We rely on LaTeX's
future choice by stripping the extension.

![Image 3](image3.png)
