#Create an ssh wrapper function that renames the new session window with the server name
ssh() {
	if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
	    tmux rename-window "$(echo $* | cut -d . -f 1 | cut -d @ -f 2)"
	    command ssh "$@"
	    tmux set-window-option automatic-rename "on" 1>/dev/null
	else
	    command ssh "$@"
	fi
}
