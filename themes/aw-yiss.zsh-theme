# "aw-yiss" theme
# Brittany Welsh 2016
# Based off theme "ys" by Yad Smood (https://github.com/ysmood)
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$terminfo[bold]$fg[blue]%}on "
YS_VCS_PROMPT_PREFIX2=":%{$terminfo[bold]$fg[yellow]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}✗"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}✔"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

local exit_code="%(?,,exit:%{$fg[red]%}%?%{$reset_color%} )"

##################
# Prompt format: #
##################
# [TIME] PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE
# LAST_EXIT_CODE ➜ COMMAND
#
# For example:
#
# [21:47:42] bmw@funky-town in ~/.oh-my-zsh on git:master ✗
# ➜ 

PROMPT="
%{$terminfo[bold]$fg[blue]%}[%*]%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[green]%}%n)\
%{$fg[green]%}@%m\
%{$terminfo[bold]$fg[blue]%} in %{$reset_color%}\
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info} \

$exit_code\
%{$terminfo[bold]$fg[blue]%}➜  %{$reset_color%}"
