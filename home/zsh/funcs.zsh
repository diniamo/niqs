path() {
    realpath "$(which "$@")"
}

contaminate() {
    for file in "$@"; do
        if [[ -f "$file.pure" ]]; then
            print "$file" "is already contaminated"
        elif [[ ! -f "$file" ]]; then
            print "$file" "is not a file or does not exist"
        else
            print "Contaminating" "$file"
            mv "$file" "$file.pure"
            install -m 644 "$file.pure" "$file"
        fi
    done
}

decontaminate() {
    for file in "$@"; do
        if [[ -f "$file.pure" ]]; then
            print "Decontaminating" "$file"
            mv "$file.pure" "$file"
        else
            print "$file" "is not contaminated"
        fi
    done
}

nv() {
    declare -a contaminated
    for file in "$@"; do
        [[ -f "$file" && ! -w "$file" ]] && contaminated+=("$file")
    done

    contaminate "${contaminated[@]}"
    "$EDITOR" -- "$@"
    decontaminate "${contaminated[@]}"
}

yazi() {
    local tmp="$(mktemp)"
    command yazi "$@" --cwd-file="$tmp"
    local cwd="$(cat "$tmp")"
    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && cd "$cwd"
}

xv() {
    [[ -z "$1" ]] && return
    if [[ -f "$1" ]]; then
        chmod +x "$1"
    else
        install /dev/null "$1"
    fi
    nvim "$1"
}

..() {
    if [[ -z "$1" ]]; then
        cd ..
    else
        cd $(awk "BEGIN {while (c++<$1) printf \"../\"}")
    fi
}

mcd() {
    [[ -d "$1" ]] || mkdir -p "$1"
    cd "$1"
}

copypath() {
    if [[ -n "$1" ]]; then
        value="$(realpath -s "$1")"
        print "Copying" "$value"
        wl-copy <<<"$value"
    else
        print "Copying" "$PWD"
        pwd | wl-copy
    fi
}

copyfile() {
    if [[ -f "$1" ]]; then
        print "Copying the contents of" "$1"
        cat "$1" | wl-copy
    else
        print "$1" "not found"
    fi
}

notify-exit() {
    "$@"
    notify-send -i dialog-information "Shell" "$1 has finished executing"
}

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
