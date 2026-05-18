A personal config for neovim that I finally managed to switch to, after trying
to set it up with a much more convenient Lazy.nvim instead of the now seemingly
dead Packer.

# Setup

## Prerequisites

This is a full-on Lua-based config, so you will need to install Lua language. You
probably will end up with `luarocks` as well, which is Lua's package manager, but
install it separately if you somehow didn't.

***Optional***
I also do some personal stuff in Odin, so this config includes ols, which is an LSP
for it, you can get it [over here](https://github.com/DanielGavin/ols). If you don't
care about it - just remove the "ols" string inside `lua/config/plugins/lsp.lua`
from the `servers` array.

### Installation

Clone the repo into your local config folder. Ideally it should be in your
system's `$XDG_CONFIG_HOME`, which is usually your `$HOME/.config`:

```sh
cd ~/.config
git clone https://github.com/LinetCheese/lazy_nvim_config.git nvim
```

After that open neovim: it should lag a bit, downloading the repo and installing the
plugins, but otherwise you should be mostly good to go.

One thing to also consider - since this plugin uses Mason's Tailwind LSP - you'll need
to install it manually. You can do so by running `:Mason` inside neovim, searching for
`tailwindcss` and hitting "I" on it. It should pick up the lsp through your local
`npm` installation, which you probably have, if you want Tailwind anyway.

Afterwards, run `:checkhealth` to see if there are any immediate issues.
