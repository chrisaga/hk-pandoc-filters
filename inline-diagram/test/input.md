
---
header-includes:
- |
  ```{=latex}
  \usepackage{tikz}

  ```
...


# Ti*k*Z Test from pandoc example

Here is a diagram of the cycle:

```{.tikz caption="This is an image, created by **TikZ i.e. LaTeX**."
     additionalPackages="\usepackage{adjustbox}"}
\def \n {5}
\def \radius {3cm}
\def \margin {8} % margin in angles, depends on the radius

\foreach \s in {1,...,\n}
{
  \node[draw, circle] at ({360/\n * (\s - 1)}:\radius) {$\s$};
  \draw[->, >=latex] ({360/\n * (\s - 1)+\margin}:\radius)
    arc ({360/\n * (\s - 1)+\margin}:{360/\n * (\s)-\margin}:\radius);
}
```

# PlantUML Test from diagram-generator

Here is a sequence diagram

```{.plantuml caption="This is an image, created by **PlantUML**."}
@startuml
Alice -> Bob: Authentication Request Bob --> Alice: Authentication Response
Alice -> Bob: Another authentication Request Alice <-- Bob: another Response
@enduml
```
