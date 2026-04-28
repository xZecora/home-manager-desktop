{ pkgs, config, ... }:
{
	programs.direnv = {
		enable = true;
		enableZshIntegration = true;
		nix-direnv.enable = true;
	};

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    dotDir = "${config.xdg.configHome}/zsh";

    history = {
      path = "${config.xdg.cacheHome}/zsh/zsh_history";
      save = 1000000;
    };

    initContent = ''
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
    ZSH_AUTOSUGGEST_USE_ASYNC=1

      PROMPT='%{$fg[red]%}[%{$fg[green]%}%n%{$fg[yellow]%}@%{$fg[blue]%}%m %{$fg[cyan]%}%1~%{$fg_bold[magenta]%}$(git_prompt_info)%{$reset_color$fg[red]%}]%{$reset_color%}%# '
      ZSH_THEME_GIT_PROMPT_PREFIX=" ("
      ZSH_THEME_GIT_PROMPT_SUFFIX=")"
      ZSH_THEME_GIT_PROMPT_DIRTY="*"
      ZSH_THEME_GIT_PROMPT_CLEAN=""

      zmodload zsh/zprof

      zstyle ':completion:*' menu select
      zstyle ':completion:*' special-dirs false

      any-nix-shell zsh --info-right | source /dev/stdin
      export PATH="$PATH:$HOME/.local/bin:$HOME/.local/bin/custom_binaries/ratpoison:$HOME/.local/bin/audio" # I have scripts here

      setopt globdots
      setopt extended_glob
      setopt auto_menu
      setopt menu_complete

      #compdef ng
      ###-begin-ng-completions-###
      #
      # yargs command completion script
      #
      # Installation: ng completion >> ~/.zshrc
      #    or ng completion >> ~/.zprofile on OSX.
      #

      _ng_yargs_completions()
      {
        local reply
        local si=$IFS
        IFS=$'
      ' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" ng --get-yargs-completions "$\{words[@]\}"))
        IFS=$si
        _describe 'values' reply
      }
      compdef _ng_yargs_completions ng
      ###-end-ng-completions-###

      autoload -Uz compinit
      if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.config/zsh.zcompdump 2>/dev/null)" ]; then
        compinit
      else
        compinit -C
      fi
    '';

    shellAliases = {
      rat = "startx ~/.xinitrc ratpoison"; # I don't wanna type all this to start my x server, I normally have more wm's
      zwm = "startx ~/.xinitrczwm"; # I don't wanna type all this to start my x server, I normally have more wm's
      ":q" = "exit"; # sometimes I do this from vim habit so might as well make it work

      ls = "eza -la --icons --color=auto"; # eza gang
      cat="bat";
      grep="rg";

      poweroff="sudo poweroff";
      reboot="sudo reboot";
      cd = "z";

      lsblk = "lsblk | bat -l conf -p";
      
      tags = "ctags --recurse=yes --exclude=.git --exclude=build --exclude=.cache --exclude=.ccls-cache";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" "sudo" "zoxide" "direnv" ];
    };
  };

  home.packages = with pkgs; [
    fzf
    zoxide
  ];
}
