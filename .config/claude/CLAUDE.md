# Global Instructions

## Environment

- This file and `~/.claude/settings.json` are symlinked from `~/.dotfiles/.config/claude/`. Changes here are tracked in the dotfiles repo at `~/.dotfiles`.

## Working Style

- When making code changes, prefer minimal targeted fixes. Do NOT make sweeping refactors, add logging utilities, or rename things beyond what was explicitly requested. Ask before expanding scope.
- When I interrupt or reject an action, STOP and ask what I want instead. Do not continue down the same path or try a variation of what was just rejected.
- When a task spans multiple projects or working directories, consider whether the changes can be parallelized with sub-agents. Propose parallel execution when the work is independent.

## Debugging

- For bugs where the root cause is unclear or I haven't identified a specific file/location, present a diagnosis with evidence before making any changes. Ask for my hypothesis or suggest a minimal diagnostic step (e.g., diffing payloads, checking a specific branch, checking prod behavior). Prefer the simplest explanation.
- For targeted fixes where I point to specific code or the cause is obvious, just fix it — don't over-diagnose.
- Before investigating, confirm you're looking in the right project/module. If you're unsure which directory or layer something lives in, ask rather than guessing.
