 --[[
tables-vrules - adds vertical rules to tables for latex output

Copyright:  © 2021 Christophe Agathon <christophe.agathon@gmail.com>

License:    MIT – see LICENSE file for details

Credits:    marijnschraagen for the original Latex hack

Output:     latex, pdf.

Usage:      See README.md for details

--]]
local List = require 'pandoc.List'

local vars = {}

-- Get vars from metadata
function get_vars (meta)
  vars.vrules = meta['tables-vrules']
  vars.hrules = meta['tables-hrules']
end

function repl_midrules(m1, m2)
  if m2:match('^\\[%w]+rule') then
    -- don't double the rule
    return m1 .. m2
  else
    return m1 .. '\\midrule\n' .. m2
  end
end

-- Fix individual column definition :
--  add right vertical rule
--  adjust width for column separtion and rule width
function fix_coldef(m1, m2)
  --- At some point (pandoc v3.4 or before) \columnwidth became \linewidth
  n=m2:match('%(\\columnwidth %- ([%d%.]+)\\tabcolsep%)')
  if not n then
    n=m2:match('%(\\linewidth %- ([%d%.]+)\\tabcolsep%)')
  end 

  return m1:gsub('[%d%.]+(\\tabcolsep)',
                 string.format('%d',n+2) .. '%1 - ' ..
                 string.format('%d',2+n/2) ..'\\arrayrulewidth') .. '|'
end

-- Fix "simple style" column definition
function fix_simplestyle(m1,m2,m3)
  return m1 .. m2:gsub('(.)','%1|') .. m3
end

-- Fix columns definitions for vertical rules
function fix_colsdefs(m)
  --return m:gsub('^{@{}', '{@{\\extracolsep{-\\arrayrulewidth}}|')
  --        :gsub('@{}}$', '}')
  return m:gsub('^{@{}', '{|')
          :gsub('@{}}$', '}')
          :gsub('(>%b{}%l(%b{}))', fix_coldef) -- rich style
          :gsub('({|)(%l+)(})', fix_simplestyle) -- simple style
end

-- Adjust minipage width for column separators
-- Substract \tabcolsep two times (left and rigth of the cell)
-- Minipages in one column cell don't need that since the \linewidth is OK
-- TODO: not needed anymore since pandoc 3.1.9
function adjust_minipage(m1, m2, m3)
  return m1 .. m2:gsub('}', ' - 2\\tabcolsep -2\\arrayrulewidth}')
            .. m3
end

-- Adjust width of p cell for column separators
-- Substract \tabcolsep two times (left and rigth of the cell)
-- Generated LaTeX is not optimized, but robust
function adjust_p(m1, m2)
  return m1 .. m2:gsub('}$', ' -2\\tabcolsep -2\\arrayrulewidth}')
end

-- Give some space to minipages between text and horizontal rule
function pad_minipage(m1, m2, m3)
  return m1 .. m2 .. '\\smallskip\n' .. m3
end

-- Fix multicolumn cells
-- '|' where pandoc suppressed the colsep (@{})
-- plus on the right of each one (avoiding '||')
function fix_multicol(command, coldef, content)
  return command .. coldef:gsub('@%b{}','|'):gsub('|?}$','|}')
                          :gsub('(p)(%b{})', adjust_p)
         .. content
end

-- Main filter function
function Table(table)
  local returned_list
  local begin_env, env_content, end_env

  if not vars.vrules and not vars.hrules then return nil end

  if FORMAT:match 'latex' then

    -- Get latex code for the whole table
    begin_env, env_content, end_env =
       pandoc.write ( pandoc.Pandoc({table}),'latex' )
         :match('(\\begin{longtable}%b[]%b{})(.*)(\\end{longtable})')

    -- Rewrite column definition to add vertical rules if needed
    -- N.B. Pandoc suppresses left and right spacing with @{}
    if vars.vrules then
      -- Fix columns definitions in longtable environment
      begin_env = begin_env:gsub('(%b{})$', fix_colsdefs)
--print('#' .. begin_env ..'#')
      -- Fix multicol cells if any
      env_content=env_content:gsub('(\\multicolumn%b{})(%b{})(%b{})',
                                    fix_multicol)
    end

    -- Add \midrules after each row if needed
    if vars.hrules then
      env_content = env_content:gsub('( \\\\\n)([\\%w]+)', repl_midrules)
                   :gsub('(\\begin{minipage}%b[])(%b{})(.*\\end{minipage})',
                   pad_minipage)
--print('#' .. env_content ..'#')
    end

    -- Return modified latex code as a raw block
    --
    returned_list = List:new{pandoc.RawBlock('tex',
                               begin_env .. env_content .. end_env)}
  end
  return returned_list
end

function Meta(meta)
  -- We have to add this since Pandoc doesn't because there are no
  -- table anymore in the AST. We converted them in RawBlocks

  if not vars.vrules and not vars.hrules then return nil end
  includes = [[
%begin tables-vrules.lua
\usepackage{longtable,booktabs,array}
\usepackage{calc} % for calculating minipage widths
% Correct order of tables after \paragraph or \subparagraph
\usepackage{etoolbox}
\makeatletter
\patchcmd\longtable{\par}{\if@noskipsec\mbox{}\fi\par}{}{}
\makeatother
% Allow footnotes in longtable head/foot
\IfFileExists{footnotehyper.sty}{\usepackage{footnotehyper}}{\usepackage{footnote}}
\makesavenoteenv{longtable}
\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}
\renewcommand{\arraystretch}{1.3}
%end tables-vrules.lua
]]

  if meta['header-includes'] then
    table.insert(meta['header-includes'], pandoc.RawBlock('tex', includes))
  else
    meta['header-includes'] = List:new{pandoc.RawBlock('tex', includes)}
  end

  return meta
end

return {{Meta = get_vars}, {Table = Table}, {Meta = Meta}}
