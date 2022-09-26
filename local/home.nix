{ config, pkgs, ... }:

let
  nixpkgs = import <nixpkgs> {};
  mydiscord = pkgs.callPackage ./discord {pkgs = pkgs; };
  nixlsp = import (pkgs.fetchgit (import ./nixlsp.nix)) {pkgs=pkgs;};

  buildFirefoxXpiAddon = { pname, version, addonId, url, sha256, ... }:
    pkgs.stdenv.mkDerivation {
      name = "${pname}-${version}";


      src = builtins.fetchurl { inherit url sha256; };

      preferLocalBuild = true;
      allowSubstitutes = false;

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    };
  stan-vim-plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "stan-vim";
    version = "2021-05-21";
    src = pkgs.fetchFromGitHub {
      owner = "eigenfoo";
      repo = "stan-vim";
      rev = "9d3b6ec149f9559bd9bd021dfa827c29c5d1dc38";
      sha256 = "0qv748m1vrp1qcl41y7fj2jm8cac9b01ljq6ydq3z4syxdf7yzcc";
      fetchSubmodules = false;
    };
  };
  vim-mdx-js = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname="vim-mdx-js";
    version="2022-03-31";
    src = pkgs.fetchFromGitHub {
      owner = "jxnblk";
      repo = "vim-mdx-js";
      rev = "17179d7f2a73172af5f9a8d65b01a3acf12ddd50";
      sha256 = "wfYCvw9JVGG8p8PQhRPT6CeGGf2OVz9SR2KQM0LjQhY=";
    };
  };


  coqtail = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "coqtail";
    version = "2020-09-21";
    src = 
      pkgs.fetchFromGitHub {
        owner = "whonore";
        repo = "Coqtail";
        rev = "7ea2fd5f42910dcd10eaaccddedcc33f2edd2ef1";
        sha256 = "1f14sg9v80ir9f1zk4xqjbqqd0cv2pxpipbflzwafmwcs5chz6rv";
        fetchSubmodules = false;
      };
  };

  idris2-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "idris2-vim";
    version = "2020-09-07";
    src = pkgs.fetchFromGitHub {
        owner = "edwinb";
        repo = "idris2-vim";
        rev = "099129e08c89d9526ad092b7980afa355ddaa24c";
        sha256 = "1gip64ni2wdd5v4crl64f20pbrx24dmr3ci7w5c9da9hs85x1p29";
        fetchSubmodules = false;
      };

  };

  dart-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "dart-vim-plugin";
    version = "2020-07-19";
    src = pkgs.fetchFromGitHub {
      owner = "dart-lang";
      repo = "dart-vim-plugin";
      rev = "b9fd9d22d0c705e89e2cc50b993db04d824dd8aa";
      sha256 = "1m2i263ppvs8xbb5xfif5pyd5zxwhimvm373dlmlwmgn339cw0pa";
      fetchSubmodules = false;
    };
  };
  
  nvim-fzf = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "fzf";
    version = "2020-07-06";
    src = pkgs.fetchFromGitHub {
      owner = "junegunn";
      repo = "fzf";
      rev = "8e027c445f0eb4495e300522843df335c3b54e60";
      sha256 = "1qv3p5bgijqvrvc0g3h30crlycgda3mqsqr483rmyjv93jv0a5dc";
    };
  };
  firenvim =  pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "firevim";
    version = "2020-06-23";
    src =  pkgs.fetchFromGitHub {
      owner = "glacambre";
      repo = "firenvim";
      rev = "cc444f0cb4d0a8fe166204d62da68bd8c2bfd5b0";
      sha256 = "13gyz73lrwmipy4rv7vfi3zsbxd265d8mlcg7z4d28fwqd8akwzq";
    };
  };

  vim-rdf = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-rdf";
    version = "2020-01-09";
    src = pkgs.fetchFromGitHub {
      owner = "niklasl";
      repo = "vim-rdf";
      rev = "4b3b4c9f079b65d2b525f567715f0aabe60cfdf3";
      sha256 = "051piyf403k98zxjv0qm68qhgajwv57hblxdab2awsyvk9gzv5lc";
    };
  };
  vim-rescript = pkgs.vimUtils.buildVimPlugin {
    name = "vim-rescript";
    configurePhase = ''
      rm Makefile
    '';
    src = pkgs.fetchFromGitHub {
      owner = "rescript-lang";
      repo = "vim-rescript";
      rev = "08de54132587131e762b036c11e0e9a9603992fa";
      sha256 = "1idijazx8cprim27ps7f0bbahjz58vknhyqdqbfhb9sdqcg2llnf";
      fetchSubmodules = true;
    };
  };
