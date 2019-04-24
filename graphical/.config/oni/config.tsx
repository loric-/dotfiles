import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    oni.input.bind("<a-c>", () =>
       oni.editors.activeEditor.neovim.command(`call OniNextWindow('h')<CR>`)
    )
    oni.input.bind("<a-t>", () =>
       oni.editors.activeEditor.neovim.command(`call OniNextWindow('j')<CR>`)
    )
    oni.input.bind("<a-s>", () =>
       oni.editors.activeEditor.neovim.command(`call OniNextWindow('k')<CR>`)
    )
    oni.input.bind("<a-r>", () =>
       oni.editors.activeEditor.neovim.command(`call OniNextWindow('l')<CR>`)
    )
}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    "oni.useDefaultConfig": false,
    "oni.loadInitVim": true,
    "editor.fontSize": "15px",
    "editor.fontFamily": "Inconsolata Nerd Font Mono",
    "editor.linePadding": 5,
    "oni.hideMenu": true,
    "ui.fontFamily": "Inconsolata Nerd Font",
    "ui.fontSize": "14px",
    "browser.defaultUrl": "https://www.google.com",
    "autoUpdate.enabled": true,
}
