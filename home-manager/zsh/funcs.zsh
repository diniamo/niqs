path() {
  realpath "$(which "$@")"
}

contaminate() {
  if [[ -f "$1" ]]; then
    if [[ -f "$1.pure" ]]; then
        print "Decontaminating" "$1"
        mv "$1.pure" "$1"
    else
        print "Contaminating" "$1"
        mv "$1" "$1.pure"
        install -m 644 "$1.pure" "$1"
    fi
  else
    print "$1" "does not exist!"
  fi
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
    cd `awk "BEGIN {while (c++<$1) printf \"../\"}"`
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
