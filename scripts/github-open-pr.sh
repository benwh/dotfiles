#!/bin/bash

set -euo pipefail

set -x

_get_repo() {
  echo "$1" | sed -e "s/.git$//" -e "s/.*github.com[:/]\(.*\)/\1/"
}

_build_url() {
  # shellcheck disable=SC2039
  local upstream origin branch repo pr_url target

  # upstream="$(git config --get remote.upstream.url)"
  upstream_arg="${2:-no_upstream}"
  use_upstream=false
  if [ "$upstream_arg" != "no_upstream" ]; then
    use_upstream="true";
    upstream="$(git config --get "remote.${upstream_arg}.url")"
  fi

  origin="$(git config --get remote.origin.url)"
  branch="$(git symbolic-ref --short HEAD)"
  repo="$(_get_repo "$origin")"
  pr_url="https://github.com/$repo/pull/new"
  target="${1:-master}"

  test -z "$target" && target=$(git for-each-ref --format='%(upstream:short)' "$(git symbolic-ref -q HEAD)" | cut -d '/' -f 2-)
  test "$target" = "$branch" && target="master"
  test -z "$target" && target="master"
  if [ "$use_upstream" == "true" ]; then
    # shellcheck disable=SC2039
    local origin_name upstream_name
    origin_name="$(echo "$repo" | cut -f1 -d'/')"
    upstream_name="$(_get_repo "$upstream" | cut -f1 -d'/')"
    echo "$pr_url/$upstream_name:$target...$origin_name:$branch"
  else
    echo "$pr_url/$target...$branch"
  fi
}

# TODO: only if not up to date or already pushed?
git pushbranch

url="$(_build_url "$@")"

if [ "$(uname -s)" = "Darwin" ]; then
  open "$url" 2> /dev/null
else
  xdg-open "$url" > /dev/null 2> /dev/null
fi
