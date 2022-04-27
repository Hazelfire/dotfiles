fish_vi_key_bindings
set fish_greeting
export EDITOR=nvim;
export BROWSER=firefox;

function irn
  i3 rename workspace to $argv
end

function viewpdf
  pdftotext -layout $argv - | less
end

function hubaddcollab
  hub api -i -X PUT "repos/{owner}/{repo}/collaborators/$argv"
end

alias cf=cf-tool
eval (direnv hook fish)

function autotmux --on-variable TMUXP_ACTIVATE
  if test -n "$TMUXP_ACTIVATE" #only if set
    if test -z $TMUX #not if in TMUX
      tmuxp load . -y
    end
  end
end

alias o='a -e xdg-open' # quick opening files with xdg-open
alias rm='rm -i'
alias cp='cp -i'
alias gcal='gcalcli --default-calendar samnolan555@gmail.com'
alias htime='hledger -f ~/.hledger/time.journal'
