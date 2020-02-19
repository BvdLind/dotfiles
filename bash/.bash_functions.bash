md() {
  mkdir -p "$1"
  cd "$1" || exit
}

cl() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null || exit; ls
	else
		echo "bash: cl: $dir: Directory not found"
	fi
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=("$(fzf-tmux --query="$1" --multi --select-1 --exit-0)")
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fuzzy grep open via ag
vg() {
  local file

  file="$(ag --nobreak --noheading "$@" | fzf -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]]
  then
     vim "$file"
  fi
}

# fuzzy grep open via ag with line number
vg() {
  local file
  local line

  read -r file line <<<"$(ag --nobreak --noheading "$@" | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim "$file" + "$line"
  fi
}

# fd - cd to selected directory
# fd() {
  # local dir
  # dir=$(find ${1:-.} -path '*/\.*' -prune \
                  # -o -type d -print 2> /dev/null | fzf +m) &&
  # cd "$dir"
# }

# fda - including hidden directories
fda() {
  local dir
  dir=$(find "${1:-.}" -type d 2> /dev/null | fzf +m) && cd "$dir" || exit
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs "$(dirname "$1")"
    fi
  }
  local DIR="$(get_parent_dirs "$(realpath "${1:-$PWD}")" | fzf-tmux --tac)"
  cd "$DIR" || exit
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
cf() {
  local file

  file="$(locate -Ai -0 "$@" | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- "$file" || exit
     else
        cd -- "${file:h}" || exit
     fi
  fi
}

fh() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | runcmd
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo "$pid" | xargs kill -"${1:-9}"
    fi
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout "$(echo "$branch" | awk '{print $1}' | sed "s/.* //")"
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout "$(echo "$branch" | awk '{print $1}' | sed "s/.* //")"
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\\{7\\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fcoc_preview - checkout git commit with previews
fcoc_preview() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n "$(echo "$commit" | sed "s/ .*//")"
}

# fgst - pick files from `git status -s`
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fgst() {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  local cmd="${FZF_CTRL_T_COMMAND:-"command git status -s"}"

  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while read -r item; do
    echo "$item" | awk '{print $2}'
  done
  echo
}

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2
  ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}

gopen() {
    project=$(git config --local remote.origin.url | sed s/git@github.com\:// | sed s/\.git//)
    url="${project/hub/github}"
    xdg-open $url
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

gi() { curl -sL https://www.gitignore.io/api/$@ ;}

getOneTabData() {
  cat ~/.mozilla/firefox/g1dmk357.default/browser-extension-data/extension@one-tab.com/storage.js
}

# copyOnetabDataIfNotCorrupted() {
 # state="$(jq '.state' /home/bas/.mozilla/firefox/g1dmk357.default/browser-extension-data/extension@one-tab.com/storage.js | tr -d '\\\"')"
 # if [[ ${state} != "{tabGroups:[]}" ]]; then
   # cat /home/bas/.mozilla/firefox/g1dmk357.default/browser-extension-data/extension@one-tab.com/storage.js > /home/bas/oneTabExport
 # fi
# }

extractUrlsFromOnetabJSON() {
  json="$(jq '.state' "$1" | tr -d ' \\')"
  json="${json:1:-1}"
  touch ~/tmpStorage
  echo "${json}" > ~/tmpStorage
  # jq '' ~/tmpStorage 2> /dev/null ||
    # (echo "fix bad characters in export and try again" && echo ${json} > sanitizedOnetabExport && return 1)
  jq '' ~/tmpStorage 2> /dev/null || echo "fix bad characters in export and try again" && echo "${json}" > onetabExportNeedsFixing && return 1
 # jq '.tabGroups[]."tabsMeta"[]."url"' | cat $1 | tr -d '\\'  | tr -d '"'
  extractUrlsSanitizedOnetabExport ~/tmpStorage
}

extractUrlsSanitizedOnetabExport() {
  jq '.tabGroups[]."tabsMeta"[]."url"' "$1" | tr -d '\"' > sanitizedOnetabExport
  rm ~/tmpStorage onetabExportNeedsFixing
}

log() {
  day=$(date '+%d')
  month=$(date '+%m')
  year=$(date '+%Y')

  logDir="${HOME}/Documents/log/${year}/${month}"

  mkdir -p "${logDir}"
  ymd="${year}-${month}-${day}"
  logFile="${logDir}/${ymd}.journal"
  touch "${logFile}"
  [ "$(wc -l < "$logFile")" -eq 0 ] && printf "# ${ymd}\\n" >> "${logFile}"
  printf "\\n## $(date '+%T')\\n\\n" >> "${logFile}"
  if [ "${EDITOR}" == "vim" ]; then
   vim + "${logFile}"
  else
   "${EDITOR} ${logFile}"
  fi
}
