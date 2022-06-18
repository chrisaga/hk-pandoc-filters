HK Pandoc Filters
==================================================================

[![GitHub build status][CI badge]][CI workflow]

This repository hosts some [Lua filters][] I wrote for [Pandoc][], the universal document converter. Those filters are used to customize the way documents are converted from one format to another.

This repository is initially based on tarleb's (Albert Krewinkel) [lua-filter-template][] on github. As I decided to hos multiple filter in one repository, I adapted the structure to have one directory per filter. Docs, tests and Makefiles still need to be adapted.

I you feel like developing your own filters, I strongly advise you to start with tarleb's template.

[Pandoc]: https://pandoc.org
[Lua filters]: https://pandoc.org/lua-filters.html
[lua-filter-template]: https://github.com/tarleb/lua-filter-template
[from template]: https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template
[CI badge]: https://img.shields.io/github/workflow/status/chrisaga/hk-pandoc-filters/CI?logo=github
[CI workflow]: https://github.com/chrisaga/hk-pandoc-filters/actions/workflows/ci.yaml

Use case
------------------------------------------------------------------

My main use case is to process Markdown files with [Pandoc][] to produce HTML and PDF documents with similar rendering. Plain Pandoc renders some document features in html not in pdf (or the other way around). I try to make HTML and PDF rendering the most looking alike possible.

Those filters can be used to process source file from multiple different formats . They are ineffective if output format is other than HTML, PDF, or LaTeX


List of filters
------------------------------------------------------------------

### column-div

With this filter you can make fancy page layout using columns and colors using only Pandoc's Markdown fenced divs and no html code.

[See details …](column-div/README.md)

### tables-rules

This filter answers to the old "I want my tables to have vertical rules" problem. Whether table should have vertical rules or not is a barb-wired topic (look online). The fact is that sometimes we need to render cells with vertical and horizontal rules.

All Markdown table formats supported by Pandoc are OK. HTML tables with multiple  column spanning cells are OK too.

[See details …](tables-rules/README.md)

### pref-image-extension

This filter choose the “best” file extension for an image referenced in the main document depending on the files which are available and on the output format. You can specify an extension or omit it all the way as in LaTeX source.


[See details …](pref-image-extension/README.md)

License
------------------------------------------------------------------

This pandoc Lua filter is published under the MIT license, see
file `LICENSE` for details.
