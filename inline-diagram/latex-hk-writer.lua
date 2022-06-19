--New style writers, available since pandoc 2.17.2
PANDOC_VERSION:must_be_at_least '2.17.2'

local List = require 'pandoc.List'
local pipe = pandoc.pipe

function Writer (doc, opts)
  local plantuml_path='/usr/local/bin/plantuml'

  local filter = {
    CodeBlock = function (block)
      local rawcode
      -- only modify if code bloc have right class
      -- TODO: make a table of function
      if block.classes:includes('tikz') then
        rawcode = block.text
      elseif block.classes:includes('plantuml') then
        rawcode = pipe(plantuml_path,
                      {'-tlatex:nopreamble', '-pipe', '-charset', 'UTF-8'},
                      block.text)
      end

      if rawcode then
        rawcode = '\\begin{figure}\\centering' .. rawcode

        -- If the user defines a caption, read it as Markdown.
        if block.attributes.caption  then
          local caption = block.attributes.caption
          and pandoc.read(block.attributes.caption).blocks
          or {}

          rawcode = rawcode .. '\\caption{'
                    .. pandoc.write(pandoc.Pandoc(caption), 'latex')
                    .. '}'
        end

        rawcode = rawcode .. '\\end{figure}'

        return pandoc.RawBlock('latex', rawcode)
      end
    end
  }
  -- write with the default writer
  return pandoc.write(doc:walk(filter), 'latex', opts)
end
