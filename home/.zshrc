#############################################################################
##        _    _
##   _ __| | _| |
##  | '__| |/ / |   Richard Klein Leugemors
##  | |  |   <| |   https://www.github.com/leugemors/
##  |_|  |_|\_\_|
##
##  My personal zsh configuration, using a nice starship prompt
##
##  -------------------------------------------------------------------------
##
##  I expect some suckless tools to be installed, like bat, eza, fzf,
##  ripgrep, zoxide, etc. And obviously starship.
##
#############################################################################

# ---------------------------------------------------------------------------
#  Setting environment variables
# ---------------------------------------------------------------------------

export ANSIBLE_NOCOWS=1                           # no cows for ansible
export EDITOR=vim                                 # set default editor
# export MANPAGER="sh -c 'col -bx | bat -l man -p'" # set bat as manpager
# export MANROFFOPT="-c"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"    # add my local bin to PATH
export PROMPT_EOL_MARK=""                         # hide EOL sign ('%')
export TERM="xterm-256color"                      # support 256 colours

# ---------------------------------------------------------------------------
#  Don't consider certain characters part of the word
# ---------------------------------------------------------------------------

export WORDCHARS=${WORDCHARS//\/}

# ---------------------------------------------------------------------------
#  Set auto correct options
# ---------------------------------------------------------------------------

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

setopt dot_glob            # include dotfiles
setopt extended_glob       # match ~ # ^

# ---------------------------------------------------------------------------
#  Configure key keybindings
# ---------------------------------------------------------------------------

# bindkey -v                                     # use vim key bindings
bindkey ' ' magic-space                        # do history expansion on space
bindkey '^[[3;5~' kill-word                    # ctrl + Supr
bindkey '^[[3~' delete-char                    # delete
bindkey '^[[1;5C' forward-word                 # ctrl + ->
bindkey '^[[1;5D' backward-word                # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history # page up
bindkey '^[[6~' end-of-buffer-or-history       # page down
bindkey '^[[H' beginning-of-line               # home
bindkey '^[[F' end-of-line                     # end
bindkey '^[[Z' undo                            # shift + tab undo last action

# ---------------------------------------------------------------------------
#  Enable completion features
# ---------------------------------------------------------------------------

autoload -Uz compinit
compinit -d ~/.cache/zcompdump

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ---------------------------------------------------------------------------
#  History configurations
# ---------------------------------------------------------------------------

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

HISTORY_IGNORE="(ls|cd|cd -|cd ..|pwd|exit|history)"
HISTTIMEFORMAT="[%F %T] - "

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share history data between zsh sessions

# ---------------------------------------------------------------------------
#  Configure `time` format
# ---------------------------------------------------------------------------

TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# ---------------------------------------------------------------------------
#  Make less more friendly for non-text input files, see lesspipe(1)
# ---------------------------------------------------------------------------

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ---------------------------------------------------------------------------
#  Enable command-not-found if installed
# ---------------------------------------------------------------------------

if [ -f /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
fi

# ---------------------------------------------------------------------------
#  Load my plugins
# ---------------------------------------------------------------------------

# "zsh-autocomplete"
   
plugins=(
    "zsh-autosuggestions"
    "zsh-history-substring-search"
    "zsh-syntax-highlighting"
)

for p in "${plugins[@]}"; do
    if [ -f /usr/share/zsh/plugins/${p}/${p}.zsh ]; then
        echo "Loading plugin: ${p}..."
        source /usr/share/zsh/plugins/${p}/${p}.zsh
    fi
done

# ---------------------------------------------------------------------------
#  Load my k8s configuration
# ---------------------------------------------------------------------------

source <(kubectl completion zsh)

# ---------------------------------------------------------------------------
#  Load my custom aliasses
# ---------------------------------------------------------------------------

if [ -f ~/.aliases ]; then
    echo "Loading custom aliasses..."
    source ~/.aliases
fi

# ---------------------------------------------------------------------------
#  Set-up keybinding for a bunch of very handy tools
# ---------------------------------------------------------------------------

export FZF_DEFAULT_OPTS="--layout=reverse --border=bold --border=rounded --margin=3% --color=dark"

# eval "$(atuin init zsh)"
eval "$(fzf --zsh)"           # load keybindings for fzf
eval "$(starship init zsh)"   # initialise the starship prompt
eval "$(zoxide init zsh)"     # fancy change directory

# ---------------------------------------------------------------------------
#  Stuff for yazi
# ---------------------------------------------------------------------------

function y() {
  	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  	yazi "$@" --cwd-file="$tmp"
  	IFS= read -r -d '' cwd < "$tmp"
  	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  	rm -f -- "$tmp"
}

# ---------------------------------------------------------------------------
#  By request of thijs :-)
# ---------------------------------------------------------------------------

clear
bible_verse | cowsay | lolcat
# echo; ucal; echo
# echo; dierenriem; echo

# fastfetch --logo arch --config examples/8

### eof #####################################################################
