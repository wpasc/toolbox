# Cursor Extension Review

Review of work Cursor extensions: which to keep, consolidate, or drop, and their NeoVim equivalents.

## Python Extensions

| Extension | Recommendation | Notes |
|-----------|---------------|-------|
| Python (MS) | Keep | Core Python support. Provides Pylance (type checking, IntelliSense). NeoVim equivalent: pyright |
| mypy | Consider dropping | Pylance/pyright covers most type checking. mypy catches some edge cases pyright misses (protocol conformance, plugin-based checks). Keep if your team's CI runs mypy; otherwise redundant |
| flake8 | Drop in favor of ruff | Ruff covers all flake8 rules and is 10-100x faster. No reason to run both |
| ruff | Keep | Modern linter + formatter. Replaces flake8, isort, and can replace black. NeoVim equivalent: ruff (native LSP) |
| Python debugger (MS) | Keep (low priority) | Useful when needed but not daily-driver. Skip for NeoVim unless debugging becomes a pain point |

## Other Extensions

| Extension | Recommendation | Notes |
|-----------|---------------|-------|
| GitLens | Already disabled | Git blame in NeoVim: gitsigns.nvim (already configured). Re-enable in Cursor only if you miss the history/blame features |
| Docker / Containers (MS) | Keep if using containers | Not relevant to NeoVim setup |

## Summary

**Consolidation opportunity:** Drop flake8 if ruff is configured with equivalent rules. Consider dropping mypy if pyright's type checking is sufficient and your CI doesn't require mypy specifically. This cuts two extensions with no loss in coverage for most workflows.
