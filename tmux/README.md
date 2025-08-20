# tmux Configuration

This folder contains a customized `tmux.conf` for enhancing your tmux experience. The configuration is designed for modern terminals, provides sensible defaults, and includes powerful plugins and shortcuts to boost productivity. Whether you're new to tmux or looking to upgrade your workflow, this README will guide you through the features and setup.

---

## Features & Customizations

### General Settings

- **Prefix Key:** Uses the default `Ctrl-b` (`C-b`) as the tmux command prefix.
- **True Color Support:** Enables 24-bit color for modern terminals (`tmux-24bit`), with overrides for compatibility.
- **Mouse Support:** Enables mouse for scrolling, pane selection, and resizing.
- **Automatic Window Renaming:** Windows are renamed based on the running process.
- **Numbering:** Windows and panes start at 1 (not 0) for easier navigation.
- **History Limit:** Stores up to 50,000 lines of scrollback history.
- **Fast Key Response:** Escape time set to 0 for snappy key handling (great for Vim/Neovim users).
- **Focus Events:** Enables focus events for better integration with editors like Neovim.
- **Status Bar:** Status bar is positioned at the top of the terminal.

### Keybindings

- **Reload Config:** `Prefix + r` reloads the tmux configuration and displays a confirmation.
- **Pane Splitting:**
  - `Prefix + |` splits pane horizontally (retains current path).
  - `Prefix + \` splits pane vertically (retains current path).
- **Pane Navigation:** Uses the `vim-tmux-navigator` plugin for seamless movement between tmux panes and Vim splits.
- **Pane Resizing:**
  - `Prefix + Shift + H/J/K/L` resizes panes in Vim directions by 5 cells.
- **Session & Window Management:**
  - `Alt + q` lists sessions.
  - `Alt + w` lists windows.
  - `Alt + Shift + Z` zooms the current pane.
- **Advanced Popups:**
  - `Prefix + C-b`: Fuzzy session switcher using fzf in a popup.
  - `Prefix + C-n`: Create a new session with a name prompt in a popup.

### Plugins

Managed via [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm):

- `tmux-plugins/tpm`: Plugin manager.
- `tmux-plugins/tmux-sensible`: Sensible default settings.
- `tmux-plugins/tmux-resurrect`: Save and restore tmux sessions.
- `tmux-plugins/tmux-continuum`: Automatic session saving/restoring.
- `tmux-plugins/tmux-yank`: Clipboard integration for macOS.
- `catppuccin/tmux`: Catppuccin theme for tmux.
- `niksingh710/minimal-tmux-status`: Minimal status bar.
- `tmux-plugins/tmux-battery`: Battery status in the status bar.
- `tmux-plugins/tmux-cpu`: CPU usage in the status bar.
- `christoomey/vim-tmux-navigator`: Seamless navigation between tmux and Vim.

#### Plugin Settings

- **Resurrect:** Restores pane contents (e.g., Vim sessions).
- **Continuum:** Automatically restores the last session on startup.

---

## Installation

1. **Install tmux**
   Make sure you have tmux installed.
   ```sh
   brew install tmux   # macOS
   sudo apt install tmux   # Ubuntu/Debian
   ```

2. **Clone TPM (Tmux Plugin Manager)**
   ```sh
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

3. **Copy the Configuration File**
   Place `tmux.conf` in your tmux config directory:
   ```sh
   mkdir -p ~/.config/tmux
   cp tmux.conf ~/.config/tmux/tmux.conf
   ```

4. **Start tmux**
   ```sh
   tmux
   ```

5. **Install Plugins**
   Inside tmux, press `Prefix + I` (that is, `Ctrl-b` then `Shift-i`) to install all plugins.

---

## Usage Tips

- **Reload Config:**
  If you edit `tmux.conf`, reload it with `Prefix + r`.

- **Session Management:**
  - Quickly switch sessions with `Prefix + s` (fzf popup).
  - Create new sessions with `Prefix + n` (popup prompt).

- **Pane Navigation:**
  Use Vim keys (`h`, `j`, `k`, `l`) to move between panes if you have the `vim-tmux-navigator` plugin and Vim/Neovim configured.

- **Resurrect & Continuum:**
  Your tmux environment is automatically saved and restored. To manually save, use `Prefix + Ctrl-s`. To restore, use `Prefix + Ctrl-r`.

- **Mouse Support:**
  You can click to select panes, resize, and scroll.

---

## Advanced Features

- **True Color:**
  Works best with terminals that support 24-bit color (e.g., iTerm2, Alacritty, Ghostty).

- **Fuzzy Session Switching:**
  The fzf popup lets you quickly switch between sessions without leaving tmux.

- **Minimal Status Bar:**
  The status bar is clean and informative, showing battery and CPU stats.

---

## Troubleshooting

- **Plugin Issues:**
  If plugins don't install, ensure TPM is cloned to `~/.tmux/plugins/tpm` and you pressed `Prefix + I` inside tmux.

- **True Color Problems:**
  The error message missing or unsuitable terminal: tmux-24bit means that your operating system's terminal database (terminfo) does not have a pre-installed definition for the tmux-24bit terminal type.

  When tmux starts, it needs this definition to know how to draw colors, move the cursor, and handle other visual tasks. We told tmux to identify as tmux-24bit to enable true color, but now we just need to teach your OS what that means.

  This single, self-contained command will create the definition and compile it into your system's `terminfo` database. Just copy the entire block and paste it into your terminal.

```bash
  tic -x - << 'EOF'
  # A 24-bit color terminfo for tmux.
  # See: https://github.com/tmux/tmux/blob/master/FAQ
  tmux-24bit|tmux with 24-bit color,
      use=screen-256color,
      use=xterm+256color,
      kbs=\177,
      sitm=\E[3m,
      ritm=\E[23m,
      smso=\E[7m,
      rmso=\E[27m,
      cr=\r,
      indn=\n,
      cub1=^H,
      khome=\E[1~,
      kend=\E[4~,
      setb24=\E[48;2;%p1%d;%p2%d;%p3%dm,
      setf24=\E[38;2;%p1%d;%p2%d;%p3%dm,
      Tc,
  EOF
```

### Next Steps

  After running the command, you need to completely restart the tmux server for it to recognize the new definition.

  1.  **Kill the tmux server:**

      ```bash
      tmux kill-server
      ```

  2.  **Start a new session:**

      ```bash
      tmux
      ```

  The "missing or unsuitable terminal" error will now be resolved permanently.

  -----

### Alternative: The `tmux.conf` Method

  As a reminder, the alternative solution (which avoids modifying `terminfo`) is still valid if you prefer it.

  1.  Edit `~/.config/tmux/tmux.conf`.
  2.  Change `set -g default-terminal "tmux-24bit"` back to `set -g default-terminal "screen-256color"`.
  3.  Reload the config with **`Ctrl-b`** + **`r`**.

  The first solution is the best fix, but this alternative works perfectly well too.

---

## Credits

- Inspired by community best practices and personal workflow optimizations.
- See plugin repositories for more details and documentation.

---

Enjoy your enhanced tmux experience! If you have questions or suggestions, feel free to open an issue or reach out.
