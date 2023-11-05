#!/usr/bin/env sh

# get config
. ~/.config/dmenu/config.sh

NEWLINE="
"

fullpath() {
	name="$(sh -c "echo $1")"
	path="$2"
	c="$(echo "$name" |cut -b1)"

	if [ "$c" = "/" ]; then
		full="$name"
	else
		full="$path/$name"
	fi
	realpath "$full"

}

main() {
	target="$1"
	[ -z "$target" ] && target="$(realpath .)"
	prompt="$2"

	while true; do
		p="$prompt"
		[ -z "$p" ] && p="$target"
		items="$(ls -1a "$target" |grep -v '^\.$' | ${DMENU} "$p" -l 25)"
		ec=$?
		[ "$ec" -ne 0 ] && exit $ec

		# ignore duplicates
		items="$(echo "$items" |sort -u)"

		nitems=$(echo "$items" |wc -l)
		if [ $nitems -eq 1 ]; then
			newt="$(fullpath "$items" "$target")"
			[ ! -e "$newt" ] && continue
			if [ -d "$newt" ]; then
				target="$newt"
				continue
			fi
		fi
		IFS="$NEWLINE"
		for item in $items; do
			item="$(fullpath "$item" "$target")"
			[ ! -e "$item" ] && continue
			echo "$item"
		done
		unset IFS
		exit 0
	done
}

main "$@"
