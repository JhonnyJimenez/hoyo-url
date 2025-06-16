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
#	VERS: 0.4.1
#	DESC: Get Genshin Impact Wish URL for uploading to paimon.moe and ZZZ Signal URL for rng.moe
#	LINK: https://gamebanana.com/scripts/12245 (Script documentation on GameBanana)
#	LISC: GPLv3 (https://www.gnu.org/licenses/gpl.html)
#	CHANGELOG: (Date - Changes)
#		2024-10-26 - Initial Commit
#		2024-11-20 - Update to Banner Version 5.2 Phase 1
#		2024-12-31 - Update to Banner Version 5.3 Phase 1
#		2025-01-10 - Add support for ZZZ and an auto-detect feature for the latest DATA_2 PATH (Ex. Auto-Detect: 2.33.0.0, 2.XX.0.0) | Added GPLv3 License link.
#		2025-03-04 - Add a link to the script documentation on GB

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
HELP_ME() {
	echo "This is a help function."
	exit 0
}

SPACER() {
	COLUMN_COUNT="$(tput cols)"
	for i in $(seq $COLUMN_COUNT); do
		echo -n "═"
	done
	echo
}

URL_GENSHIN() {
	SPACER
	DATA_2_GENSHIN=${PATH_GENSHIN}/$(find "${PATH_GENSHIN}" -maxdepth 1 -type d -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d " " | rev | cut -d "/" -f 1 | rev)/Cache/Cache_Data/data_2
	echo -e "${COLOR_CYA}Getting ${COLOR_GRA}Genshin ${COLOR_CYA}url from data_2 and copying to clipboard.${COLOR_NO}"
	echo -e "Last Modified: ${COLOR_MAG}$(stat -c %y "$DATA_2_GENSHIN" | cut -c -16)${COLOR_NO}"
	SPACER
	echo -en "${COLOR_YEL}"
	grep -a "https://gs.hoyoverse.com/genshin/event/e20190909gacha-v3/.*hk4e_global" "$DATA_2_GENSHIN" | strings | grep "https://gs.hoyoverse.com/genshin/event/e20190909gacha-v3/.*hk4e_global" | tail -1 | sed -n "s:1/0/::p"
	echo -en "${COLOR_NO}"
	SPACER
	grep -a "https://gs.hoyoverse.com/genshin/event/e20190909gacha-v3/.*hk4e_global" "$DATA_2_GENSHIN" | strings | grep "https://gs.hoyoverse.com/genshin/event/e20190909gacha-v3/.*hk4e_global" | tail -1 | sed -n "s:1/0/::p" | xsel -b
	echo -e "${COLOR_GRE}Link copied to clipboard!${COLOR_NO}"
	SPACER
	exit 0
}

URL_ZENLESS() {
	SPACER
	DATA_2_ZENLESS=${PATH_ZENLESS}/$(find "${PATH_ZENLESS}" -maxdepth 1 -type d -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d " " | rev | cut -d "/" -f 1 | rev)/Cache/Cache_Data/data_2
	echo -e "${COLOR_CYA}Getting ${COLOR_GRA}Zenless ${COLOR_CYA}url from data_2 and copying to clipboard.${COLOR_NO}"
	echo -e "Last Modified: ${COLOR_MAG}$(stat -c %y "$DATA_2_ZENLESS" | cut -c -16)${COLOR_NO}"
	SPACER
	echo -en "${COLOR_YEL}"
	grep -a "https.*getGachaLog" "$DATA_2_ZENLESS" | strings | grep "https.*getGachaLog" | tail -1 | sed -n "s:1/0/::p"
	echo -en "${COLOR_NO}"
	SPACER
	grep -a "https.*getGachaLog" "$DATA_2_ZENLESS" | strings | grep "https.*getGachaLog" | tail -1 | sed -n "s:1/0/::p" | xsel -b
	echo -e "${COLOR_GRE}Link copied to clipboard!${COLOR_NO}"
	SPACER
	exit 0
}

#═══════════════════════════
#════════ Variables ════════
#═══════════════════════════

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# CHANGE THIS TO YOUR ACTUAL FILEPATH
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
PATH_GENSHIN=$HOME/Games/Files/Genshin\ Impact\ game/GenshinImpact_Data/webCaches
PATH_ZENLESS=$HOME/Games/Files/ZenlessZoneZero\ Game/ZenlessZoneZero_Data/webCaches

#═════════════════════════════
#════════ Main Script ════════
#═════════════════════════════
if [[ -z $1 ]]; then
	URL_GENSHIN
elif [[ $1 == g ]]; then
	URL_GENSHIN
elif [[ $1 == z ]]; then
	URL_ZENLESS
else
	HELP_ME
fi
