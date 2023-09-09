export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __DOTS

__DOTS[ITALIC_ON]=$'\e[3m'
__DOTS[ITALIC_OFF]=$'\e[23m'

exists() { (( $+commands[$1] )); }

if exists brew; then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

fpath=($ZDOTDIR/functions $fpath)

autoload -Uz $ZDOTDIR/functions/*(.:t)
autoload -U colors && colors

autoload -Uz vcs_info

# Using named colors means that the prompt automatically adapts to how these
# are set by the current terminal theme
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green} ●%f"
zstyle ':vcs_info:*' unstagedstr "%F{red} ●%f" # alternative: ✘
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-untracked git-stash git-compare git-remotebranch
zstyle ':vcs_info:git*:*' actionformats '(%B%F{red}%b|%a%c%u%%b%f) '
zstyle ':vcs_info:git:*' formats "%F{249}(%f%F{blue}%{$__DOTS[ITALIC_ON]%}%b%{$__DOTS[ITALIC_OFF]%}%f%F{249})%f%c%u%m"

precmd() { vcs_info }

# PROMPT='%{$fg[green]%}%1~%{$reset_color%}${vcs_info_msg_0_} %{$fg[magenta]%}⛧${reset_color%} '
# PROMPT='%F{green}%1~%f${vcs_info_msg_0_} %F{magenta}⛧%f '

#-------------------------------------------------------------------------------
#               Prompt
#-------------------------------------------------------------------------------
setopt PROMPT_SUBST
function __prompt_eval() {
  local dots_prompt_icon="%F{magenta}⛧ %f"
  local dots_prompt_failure_icon="%F{red}✘ %f"
  local top="%B%F{green}%1~%f%b${vcs_info_msg_0_}"
  local character="%(1j.%F{cyan}%j✦%f .)%(?.${dots_prompt_icon}.${dots_prompt_failure_icon})"
  local bottom=$([[ -n "$vim_mode" ]] && echo "$vim_mode" || echo "$character")
  echo $top$'\n'$bottom
}
# NOTE: VERY IMPORTANT: the type of quotes used matters greatly. Single quotes MUST be used for these variables
export PROMPT='$(__prompt_eval)'
# PROMPT = %B%F{magenta}%1~%f%b${vcs_info_msg_0}
# Right prompt
# export RPROMPT='%F{yellow}%{$__DOTS[ITALIC_ON]%}${cmd_exec_time}%{$__DOTS[ITALIC_OFF]%}%f %F{240}%*%f'
# Correction prompt
export SPROMPT="correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "


pr() { open https://dev.azure.com/PointsBet/PointsBet/_git/Web-Micro/pullrequest/"$1" }
ticket() { open https://dev.azure.com/pointsbet/PointsBet/_workitems/edit/"$1" }
build() { open "https://dev.azure.com/pointsbet/PointsBet/_build/results?buildId=$1" }

newbug() { open "https://dev.azure.com/pointsbet/PointsBet/_workitems/create/bug" }
newstory() { open "https://dev.azure.com/pointsbet/PointsBet/_workitems/create/user story" }
newei() { open "https://dev.azure.com/pointsbet/PointsBet/_workitems/create/engineering improvement" }

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias code=codium
alias njdev="yarn build -g us-sportsbook -r us-nj -p web -e dev && yarn dev --reset"
alias njuat="yarn build -g us-sportsbook -r us-nj -p web -e uat && yarn dev --reset"
alias njdevcasino="yarn build -g us-casino -r us-nj-casino -p web -e dev && yarn dev --reset"
alias njuatcasino="yarn build -g us-casino -r us-nj-casino -p web -e uat && yarn dev --reset"
alias audev="yarn build -g au-sportsbook -r au -p web -e dev && yarn dev --reset"
alias auuat="yarn build -g au-sportsbook -r au -p web -e uat && yarn dev --reset"
alias cadev="yarn build -g ca-sportsbook -r ca-on -p web -e dev && yarn dev --reset"
alias cauat="yarn build -g ca-sportsbook -r ca-on -p web -e uat && yarn dev --reset"
alias couat="yarn build -g us-sportsbook -r us-co -p web -e uat && yarn dev --reset"
alias pauat="yarn build -g us-sportsbook -r us-pa -p web -e uat && yarn dev --reset"
alias vauat="yarn build -g us-sportsbook -r us-va -p web -e uat && yarn dev --reset"
alias wvuat="yarn build -g us-sportsbook -r us-wv -p web -e uat && yarn dev --reset"
alias nyuat="yarn build -g us-sportsbook -r us-ny -p web -e uat && yarn dev --reset"
alias rwuat="yarn build -g rw-sportsbook -r rw-us-ny -p web -e uat && yarn dev --reset"
alias usuatios="yarn build -g us-sportsbook -r us-co -p ios -e uat"
alias usdevios="yarn build -g us-sportsbook -r us-co -p ios -e dev"
alias auuatios="yarn build -g au-sportsbook -r au -p ios -e uat"
alias cauatios="yarn build -g ca-sportsbook -r ca-on -p ios -e uat"
alias usuatandroid="yarn build -g us-sportsbook -r us-co -p android -e uat"
alias auuatandroid="yarn build -g au-sportsbook -r au -p android -e uat"
alias usdevandroid="yarn build -g us-sportsbook -r us-co -p android -e dev"
alias cauatandroid="yarn build -g ca-sportsbook -r ca-on -p android -e uat"

export PATH="${HOME}/.pyenv/shims:${PATH}"
export PYTHON=python2

source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
