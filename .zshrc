#############################################################################
##        _    _
##   _ __| | _| |
##  | '__| |/ / |   Richard Klein Leugemors
##  | |  |   <| |   https://www.github.com/leugemors/
##  |_|  |_|\_\_|
##
##  my personal zsh configuration, using a nice starship prompt
##
#############################################################################

# ---------------------------------------------------------------------------
#  support 256 colours
# ---------------------------------------------------------------------------

export TERM="xterm-256color"

# ---------------------------------------------------------------------------
#  set batcat as manpager
# ---------------------------------------------------------------------------

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ---------------------------------------------------------------------------
#  set auto correct options
# ---------------------------------------------------------------------------

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

# ---------------------------------------------------------------------------
#  don't consider certain characters part of the word
# ---------------------------------------------------------------------------

WORDCHARS=${WORDCHARS//\/}

# ---------------------------------------------------------------------------
#  hide EOL sign ('%')
# ---------------------------------------------------------------------------

PROMPT_EOL_MARK=""

# ---------------------------------------------------------------------------
#  configure key keybindings
# ---------------------------------------------------------------------------

bindkey -v                                        # vim key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

# ---------------------------------------------------------------------------
#  enable completion features
# ---------------------------------------------------------------------------

autoload -Uz compinit
compinit -d ~/.cache/zcompdump

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
# take advantage of $LS_COLORS for completion as well
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ---------------------------------------------------------------------------
#  history configurations
# ---------------------------------------------------------------------------

HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=40000

HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)" 
HISTTIMEFORMAT="[%F %T] - "

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# ---------------------------------------------------------------------------
#  configure `time` format
# ---------------------------------------------------------------------------

TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# ---------------------------------------------------------------------------
#  make less more friendly for non-text input files, see lesspipe(1)
# ---------------------------------------------------------------------------

#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ---------------------------------------------------------------------------
#  enable auto-suggestions based on the history
# ---------------------------------------------------------------------------

if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# ---------------------------------------------------------------------------
# enable syntax highlighting
# ---------------------------------------------------------------------------

if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ---------------------------------------------------------------------------
#  enable command-not-found if installed
# ---------------------------------------------------------------------------

if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

# ---------------------------------------------------------------------------
#  load my k8s configuration
# ---------------------------------------------------------------------------

#source <(kubectl completion zsh)

# ---------------------------------------------------------------------------
#  load my custom aliasses
# ---------------------------------------------------------------------------

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# ---------------------------------------------------------------------------
#  otherwise all ansible messages will also get parsed through cowsay
# ---------------------------------------------------------------------------

export ANSIBLE_NOCOWS=1

# ---------------------------------------------------------------------------
#  use vim keys to edit the command line
# ---------------------------------------------------------------------------

export EDITOR=vim

# ---------------------------------------------------------------------------
#  load the starship prompt
# ---------------------------------------------------------------------------

eval "$(starship init zsh)"

# ---------------------------------------------------------------------------
#  by request of thijs :-)
# ---------------------------------------------------------------------------

clear
#neofetch
#colorscript -r
#fortune | cowsay | lolcat
verse | cowsay | lolcat
#gcal_wrapper; echo; romeinse_kalender; cycles
echo; djdnx "$(getjdn)"

### eof #####################################################################
