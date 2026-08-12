# Writing Markdown in Neovim

This Neovim configuration uses LazyVim's Markdown extra for language support,
rendering, and previews, with comfortable defaults for long-form writing.

Automatic word-completion suggestions are disabled in Markdown buffers so they
do not interrupt prose writing. Completion remains available in programming
language files.

`<leader>` is the Space key. For example, `<leader>mp` means press Space, then
`m`, then `p`.

## Everyday workflow

1. Open a document with `nvim document.md`.
2. Press `i` to write and `jj` to return to normal mode.
3. Press `<leader>mr` to switch between source and rendered Markdown.
4. Press `<leader>mp` for a live preview in the browser, or `<leader>mm` to open
   the file in Marked 2.
5. Use `]s` and `[s` to visit spelling mistakes and `z=` for suggestions.
6. Save with `Ctrl-s` and quit with `<leader>qq`.

## Markdown commands

| Keys | Action |
| --- | --- |
| `<leader>mr` | Toggle rendered Markdown inside Neovim |
| `<leader>mp` | Toggle live browser preview |
| `<leader>mm` | Open the current saved file in Marked 2 |
| `<leader>mz` | Toggle distraction-free Zen mode |
| `<leader>ms` | Toggle spell checking |
| `<leader>mw` | Toggle visual line wrapping |
| `<leader>mq` | Hard-wrap the current paragraph at 80 columns |
| `<leader>mf` | Toggle the fold under the cursor |
| `<leader>mc` | Close all folds |
| `<leader>mo` | Open all folds |

LazyVim's original Markdown keys remain available:

| Keys | Action |
| --- | --- |
| `<leader>um` | Toggle rendered Markdown |
| `<leader>cp` | Toggle browser preview |

## Writing and movement

These are standard Vim commands and work in other file types too.

| Keys | Action |
| --- | --- |
| `i` / `a` | Insert before/after the cursor |
| `o` / `O` | Add a line below/above |
| `jj` | Leave insert mode |
| `w` / `b` | Move forward/backward by word |
| `}` / `{` | Move to the next/previous paragraph |
| `0` / `^` / `$` | Start/first text/end of line |
| `gg` / `G` | Start/end of document |
| `Ctrl-d` / `Ctrl-u` | Move down/up half a screen |
| `*` / `#` | Find the next/previous occurrence of the word under the cursor |
| `u` / `Ctrl-r` | Undo/redo |
| `yy` / `p` | Copy a line/paste it |
| `dd` | Delete a line |
| `ciw` | Replace the word under the cursor |
| `gqap` | Hard-wrap the current paragraph at 80 columns |

## Bold, italics, and surrounding text

The surround plugin wraps a word, a movement, or a visual selection. Its basic
command is `gsa`, followed by what to wrap and the surrounding style.

| Keys | Action |
| --- | --- |
| `gsaiwb` | Make the word under the cursor `**bold**` |
| `gsaiwi` | Make the word under the cursor `*italic*` |
| `gsapb` | Make the current paragraph bold |
| `gsapi` | Make the current paragraph italic |
| Select text, then `gsab` | Make the selection bold |
| Select text, then `gsai` | Make the selection italic |

The command reads compositionally: `gsa` means “add surrounding,” `iw` means
“inner word,” `ap` means “a paragraph,” and the final `b` or `i` chooses bold or
italic Markdown. Other built-in surroundings work too, such as `"`, `'`, `)`,
`]`, and `}`.

| Keys | Action |
| --- | --- |
| `gsdb` / `gsdi` | Remove bold/italic markers around the cursor |
| `gsr` followed by old and new characters | Replace surrounding text |
| `gsh` followed by a character | Highlight the matching surroundings |

## Editing lists

Pressing Enter after a Markdown list item continues with the same bullet or
number. Press Enter on an empty item to finish the list. The explicit commands
below also understand unordered, ordered, and task-list markers.

