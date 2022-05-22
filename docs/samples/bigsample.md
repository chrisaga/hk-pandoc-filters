
~~~~ {.markdown}
---
title : What can you expect ? »
author : Christophe Agathon
papersize: a4
numbersections : true
header-includes:
    - |
      ```{=latex}
      \usepackage{lipsum}
      \usepackage{multicol}

      ```
---

:::::::::::: {.multicols column-count="2"}
# First

\lipsum[1][1-5]

# Second

\lipsum[1-2][6-15]

# Third

\lipsum[3][1-3]

::::::::::::

# Fourth

\lipsum[4]

:::::::::::: {.multicols column-count="2"}
:::::::: {.columns}
:::: {.column width="20%" valign="c"}
![](picto.png){#id .class width=90%}
::::
:::: {.column width="80%" valign="c" color="blue"}
**Module 1:**

\lipsum[5][1-3]

:::
::::::::

:::::::: {.columns }
:::: {.column width="80%" background-color="red"}
**Module 2:**

\lipsum[5][4-6]

::::
:::: {.column width="20%"}
![](picto.png){#id .class width=90%}
::::
::::::::

:::::::: {.columns }
:::: {.column width="20%"}
![](picto.png){#id .class width=90%}
::::
:::: {.column width="80%" color="blue" background-color="red"}

**Module 3:**

\lipsum[5][7-9]

::::
::::::::

:::::::: {.columns }
:::: {.column width="80%"}
**Module 4:**

\lipsum[5][10-15]

::::
:::: {.column width="20%"}
![](picto.png){#id .class width=90%}
::::
::::::::

:::::::: {.columns }
:::: {.column width="20%"}
![](picto.png){#id .class width=90%}
::::
:::: {.column width="80%"}

**Module 5:**

\lipsum[5][15-18]

::::
::::::::

:::::::: {.columns }
:::: {.column width="80%"}
**Module 6:**

\lipsum[5][19-24]

::::
:::: {.column width="20%"}
![](picto.png){#id .class width=90%}
::::
::::::::

:::::::: {.columns }
:::: {.column width="29%"}
**
\lipsum[7][1-4]
**
::::
:::: {.column width="70%"}

**Module 7:**

\lipsum[6][1-5]

::::
::::::::

:::::::: {.columns }
:::: {.column width="80%"}
**Module 8:**

\lipsum[6][5-7]

::::
:::: {.column width="20%"}
![](picto.png){#id .class width=90%}
::::
::::::::

:::::::: {.columns }
:::: {.column width="20%"}
![](picto.png){#id .class width=90%}
::::
:::: {.column width="80%"}

**Module 9:**

\lipsum[6][7-10]

::::
::::::::
::::::::::::
~~~~
