
---
header-includes:
- |
  ```{=latex}
  \usepackage{tikz}

  ```
...


# PlantUML Test from diagram-generator

Here is a sequence diagram

```{.plantuml caption="This is an image, created by **PlantUML**."}
@startuml
Alice -> Bob: Authentication Request Bob --> Alice: Authentication Response
Alice -> Bob: Another authentication Request Alice <-- Bob: another Response
@enduml
```
