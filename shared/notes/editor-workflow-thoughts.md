# Editor Workflow Thoughts

Freeform ideas about editor roles and workflow — nothing actioned yet.

## The Core Question

Maybe I'm trying to do too much in Neovim. The thing I want out of my development environment — the interface into all my files and everything — might not need to be a single tool.

## Emacs?

Still early in the Neovim journey, so maybe now is the right time to look at Emacs. Worth considering but not committed.

## The Two-Editor Idea

A potentially better approach: **keep Neovim for most use cases**, but use **Cursor / VS Code as the primary notes interface**.

Why VS Code for notes:
- Better visual handling (collapsibility, markdown preview, etc.)
- Vim keybindings still work in VS Code
- Past problem with VS Code/Cursor was having too many instances open — in this workflow there would be just one dedicated instance for notes

This isn't ideal in the abstract (two editors), but it might be practical — VS Code does some things that Emacs just won't, and the single-instance constraint keeps it from becoming the sprawl problem it was before.

## Future Action: VS Code Settings in Toolbox

It would be cool to have VS Code settings tracked in this toolbox so they can be:
- Version controlled alongside everything else
- Easily mapped and synced with Neovim settings (shared keybindings, consistent behavior)

This would mean adding a `projects/vscode/` directory (config, notes, scripts) following the existing pattern.
