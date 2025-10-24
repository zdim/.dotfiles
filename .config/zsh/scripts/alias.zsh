alias grep="grep --color"
alias ls="ls --color"

(( $+commands[batcat] )) && alias bat='batcat'
(( $+commands[bat] )) && alias cat='bat'
(( $+commands[codium] )) && alias code='codium'

# vim
alias v='nvim'
alias vim='nvim'

# open all these files in nvim
alias -s {js,jsx,html,ts,tsx,css,md}=nvim

alias lg='lazygit'

alias cors='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'
alias p='pnpm'
