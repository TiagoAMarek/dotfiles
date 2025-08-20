# -- tmux Cheatsheet: Essential Commands & Custom Keybindings --

This cheatsheet summarizes tmux commands, custom keybindings, plugin management, and settings from your actual tmux.conf. Use it for onboarding and quick reference.

---

# -- General Settings --

- **Prefix key:** Ctrl-b (default)
- **True color:** Enabled (tmux-24bit, xterm overrides)
- **Mouse support:** Enabled for scrolling, selection, resizing
- **Window/pane numbering:** Starts at 1
- **Automatic window renaming:** On
- **History limit:** 50,000 lines
- **Escape time:** 0 (fast responsiveness)
- **Focus events:** Enabled
- **Status bar position:** Top

---

# -- Session Management --

- **Start tmux:**  
  `tmux`  
  _Start a new tmux session._

- **List sessions:**  
  `tmux ls`  
  _Show all active tmux sessions._
  
  `Alt-q` (M-q)  
  _List sessions interactively._

- **Attach to session:**  
  `tmux attach -t <session-name>`  
  _Attach to an existing session._

- **Detach from session:**  
  `Prefix + d`  
  _Detach from the current session._

- **Rename session:**  
  `tmux rename-session -t <old-name> <new-name>`  
  _Rename a session._

- **Kill session:**  
  `tmux kill-session -t <session-name>`  
  _Terminate a session._

- **Switch session (fzf popup):**  
  `Prefix + Ctrl-b`  
  _Open popup to switch sessions using fzf._

- **Create new session (popup):**  
  `Prefix + Ctrl-n`  
  _Open popup to create a new session with name prompt._

---

# -- Window Management --

- **Create new window:**  
  `Prefix + c`  
  _Create a new window._

- **List windows:**  
  `Prefix + w`  
  _List all windows in the current session._
  
  `Alt-w` (M-w)  
  _List windows interactively._

- **Switch window:**  
  `Prefix + <number>`  
  _Switch to window by number._

- **Rename window:**  
  `Prefix + ,`  
  _Rename the current window._

- **Close window:**  
  `Prefix + &`  
  _Kill the current window._

---

# -- Pane Management --

- **Split pane vertically:**  
  `Prefix + |`  
  _Split vertically, keep current path._

- **Split pane horizontally:**  
  `Prefix + \`  
  _Split horizontally, keep current path._

- **Unbound default splits:**  
  `"` and `%` are unbound (use custom splits above).

- **Pane navigation:**  
  _Handled by vim-tmux-navigator plugin (Vim-like navigation between tmux and Vim/Neovim splits)._

- **Resize pane (Vim-style):**  
  `Prefix + Shift-H` (left)
  `Prefix + Shift-J` (down)
  `Prefix + Shift-K` (up)
  `Prefix + Shift-L` (right)
  _Resize by 5 units._

- **Maximize/zoom pane:**  
  `Alt-Z` (M-Z)  
  _Toggle zoom for current pane._

- **Kill pane:**  
  `Prefix + x`  
  _Close the current pane._

---

# -- Configuration Reload & Server Control --

- **Reload config file:**  
  `tmux source-file ~/.config/tmux/tmux.conf`  
  _Reload tmux configuration from file._

- **Reload config (shortcut):**  
  `Prefix + r`  
  _Reload config and display "Config reloaded!" message._

- **Kill tmux server:**  
  `tmux kill-server`  
  _Terminate all tmux sessions and server._

---

# -- Plugin Management (TPM) --

- **TPM install:**  
  `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

- **Initialize TPM:**  
  `run '~/.tmux/plugins/tpm/tpm'` (last line in config)

- **Install plugins:**  
  `Prefix + I`  
  _Install all plugins listed in config._

- **Update plugins:**  
  `Prefix + U`  
  _Update all plugins._

- **Remove unused plugins:**  
  `Prefix + Alt + u`  
  _Remove plugins not listed in config._

- **Recommended plugins (from your config):**
  - tmux-plugins/tpm
  - tmux-plugins/tmux-sensible
  - tmux-plugins/tmux-resurrect
  - tmux-plugins/tmux-continuum
  - tmux-plugins/tmux-yank
  - niksingh710/minimal-tmux-status
  - tmux-plugins/tmux-battery
  - tmux-plugins/tmux-cpu
  - christoomey/vim-tmux-navigator
  - catppuccin theme (run line)

- **Resurrect/Continuum settings:**
  - `@resurrect-capture-pane-contents on` (restore pane contents)
  - `@continuum-restore on` (auto-restore last session)

---

# -- Troubleshooting & Tips --

- **Display messages:**  
  Use `display-message` or `display` in config to show status after reloads or actions.

- **Check for duplicate/conflicting keybindings:**  
  Review `.tmux.conf` for overlapping shortcuts.

- **Mouse support:**  
  Enabled by default. If issues, check:  
  `set -g mouse on`

- **True color support:**  
  Terminal set to `tmux-24bit` and xterm overrides for modern terminals.

- **Plugin issues:**  
  - Verify TPM is installed and plugins are listed correctly.
  - Reload config after any plugin changes.
  - Use `Prefix + I` to reinstall plugins if needed.

---

_Refer to `.tmux.conf` and AGENTS.md for further details and customization guidelines._
