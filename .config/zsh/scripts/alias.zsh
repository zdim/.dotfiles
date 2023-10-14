alias grep="grep --color"

(( $+commands[bat] )) && alias cat='bat'
(( $+commands[codium] )) && alias code='codium'

# vim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# open all these files in nvim
alias -s {js,jsx,html,ts,tsx,css,md}=nvim