in
{
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  home.packages = with pkgs; [
    #nixlsp
    awscli
    obsidian
    cachix
    github-cli
    fd
    hledger
    hub
    jq
    nix-prefetch-git
    nix-prefetch-github
    pass
    pavucontrol
    ripgrep
    rsync
    trash-cli
    nodejs
    unzip
    vdirsyncer
    yarn
    zip 
  ];
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;



  nixpkgs.config = import ../config.nix;

  programs.gpg.enable = true;

  programs.git = {
    enable = true;
    userName = "Sam Nolan";
    userEmail = "samnolan555@gmail.com";
    ignores = [".envrc"  ".direnv"];
    extraConfig = {
      pull.rebase = false;
    };
  };

  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      vim-rescript
      psc-ide-vim
      vim-pandoc
      vim-pandoc-syntax
      coc-tsserver
      coc-eslint
      coc-r-lsp
      vim-nix 
      vim-surround 
      vim-fugitive 
      vim-rdf 
      vim-colors-solarized
      elm-vim 
      coqtail 
      stan-vim-plugin 
      purescript-vim
      vim-mdx-js
    ];
    coc = {
      enable = true;
      package = nixpkgs.vimPlugins.coc-nvim;
      settings = {
        eslint.autoFixOnSave = true;
        languageserver = {
          rescript = {
            enable = true;
            module = "${vim-rescript}/server/out/server.js";
            args = ["--node-ipc"];
            filetypes = ["rescript"];
            rootPatterns = ["bsconfig.json"];
          };
        };
      };
    };
  };

  programs.fish = {
    enable = true;
    shellInit= builtins.readFile ./config.fish;
    shellAliases = { mv = "mv -i"; };
  };

  programs.tmux = {
    enable = true;
    #terminal = "screen";
    extraConfig = '' 
       set-option -g default-shell /run/current-system/sw/bin/fish
       set -sg escape-time 0 
       set-window-option -g mode-keys vi
       bind-key -T copy-mode-vi 'v' send -X begin-selection
       bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
    '';
  };

  programs.offlineimap = {
    enable = true;
  };

  programs.neomutt = {
    enable = true;
    sidebar = {
      enable = true;
    };
    vimKeys = true;
  };

  accounts.email.accounts.student = {
    address = "s3723315@student.rmit.edu.au";
    realName = "Sam Nolan";
    signature = {
      showSignature = "append";
      text = ''
        Best Regards
        Sam Nolan
      '';
    };
    userName = "s3723315@student.rmit.edu.au";
    imap = {
      host = "outlook.office365.com";
      port = 993;
      tls.enable = true;
    };
    passwordCommand = "pass RMIT";
    offlineimap = {
      extraConfig.remote = {
        realdelete = false;
        folderfilter = ''lambda foldername: foldername in [
             'INBOX', 'Sent Items']
        '';
      };
      enable = true;
    };
    smtp = {
      port = 465;
      host = "smtp.office365.com";
      tls.enable = true;
    };
    notmuch.enable = true;
    neomutt.enable = true;
    msmtp.enable = true;
    folders.inbox = "INBOX";


  };

  accounts.email.accounts.gmail = {
    address = "samnolan555@gmail.com";
    flavor = "gmail.com";
    primary = true;
    realName = "Sam Nolan";
    signature = {
      showSignature = "append";
      text = ''
        Best Regards
        Sam Nolan
      '';
    };
    passwordCommand = "pass Internet/Google";
    offlineimap = {
      extraConfig.remote = {
        auth_mechanisms = "XOAUTH2";
        oauth2_client_id = "967969414852-slfb2editmshegfk82pubt0krcvnvum2.apps.googleusercontent.com";
        oauth2_client_secret_eval = "get_pass('gmail', ['pass', 'organizer client secret'])";
        oauth2_request_url = "https://accounts.google.com/o/oauth2/token";
        oauth2_refresh_token_eval = "get_pass('gmail', ['pass', 'organizer refresh token'])";
      };
      enable = true;
    };
    smtp = {
      port = 465;
      host = "smtp.gmail.com";
      tls.enable = true;
    };
    folders.inbox = "INBOX";
    notmuch.enable = true;
    msmtp.enable = true;
    neomutt.enable = true;
  };
  programs.notmuch.enable = true;
  programs.msmtp.enable = true;

  programs.emacs = {
    enable = true;
  };
  services.emacs = {
    enable = true;
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";
}
