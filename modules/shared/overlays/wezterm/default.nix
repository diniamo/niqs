{
  stdenv,
  rustPlatform,
  lib,
  fetchFromGitHub,
  ncurses,
  pkg-config,
  python3,
  fontconfig,
  installShellFiles,
  openssl,
  libGL,
  libX11,
  libxcb,
  libxkbcommon,
  xcbutil,
  xcbutilimage,
  xcbutilkeysyms,
  xcbutilwm,
  wayland,
  zlib,
  nixosTests,
  runCommand,
  vulkan-loader,
}:
rustPlatform.buildRustPackage rec {
  pname = "wezterm";
  version = "hyprland-smithay-update-merge";

  src = fetchFromGitHub {
    owner = "diniamo";
    repo = "wezterm";
    rev = "5ea131ba1c36d232873fd09987b6808061f63087";
    fetchSubmodules = true;
    hash = "sha256-NT8q1TLCkQbqasaF/Vp+UluOCaq68DCslBVhwV6d5Aw=";
  };

  postPatch = ''
    echo ${version} > .tag

    # tests are failing with: Unable to exchange encryption keys
    rm -r wezterm-ssh/tests
  '';

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "xcb-imdkit-0.3.0" = "sha256-fTpJ6uNhjmCWv7dZqVgYuS2Uic36XNYTbqlaly5QBjI=";
    };
  };

  nativeBuildInputs = [
    installShellFiles
    ncurses # tic for terminfo
    pkg-config
    python3
  ];

  buildInputs =
    [
      fontconfig
      zlib
    ]
    ++ lib.optionals stdenv.isLinux [
      libX11
      libxcb
      libxkbcommon
      openssl
      wayland
      xcbutil
      xcbutilimage
      xcbutilkeysyms
      xcbutilwm # contains xcb-ewmh among others
    ];

  buildFeatures = ["distro-defaults"];

  postInstall = ''
    mkdir -p $out/nix-support
    echo "${passthru.terminfo}" >> $out/nix-support/propagated-user-env-packages

    install -Dm644 assets/icon/terminal.png $out/share/icons/hicolor/128x128/apps/org.wezfurlong.wezterm.png
    install -Dm644 assets/wezterm.desktop $out/share/applications/org.wezfurlong.wezterm.desktop
    install -Dm644 assets/wezterm.appdata.xml $out/share/metainfo/org.wezfurlong.wezterm.appdata.xml

    install -Dm644 assets/shell-integration/wezterm.sh -t $out/etc/profile.d
    installShellCompletion --cmd wezterm \
      --bash assets/shell-completion/bash \
      --fish assets/shell-completion/fish \
      --zsh assets/shell-completion/zsh

    install -Dm644 assets/wezterm-nautilus.py -t $out/share/nautilus-python/extensions
  '';

  preFixup = lib.optionalString stdenv.isLinux ''
    patchelf \
      --add-needed "${libGL}/lib/libEGL.so.1" \
      --add-needed "${vulkan-loader}/lib/libvulkan.so.1" \
      $out/bin/wezterm-gui
  '';

  passthru = {
    tests = {
      all-terminfo = nixosTests.allTerminfo;
      # the test is commented out in nixos/tests/terminal-emulators.nix
      #terminal-emulators = nixosTests.terminal-emulators.wezterm;
    };
    terminfo =
      runCommand "wezterm-terminfo"
      {
        nativeBuildInputs = [ncurses];
      } ''
        mkdir -p $out/share/terminfo $out/nix-support
        tic -x -o $out/share/terminfo ${src}/termwiz/data/wezterm.terminfo
      '';
  };

  meta = with lib; {
    description = "GPU-accelerated cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust";
    homepage = "https://wezfurlong.org/wezterm";
    license = licenses.mit;
    mainProgram = "wezterm";
    maintainers = with maintainers; [SuperSandro2000 mimame];
  };
}
