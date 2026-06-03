# Global Instructions

## Environment

- This file is symlinked from `~/.dotfiles/.config/claude/`. Changes here are tracked in the dotfiles repo at `~/.dotfiles`.
- `settings.json` is curated for **global** settings only (model, generic shell permissions, plugins). Do NOT add project-specific permissions, paths, or commands to it — those belong in project-level `.claude/settings.json` files instead.

## Working Style

- When making code changes, prefer minimal targeted fixes. Do NOT make sweeping refactors, add logging utilities, or rename things beyond what was explicitly requested. Ask before expanding scope.
- When I interrupt or reject an action, STOP and ask what I want instead. Do not continue down the same path or try a variation of what was just rejected.
- When a task spans multiple projects or working directories, consider whether the changes can be parallelized with sub-agents. Propose parallel execution when the work is independent.

## Writing: code, comments, prose

Be terse. Never explain in words what the code already says. Fewer words is better.

Applies to all prose (commits, PRs, docs):
- Never use em dashes. Use a comma, a period, or parentheses.
- Prefer a conversational tone. Write like you talk, not like a press release.

**Names** — make them specific and declarative; the name says what the thing is or does.
- Bad: vague or generic (`data`, `handle`, `process`), placeholder-flavored for something with a real job (`stub`), insider jargon (`wire`, `kernel`, `round-trippable`), over-broad scope.
- A good name removes the need for a comment.

**Comments** — default to none. Write one ONLY to explain a non-obvious *why* the code can't show on its own (e.g. why a regex matches what it does, why an optimization is deferred). Max one line.
- Never: restate what the code does, note what you're *not* doing, log a decision, record future plans, or reassure ("works as expected").

**Commits & PR descriptions** — short. State what changed and why, imperative voice. One section.
- Never: decision logs, essays, a test-plan section, "why this shape" rationale, or restating the diff.

## Debugging

- For bugs where the root cause is unclear or I haven't identified a specific file/location, present a diagnosis with evidence before making any changes. Ask for my hypothesis or suggest a minimal diagnostic step (e.g., diffing payloads, checking a specific branch, checking prod behavior). Prefer the simplest explanation.
- For targeted fixes where I point to specific code or the cause is obvious, just fix it — don't over-diagnose.
- Before investigating, confirm you're looking in the right project/module. If you're unsure which directory or layer something lives in, ask rather than guessing.

@RTK.md
