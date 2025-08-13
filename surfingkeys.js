// Maps
api.map('<Ctrl-u>', 'e');
api.unmap('e');

api.map('<Ctrl-d>', 'd');
api.unmap('d');

api.imap('jk', '<Esc>');
api.iunmap('<Ctrl-a>');

// ACE Maps
api.aceVimMap('jk', '<Esc>', 'insert');

// Styles
settings.theme= `
:root {
    --theme-ace-bg:#232136;
    --theme-ace-bg-accent:#191726; /*TODO*/
    --theme-ace-fg:#e0def4;
    --theme-ace-fg-accent:#569fba; /*TODO*/
    --theme-ace-cursor:#e0def4; /*TODO*/
    --theme-ace-select:#232136; /*TODO*/
}
#sk_editor {
    font-family: 'FiraCode Nerd Font', 'Ubuntu Mono', 'Consolas', 'Source Code Pro', 'source-code-pro', monospace;
    background: var(--theme-ace-bg) !important;
    padding: 10px!important;
}
.ace_dialog-bottom{
    border-top: 1px solid var(--theme-ace-bg) !important;
}
.ace-chrome .ace_print-margin, .ace_gutter, .ace_gutter-cell, .ace_dialog{
    background: var(--theme-ace-bg-accent) !important;
}
.ace-chrome{
    color: var(--theme-ace-fg) !important;
}
.ace_gutter, .ace_dialog {
    color: var(--theme-ace-fg-accent) !important;
}
.ace_cursor{
    color: var(--theme-ace-cursor) !important;
}
.normal-mode .ace_cursor{
    background-color: var(--theme-ace-cursor) !important;
    border: var(--theme-ace-cursor) !important;
}
.ace_marker-layer .ace_selection {
    background: var(--theme-ace-select) !important;
} 
`
