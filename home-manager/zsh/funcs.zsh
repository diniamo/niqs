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
