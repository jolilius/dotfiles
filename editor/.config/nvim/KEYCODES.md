# Neovim Markdown Keycodes

`<leader>` means the Space key.

## Markdown writing

| Keys | Action |
| --- | --- |
| `<leader>mr` | Toggle rendered Markdown |
| `<leader>mp` | Toggle browser preview |
| `<leader>mm` | Open document in Marked 2 |
| `<leader>mz` | Toggle Zen mode |
| `<leader>ms` | Toggle spell checking |
| `<leader>mw` | Toggle visual line wrapping |
| `<leader>mq` | Hard-wrap current paragraph at 80 columns |
| `gqap` | Format the current paragraph |

## Lists (`markdown.nvim`)

| Keys | Action |
| --- | --- |
| Insert mode, `Enter` | Split/continue the list item at the cursor |
| `<leader>ma` | Add list item above |
| `<leader>mn` | Add list item below |
| `<leader>mx` | Toggle task checkbox |
| `<leader>m#` | Renumber ordered list |
| `<leader>mh` | Dedent list item |
| `<leader>ml` | Indent list item |
| `<leader>mk` | Move list item up |
| `<leader>mj` | Move list item down |

Most list commands also work on a visual selection.

## Bold and italics (`mini.surround`)

In normal mode, the pattern is `gsa` + movement/text object + style. Use `b`
for bold and `i` for italic.

| Keys | Action |
| --- | --- |
| `gsaiwb` | Make the current word bold |
| `gsaiwi` | Make the current word italic |
| `gsapb` | Make the current paragraph bold |
| `gsapi` | Make the current paragraph italic |
| Select text, then `gsab` | Make the selection bold |
| Select text, then `gsai` | Make the selection italic |

## Folding

| Keys | Action |
| --- | --- |
| `za` | Toggle the fold under the cursor |
| `zc` / `zo` | Close/open one fold |
| `zC` / `zO` | Close/open a fold recursively |
| `zM` / `zR` | Close/open every fold |
| `zj` / `zk` | Jump to next/previous fold |
| `<leader>jf` | Jump to next fold |
| `<leader>jF` | Jump to previous fold |

## Scandinavian-keyboard alternatives

| Keys | Action |
| --- | --- |
| `<leader>jd` / `<leader>jD` | Next/previous diagnostic |
| `<leader>js` / `<leader>jS` | Next/previous spelling mistake |
| `<leader>jf` / `<leader>jF` | Next/previous fold |
| `<leader>jq` / `<leader>jQ` | Next/previous quickfix result |
| `<leader>jl` / `<leader>jL` | Next/previous location-list result |

## Search and replace

| Command | Action |
| --- | --- |
| `/text` then `Enter` | Search forward |
| `?text` then `Enter` | Search backward |
| `n` | Continue in the last search direction |
| `N` | Search in the opposite direction |
| `:%s/old/new/g` | Replace throughout the file |
| `:%s/old/new/gc` | Replace throughout the file with confirmation |
| `:s/old/new/g` | Replace on the current line |
| Select lines, then `:s/old/new/g` | Replace within the selection |

## Reload configuration

| Command | Action |
| --- | --- |
| `:source %` | Reload the Lua configuration file currently being viewed |
| Restart Neovim | Apply plugin additions or broad configuration changes |
