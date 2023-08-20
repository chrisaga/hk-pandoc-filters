--New style writers, available since pandoc 2.17.2
PANDOC_VERSION:must_be_at_least '2.17.2'

local List = require 'pandoc.List'
local pipe = pandoc.pipe

function Writer (doc, opts)
  local plantuml_path='plantuml'

  local filter = {
    CodeBlock = function (block)
      local rawcode
      -- only modify if code bloc have right class
      -- TODO: make a table of function
      if block.classes:includes('tikz') then
        rawcode = '\\begin{tikzpicture}' .. block.text ..'\\end{tikzpicture}'
	-- TODO: don't add environment if already in code for backward comp
      elseif block.classes:includes('plantuml') then
        rawcode = pipe(plantuml_path,
                      {'-tlatex:nopreamble', '-pipe', '-charset', 'UTF-8'},
                      block.text)
      end

      if rawcode then

        -- If the user defines a caption, read it as Markdown.
        if block.attributes.caption  then
          rawcode = '\\begin{figure}\\centering' .. rawcode
          local caption = block.attributes.caption
          and pandoc.read(block.attributes.caption).blocks
          or {}

          rawcode = rawcode .. '\\caption{'
                    .. pandoc.write(pandoc.Pandoc(caption), 'latex')
                    .. '}'
        rawcode = rawcode .. '\\end{figure}'
        end
        -- TODO: handle \usetikzlibrary as it was in the original filter

        return pandoc.RawBlock('latex', rawcode)
      end
    end
  }
  -- write with the default writer
  return pandoc.write(doc:walk(filter), 'latex', opts)
end
