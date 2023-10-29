
---
header-includes:
- |
  ```{=latex}
  \usepackage{tikz}

  ```
...


# Test from pandoc example

Here is a diagram of the cycle:

```{.tikz caption="This is an image, created by **TikZ i.e. LaTeX**."
     additionalPackages="\usepackage{adjustbox}"}
\begin{tikzpicture}

\def \n {5}
\def \radius {3cm}
\def \margin {8} % margin in angles, depends on the radius

\foreach \s in {1,...,\n}
{
  \node[draw, circle] at ({360/\n * (\s - 1)}:\radius) {$\s$};
  \draw[->, >=latex] ({360/\n * (\s - 1)+\margin}:\radius)
    arc ({360/\n * (\s - 1)+\margin}:{360/\n * (\s)-\margin}:\radius);
}
\end{tikzpicture}
```
