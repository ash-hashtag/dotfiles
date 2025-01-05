#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_DATA_DIRS=${XDG_DATA_DIRS:="$HOME/.local/share"}

export CHROME_EXECUTABLE=brave

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
# export JAVA_HOME="/usr/lib/jvm/java-22-openjdk"
export ANDROID_HOME="$HOME/Android/Sdk"


# export USER_ENV_PATH="/usr/lib/rustup/bin"
# export USER_ENV_PATH="$USER_ENV_PATH:$HOME/.yarn/bin"
export USER_ENV_PATH="$HOME/.yarn/bin"
export USER_ENV_PATH="$USER_ENV_PATH:$HOME/.cargo/bin"
export USER_ENV_PATH="$USER_ENV_PATH:$HOME/Development/flutter/bin"
export USER_ENV_PATH="$USER_ENV_PATH:$HOME/.pub-cache/bin"
export USER_ENV_PATH="$USER_ENV_PATH:$JAVA_HOME/bin"
export USER_ENV_PATH="$USER_ENV_PATH:/opt/gradle/gradle-8.6/bin"
export USER_ENV_PATH="$USER_ENV_PATH:$HOME/.local/share/solana/install/active_release/bin"
export USER_ENV_PATH="$USER_ENV_PATH:$ANDROID_HOME/cmdline-tools/bin"
export USER_ENV_PATH="$USER_ENV_PATH:$ANDROID_HOME/emulator"
export USER_ENV_PATH="$USER_ENV_PATH:$ANDROID_HOME/platform-tools"

if [[ "${PATH: -${#USER_ENV_PATH}}" != "$USER_ENV_PATH" ]]; then
  export PATH="$PATH:$USER_ENV_PATH";
fi




alias init-nvm='source /usr/share/nvm/init-nvm.sh' # makes bash launch slow
# alias tmux-rs='tmux new -e CARGO_TARGET_DIR=/tmp/target -s '

# For Dart FFI GEN
alias setcpath='export CPATH="$(clang -v 2>&1 | grep "Selected GCC installation" | rev | cut -d'"'"' '"'"' -f1 | rev)/include"'



if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  alias cbc='wl-copy'
  alias cbp='wl-paste'
else
  alias cbc='xclip -selection clipboard'
  alias cbp='xclip -selection clipboard -o'
fi


alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias hx='helix'
alias q='exit'


# The next line updates PATH for the Google Cloud SDK.

alias setgcp='if [ -f '"'"'$HOME/google-cloud-sdk/path.bash.inc'"'"' ]; then . '"'"'$HOME/google-cloud-sdk/path.bash.inc'"'"'; fi'

# print todos
todo() {
  if [ $# -ne 0 ] ; then
    echo "$@" >> .todo
  fi
}

todos() {
  [ -r .todo ] && echo 'TODOS:' && cat -n .todo 
}


todone() {
  todoline=$(sed -n "$1"p .todo)
  if [[ -z "$todoline" ]]; then
    echo "Todo #$1 doesn't exist"
  else
    read -p "Done #$1 $todoline (Y/n)?" choice
    choice=${choice:-Y}

    if [[ "$choice" =~ ^[Yy]$ ]]; then
      output=$(sed "$1"d .todo)
      if [[ -z "$output" ]]; then
        rm .todo
      else
        echo "$output" > .todo
      fi
    fi
  fi
}

todos

# eval "$(starship init bash)"
