## The prompt below gets ideas from the following:
# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
# http://github.com/adamv/dotfiles/blob/master/bashrc
# http://wiki.archlinux.org/index.php/Color_Bash_Prompt
txtred='\[\e[0;31m\]' # Red
txtwht='\[\e[0;37m\]' # White
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldwht='\[\e[1;37m\]' # White
end='\[\e[0m\]'    # Text Reset

function parse_git {
  if ! type __git_ps1 >/dev/null 2>&1; then
    echo ""
    return 0
  fi

   branch=$(__git_ps1 "%s")
   if [[ -z $branch ]]; then
       return
   fi

   local forward="⟫"
   local behind="⟪"
   local diverged="⦓⦔"
   local dot="•"
   local warn="⚡"

   submodule_pattern_dirty="*"
   submodule_status="$(git submodule summary 2>/dev/null)"

   sub_state=""
   if [[ $submodule_status =~ "*" ]]; then
     sub_state=${bldred}${warn}${end}
   fi

   remote_pattern_ahead="Your branch is ahead of"
   remote_pattern_behind="Your branch is behind"
   remote_pattern_diverge="Your branch and (.*) have diverged"

   status="$(git status 2>/dev/null)"

   state=""
   if [[ $status =~ "working directory clean" ]]; then
       state=${bldgrn}${dot}${end}
   else
       if [[ $status =~ "Untracked files" ]]; then
           state=${bldred}${dot}${end}
       fi
       if [[ $status =~ "Changed but not updated" ]]; then
           state=${state}${bldylw}${dot}${end}
       fi
       if [[ $status =~ "Changes to be committed" ]]; then
           state=${state}${bldylw}${dot}${end}
       fi
   fi

   direction=""
   if [[ $status =~ $remote_pattern_ahead ]]; then
       direction=${bldgrn}${forward}${end}
   elif [[ $status =~ $remote_pattern_behind ]]; then
       direction=${bldred}${behind}${end}
   elif [[ $status =~ $remote_pattern_diverge ]]; then
       direction=${bldylw}${diverged}${end}
   fi

   branch=${bldgrn}${branch}${end}
   git_bit="${bldcyn}[${end}${sub_state}${branch}${sub_state}${state}\
${git_bit}${direction}${bldcyn}]${end}"

   printf "%s" "$git_bit"
}

function set_titlebar {
   case $TERM in
       *xterm*|ansi|rxvt)
           printf "\033]0;%s\007" "$*"
           ;;
   esac
}

function set_prompt {
   git="$(parse_git)"

   PS1="${bldcyn}\u \W${end}"
   if [[ -n "$git" ]]; then
       PS1="$PS1 $git ${bldcyn}\$${end} "
   else
       PS1="$PS1 ${bldcyn}\$${end} "
   fi
   export PS1

   set_titlebar "$USER@${HOSTNAME%%.*} $PWD"
}

export PROMPT_COMMAND=set_prompt
