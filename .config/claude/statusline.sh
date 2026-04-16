#!/usr/bin/env bash

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "?"')
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
worktree=$(echo "$input" | jq -r '.worktree.name // empty' 2>/dev/null) || worktree=""
cwd=$(echo "$input" | jq -r '.cwd // "."')
rl_5h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty' 2>/dev/null) || rl_5h=""

RST='\033[0m'
DIM='\033[90m'
GRN='\033[32m'
RED='\033[31m'
YLW='\033[33m'
BLU='\033[34m'

color_pct() {
  local v=${1%%.*}
  v=${v:-0}
  local c=$GRN
  (( v >= 50 )) && c=$YLW
  (( v >= 80 )) && c=$RED
  printf '%b%d%%%b' "$c" "$v" "$RST"
}

# staged/unstaged indicators matching zsh prompt (green ● / red ●)
git_dots=""
if cd "$cwd" 2>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null; then
  git diff --cached --quiet 2>/dev/null || git_dots+="${GRN} ●${RST}"
  git diff --quiet 2>/dev/null || git_dots+="${RED} ●${RST}"
fi

sep="${DIM} │ ${RST}"
out="${DIM}${model}${RST}"
out+="${sep}ctx $(color_pct "$ctx_pct")"
[[ -n "$rl_5h" ]] && out+="${sep}5h $(color_pct "$rl_5h")"
[[ "$cost" != "0" ]] && out+="${sep}${DIM}\$$(printf '%.2f' "$cost")${RST}"
[[ -n "$worktree" ]] && out+="${sep}${BLU}${worktree}${RST}"
[[ -n "$git_dots" ]] && out+="${git_dots}"

printf '%b' "$out"
