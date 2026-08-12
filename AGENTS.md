# Repository Guidelines

This repository manages the user's dotfiles with GNU Stow. Preserve the existing setup and conventions unless a task explicitly calls for a migration.

## Stow layout

- Each top-level package mirrors paths relative to the user's home directory (`~`).
- Current packages are `shell`, `editor`, `git`, `tools`, `terminal`, `bin`, `homebrew`, and the macOS-only `launchd`.
- Put a file at the exact path it should have below `~`. For example, `tools/.config/starship.toml` installs as `~/.config/starship.toml`, while `bin/bin/qmd-refresh` installs as `~/bin/qmd-refresh`.
- Do not place managed dotfiles directly in the repository root. Root-level files such as `README.md`, `AGENTS.md`, and `install.sh` are repository infrastructure, not Stow payloads.
- Prefer an existing package with matching responsibility. Add a new package only when it has a clear, independently installable purpose.
- Avoid overlapping ownership: two packages must not install the same target path.
- Preserve relative symlink compatibility. Do not introduce absolute paths tied to one clone location or machine.

## Making changes

- Inspect the relevant package and nearby configuration before editing; follow its established style and platform guards.
- Keep macOS-specific configuration in `launchd` or behind an explicit macOS check. Keep cross-platform packages usable on both macOS and Linux where practical.
- Never commit secrets, API tokens, SSH keys, machine credentials, generated caches, histories, or runtime databases.
- Treat `homebrew/.config/homebrew/Brewfile` as the source of truth for Homebrew dependencies.
- If adding or removing a package, update both `install.sh` and `README.md`.
- Preserve unrelated working-tree changes. Do not overwrite or reformat files outside the requested scope.

## Validation

- For Stow layout changes, validate from the repository root with a dry run against the intended target:

  ```sh
  stow --simulate --verbose --dir "$PWD" --target "$HOME" <package>
  ```

- A conflict with an existing non-Stow file in the user's home directory is significant; report it rather than deleting or adopting the file automatically.
- When useful, test package structure against an empty temporary target to distinguish layout errors from local-home conflicts:

  ```sh
  target="$(mktemp -d)"
  stow --simulate --verbose --dir "$PWD" --target "$target" <package>
  ```

- Run syntax or configuration checks appropriate to edited files (for example, `bash -n install.sh` or a tool's native config validator).
- Do not run `./install.sh` as a routine validation step. It installs dependencies, changes global tooling, creates home-directory links, and may reload LaunchAgents. Run it only when the user explicitly requests installation or an end-to-end setup test.

## Installation behavior

- `install.sh` stows cross-platform packages into `~` and adds `launchd` only on macOS.
- Installation should remain repeatable and fail clearly on genuine Stow conflicts.
- Destructive unstowing, deleting target files, adopting existing files (`stow --adopt`), package installation, and service reloads require explicit task scope and careful review.
