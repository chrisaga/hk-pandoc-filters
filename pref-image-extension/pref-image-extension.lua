--[[
pref-image-extension
            When image exists in different format (identified by file extension)
	    use the prefered one depending on the output document format.
	    File extension of the included image can be empty.
	    If not, and a prefered format exists for the image, it will be used.

Copyright:  © 2021 Christophe Agathon <christophe.agathon@gmail.com>
License:    MIT – see LICENSE file for details

Output:	    latex, pdf, html

TODO:	   - latex output : consider forcing extension to be empty since latex
       has it's own prefered image format mechanysm.
	   - get list of prefered extension in metadata to override hardcoded
	     defaults.

Limitations :
           - don't know how to get resource-path, if defined
		(not in environment; in some metadata?)
	   - no way to prevent extension replacement for a particular image if a
	     prefered one exists.
--]]
-- Module pandoc.path is required and was added in version 2.12
PANDOC_VERSION:must_be_at_least '2.12'

local List = require 'pandoc.List'
local path = require 'pandoc.path'
local template = require 'pandoc.template'
--local system = require 'pandoc.system'

local vars = {}

function get_vars(meta)
  vars.empty = meta['emptyimageext']
  --print(vars.sourcefile)

end

--[[function tobo(doc)
  local tplate=template.compile('tobo $curdir$ $sourcefile$ $outputfile$ tobo')
  local txt = pandoc.write(doc, 'plain', {template=tplate})
  print(txt)
  return nil
end]]

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function Image(image)
  local path, ext = path.split_extension(image.src)
  --[[
  -- if extension exists do nothing
  if ext ~= '' then return nil end
  --]]

  local pref_ext
  if FORMAT:match 'latex' then
    pref_ext = { 'pdf'; 'png'; 'jpg'; 'jpeg' }
  elseif FORMAT:match 'html' then
    pref_ext = { 'svg'; 'jpg'; 'jpeg'; 'png' }
  end
  -- chose 'best' extension
  if not pref_ext then
    return nil
  end
  for _,ext in pairs(pref_ext) do
    if file_exists(path .. '.' .. ext) then
      image.src = path .. '.' .. ext
      return image
    else  -- if image doesn't exist yet, let LaTeX chose latter
      if FORMAT:match 'latex' then
        image.src = path
        return image
      end
    end
  end
end

return {{Meta = get_vars}, {Image = Image}}
