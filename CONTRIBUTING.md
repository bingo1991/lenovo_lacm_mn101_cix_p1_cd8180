# Contributing

Patches and reports are welcome.

## Data from another machine

1. Run `tools/collect.sh` on the new machine.
2. Run `tools/collect-acpi.sh` on the new machine.
3. Remove all device identifiers with `tools/sanitize.sh`.
4. State the exact model, the BIOS version and the kernel version.
5. State which parts are new.

A pull request with new data for the same model is useful. Say which board
version it came from.

## Device tree patches

1. Keep one idea per commit.
2. Name the ACPI source of every new node in a comment.
3. Run `make` in `dts/`. The build must stay warning free.

## Commit messages

Use the form `<area>: <what changed>`.

Examples: `dts: add the Type-C ports`, `docs: fix the I2C table`.

Keep the subject under 60 characters. Describe the goal, not the steps.
