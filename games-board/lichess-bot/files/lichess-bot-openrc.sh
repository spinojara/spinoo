#!/sbin/openrc-run
command_background="yes"
pidfile="/var/run/lichess-bot.pid"
name="lichess-bot"
description="lichess-bot - A bridge between Lichess bots and chess engines"
directory="/var/lib/lichess-bot"
command="lichess-bot"
command_args="--config /etc/lichess-bot.yml"
output_log="/var/log/lichess-bot.log"
error_log="/var/log/lichess-bot.err"
supervisor="supervise-daemon"

retry="SIGINT/5"

depend() {
	need net
}

start_pre() {
	if [ ! -f "/etc/lichess-bot.yml" ]; then
		eerror "Expected configuration file at /etc/lichess-bot.yml"
		return 1
	fi
	if [ ! -d "/var/lib/lichess-bot" ]; then
		eerror "Expected directory at /var/lib/lichess-bot"
		return 1
	fi
	return 0
}
