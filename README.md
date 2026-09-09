# prose-style

Vale rules for technical prose, with CUE source and regression fixtures.

Run `nix build` to render the rules and test each covered rule.
The output contains `vale.ini`, `vale-audit.ini`, and the pinned upstream styles.
Use `vale --config ./result/vale.ini document.md` to check a document.

The `Sysinit` rule namespace stays stable for existing consumers.
Gate owns hook behavior. This repository owns the rule policy and its fixtures.

The initial source comes from `roshbhatia/sysinit` at `db93eb92e`.
The extraction preserves all rules, fixtures, and upstream style pins.
