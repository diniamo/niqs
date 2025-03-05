{
  # Disables cursor blinking in the TTY
  systemd.tmpfiles.rules = ["w /sys/class/graphics/fbcon/cursor_blink - - - - 0"];
}
