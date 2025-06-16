#!/bin/bash
#════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
#	     _____ __________  ________  ______   _____   ____________
#	    / ___// ____/ __ \/  _/ __ \/_  __/  /  _/ | / / ____/ __ \
#	    \__ \/ /   / /_/ // // /_/ / / /     / //  |/ / /_  / / / /
#	   ___/ / /___/ _, _// // ____/ / /    _/ // /|  / __/ / /_/ /
#	  /____/\____/_/ |_/___/_/     /_/    /___/_/ |_/_/    \____/
#════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
#	AUTH: John Smith (FLT)
#	DATE: 2024-10-26
#	VERS: 0.5.0
#	DESC: Get Genshin Impact Wish URL for uploading to paimon.moe and ZZZ Signal URL for rng.moe
#	LINK: https://gamebanana.com/scripts/12245 (Script documentation on GameBanana)
#	LISC: GPLv3 (https://www.gnu.org/licenses/gpl.html)
#	CHANGELOG: (Date - Changes)
#		2024-10-26 - Initial Commit
#		2024-11-20 - Update to Banner Version 5.2 Phase 1
#		2024-12-31 - Update to Banner Version 5.3 Phase 1
#		2025-01-10 - Add support for ZZZ and an auto-detect feature for the latest DATA_2 PATH (Ex. Auto-Detect: 2.33.0.0, 2.XX.0.0) | Added GPLv3 License link.
#		2025-03-04 - Add a link to the script documentation on GB
#		2025-06-16 - Refactored for better readability, code cleanup for improved maintainability and for any possible future expansion.

#════════════════════════
#════════ Colors ════════
#════════════════════════
COLOR_NO="\e[0m"
COLOR_RED="\e[1;31m"
COLOR_GRE="\e[1;32m"
COLOR_YEL="\e[1;33m"
COLOR_BLU="\e[1;34m"
COLOR_MAG="\e[1;35m"
COLOR_CYA="\e[1;36m"
COLOR_GRA="\e[1;37m"

#═══════════════════════════
#════════ Functions ════════
#═══════════════════════════
help_me() {
	echo "This script is a little helper for getting your pull history of Genshin for paimon.moe or the Zenless Zone Zero one for rng.moe. Just modify path in Variable sections and run this script like this:
	
  For Genshin:
    ./this_script_name.sh g
	
  For Zenless Zone Zero:
    ./this_script_name.sh z"

	exit 0
}

spacer() {
	column_count="$(tput cols)"
	for i in $(seq $column_count); do
		echo -n "═"
	done
	echo
}

get_lastest_folder() {
	local game_folder="$1"
	echo "$game_folder"/$(find "$game_folder" -maxdepth 1 -type d -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d " " | rev | cut -d "/" -f 1 | rev)/Cache/Cache_Data/data_2
}

choose_url() {
	if [[ $1 == g ]]; then
		echo $(grep -a "https://gs.hoyoverse.com/genshin/event/e20190909gacha-v3/.*hk4e_global" "$data_2_folder" | strings | grep "https://gs.hoyoverse.com/genshin/event/e20190909gacha-v3/.*hk4e_global" | tail -1 | sed -n "s:1/0/::p")
	elif [[ $1 == z ]]; then
		echo $(grep -a "https.*getGachaLog" "$data_2_folder" | strings | grep "https.*getGachaLog" | tail -1 | sed -n "s:1/0/::p")
	fi
}

get_history() {
	if [[ $1 == g ]]; then
		local folder="$PATH_GENSHIN"
		local game='Genshin'

	elif [[ $1 == z ]]; then
		local folder="$PATH_ZENLESS"
		local game='Zenless'
	fi

	data_2_folder=$(get_lastest_folder "$folder")


	spacer
	echo -e "${COLOR_CYA}Getting ${COLOR_GRA}${game} ${COLOR_CYA}url from data_2_folder and copying to clipboard.${COLOR_NO}"
	echo -e "Last Modified: ${COLOR_MAG}$(stat -c %y "$data_2_folder" | cut -c -16)${COLOR_NO}"
	spacer
	echo -en "${COLOR_YEL}"
	choose_url g
	echo -en "${COLOR_NO}"
	spacer
	choose_url | xsel -b
	echo -e "${COLOR_GRE}Link copied to clipboard!${COLOR_NO}"
	spacer
	exit 0
}

#═══════════════════════════
#════════ Variables ════════
#═══════════════════════════

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
# CHANGE THIS TO YOUR ACTUAL FILEPATH  #
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
PATH_GENSHIN=$HOME/Games/Files/Genshin\ Impact/GenshinImpact_Data/webCaches
PATH_ZENLESS=$HOME/Games/Files/ZenlessZoneZero\ Game/ZenlessZoneZero_Data/webCaches

#═════════════════════════════
#════════ Main Script ════════
#═════════════════════════════
if [[ -z $1 ]]; then
	help_me
elif [[ $1 == g ]]; then
	get_history g
elif [[ $1 == z ]]; then
	get_history z
elif [[ $1 == 'help' ]]; then
	help_me
else
	help_me
fi
