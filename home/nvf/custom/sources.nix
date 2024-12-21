{
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs) fetchFromGitHub;
  inherit (lib) mkOption types;

  sources = {
    bufresize-nvim = {
      pname = "bufresize.nvim";
      version = "2022-03-21";

      outPath = fetchFromGitHub {
        owner = "kwkarlwang";
        repo = "bufresize.nvim";
        rev = "3b19527ab936d6910484dcc20fb59bdb12322d8b";
        hash = "sha256-6jqlKe8Ekm+3dvlgFCpJnI0BZzWC3KDYoOb88/itH+g=";
      };

      passthru.vimPlugin = false;
    };
    direnv-nvim = {
      pname = "direnv.nvim";
      version = "2024-07-08_1";

      outPath = fetchFromGitHub {
        owner = "NotAShelf";
        repo = "direnv.nvim";
        rev = "3e38d855c764bb1bec230130ed0e026fca54e4c8";
        hash = "sha256-nWdAIchqGsWiF0cQ7NwePRa1fpugE8duZKqdBaisrAc=";
      };

      passthru.vimPlugin = false;
    };
    fastaction-nvim = {
      pname = "fastaction.nvim";
      version = "2024-07-19";

      outPath = fetchFromGitHub {
        owner = "Chaitanyabsprip";
        repo = "fastaction.nvim";
        rev = "886e22d85e13115808e81ca367d5aaba02d9a25b";
        hash = "sha256-1GSxTyXqufjkRtNK3drWlCn/mGJ9mM9bHMR6ZwWT6X8=";
      };

      passthru.vimPlugin = false;
    };
    harpoon2 = {
      pname = "harpoon2";
      version = "2024-11-13";

      outPath = fetchFromGitHub {
        owner = "ThePrimeagen";
        repo = "harpoon";
        rev = "a84ab829eaf3678b586609888ef52f7779102263";
        hash = "sha256-PjB64kdmoCD7JfUB7Qz9n34hk0h2/ZZRlN8Jv2Z9HT8=";
      };
    };
    cmp-nvim-lua = {
      pname = "cmp-nvim-lua";
      version = "2023-04-14";

      outPath = fetchFromGitHub {
        owner = "hrsh7th";
        repo = "cmp-nvim-lua";
        rev = "f12408bdb54c39c23e67cab726264c10db33ada8";
        hash = "sha256-6eXOK1mVK06TN1akhN42Bo4wQpeen3rk3b/m7iVmGKM=";
      };
    };
    feline-nvim = {
      pname = "feline.nvim";
      version = "2024-11-13";

      outPath = fetchFromGitHub {
        owner = "freddiehaddad";
        repo = "feline.nvim";
        rev = "9f1313f61a75ec5ebe805fedd46bdc130c420963";
        hash = "sha256-/TqgHJo2ej/V5bubTdTlf5S+EZmSpU5F2Mdi0SHCD30=";
      };

      passthru.vimPlugin = false;
    };
    oil-nvim = {
      pname = "oil.nvim";
      version = "2024-12-21";

      outPath = fetchFromGitHub {
        owner = "stevearc";
        repo = "oil.nvim";
        rev = "c5f7c56644425e2b77e71904da98cda0331b3342";
        hash = "sha256-vu4iccnjvh4z+oaQvGz2rorSEMNXIaIxCtPIIoUjjgs=";
      };

      passthru.vimPlugin = false;
    };
    nvim-lastplace = {
      pname = "nvim-lastplace";
      version = "2023-07-27";

      outPath = fetchFromGitHub {
        owner = "ethanholz";
        repo = "nvim-lastplace";
        rev = "0bb6103c506315044872e0f84b1f736c4172bb20";
        hash = "sha256-jmF06Cl1ieYXKTnW9pWdQH4IJGicvSVJAR7ppju9qyg=";
      };

      passthru.vimPlugin = false;
    };
    telescope-zf-native-nvim = {
      pname = "telescope-zf-native.nvim";
      version = "2024-09-15";

      outPath = fetchFromGitHub {
        owner = "natecraddock";
        repo = "telescope-zf-native.nvim";
        rev = "5721be27df11a19b9cd95e6a4887f16f26599802";
        hash = "sha256-MCYnloqijGvmQRcdfMhYo5VkDNc4Yk35YCfNgbI1FcE=";
      };

      passthru.vimPlugin = false;
    };
    telescope-zoxide = {
      pname = "telescope-zoxide";
      version = "2024-08-28";

      outPath = fetchFromGitHub {
        owner = "jvgrootveld";
        repo = "telescope-zoxide";
        rev = "54bfe630bad08dc9891ec78c7cf8db38dd725c97";
        hash = "sha256-LGfyAIbAAAF3q0NpMZx1AIgHLvk6ecpv7RyiL1q8Lxs=";
      };

      passthru.vimPlugin = false;
    };
    flit-nvim = {
      pname = "flit.nvim";
      version = "2024-06-19";

      outPath = fetchFromGitHub {
        owner = "ggandor";
        repo = "flit.nvim";
        rev = "1ef72de6a02458d31b10039372c8a15ab8989e0d";
        hash = "sha256-lLlad/kbrjwPE8ZdzebJMhA06AqpmEI+PJCWz12LYRM=";
      };

      passthru.vimPlugin = false;
    };
  };
in {
  options = {
    programs.nvf.custom.sources = mkOption {
      type = types.attrs;
      default = sources;
      readOnly = true;
      description = "External plugin sources";
    };
  };
}