| Keys | Action |
| --- | --- |
| `Enter` | Continue the current list while inserting text |
| `<leader>ma` | Add a matching list item above |
| `<leader>mn` | Add a matching list item below |
| `<leader>mk` / `<leader>mj` | Move the current item up/down |
| `<leader>mh` / `<leader>ml` | Dedent/indent the current item |
| `<leader>mx` | Toggle a task-list checkbox |
| `<leader>m#` | Renumber ordered lists |

To move or indent an item with nested content, select all its lines first and
use the same movement or indentation command. The mappings retain the visual
selection so they can be repeated.

## Folding long documents

Markdown headings form a hierarchy of folds. Documents initially open fully
expanded, and the fold column at the left indicates foldable sections.

| Keys | Action |
| --- | --- |
| `za` | Toggle the fold under the cursor |
| `zc` / `zo` | Close/open one fold |
| `zC` / `zO` | Close/open a fold recursively |
| `zM` / `zR` | Close/open every fold |
| `zj` / `zk` | Move to the next/previous fold |
| `[z` / `]z` | Move to the start/end of the current fold |

## Spelling

Spell checking is enabled for Markdown using British and American English.

| Keys | Action |
| --- | --- |
| `]s` / `[s` | Next/previous spelling mistake |
| `z=` | Show replacement suggestions |
| `zg` | Add the word under the cursor to the personal dictionary |
| `zw` | Mark the word under the cursor as incorrect |

## Searching and navigation

| Keys | Action |
| --- | --- |
| `<leader><space>` | Find a file |
| `<leader>/` | Search text across the project |
| `<leader>sg` | Search text across the project |
| `<leader>sb` | Search lines in the current document |
| `<leader>ss` | List document headings and symbols |
| `gd` | Follow a link or go to its definition when language support is active |
| `Ctrl-o` / `Ctrl-i` | Move backward/forward through jump history |

The `Space j` alternatives avoid the awkward `[` and `]` prefixes on
Scandinavian keyboards. Lowercase moves forward; uppercase moves backward.

| Keys | Action |
| --- | --- |
| `<leader>jd` / `<leader>jD` | Next/previous diagnostic |
| `<leader>js` / `<leader>jS` | Next/previous spelling mistake |
| `<leader>jf` / `<leader>jF` | Next/previous fold |
| `<leader>jq` / `<leader>jQ` | Next/previous quickfix item |
| `<leader>jl` / `<leader>jL` | Next/previous location-list item |

## Diagnostics and formatting

Marksman supplies Markdown navigation and structural diagnostics, while
`markdown-toc` maintains a table of contents when the document contains a
`<!-- toc -->` marker. Style linting with `markdownlint-cli2` and document
formatting with Prettier are deliberately disabled so that they do not conflict
with the external document toolchain. Paragraph reflow uses Neovim's built-in
`gq` formatter instead.

| Keys | Action |
| --- | --- |
| `<leader>cd` | Show the diagnostic on the current line |
| `]d` / `[d` | Move to the next/previous diagnostic |
| `<leader>xx` | Open the diagnostics list |
| `<leader>mq` or `gqap` | Format the current paragraph |

## Discovering commands

Pause after pressing Space to see the WhichKey menu. `<leader>m` contains the
writing commands. To search every active key binding, use `<leader>sk`.

## Reloading the configuration

For changes to ordinary keymaps, reload the file without restarting Neovim:

```vim
:luafile ~/.config/nvim/lua/config/keymaps.lua
```

The Markdown buffer settings can be reloaded in the same way, then reapplied to
the current document with `:doautocmd FileType markdown`:

```vim
:luafile ~/.config/nvim/lua/config/autocmds.lua
:doautocmd FileType markdown
```

Restart Neovim after changing `lazyvim.json`, plugin specifications, or the
LazyVim bootstrap configuration. Re-sourcing `init.lua` can initialize plugin
managers twice and is therefore not recommended.
