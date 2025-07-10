# Make dir, then cd into it
mcd() {
	mkdir -p "$@";
	builtin cd "$@";
}

# cd = cd + ls
cd() {
	builtin cd "$@" && ls
}

# keyd shortcuts
keymap() {
	if [[ $@ == "-r" ]]; then
		sudo keyd reload
	else
		sudo vim /etc/keyd/default.conf
	fi
}

# Create and activate a Python virtual environment
mkvenv() {
	if [ -z "$1" ]; then
		echo "Usage: mkenv PROJECT_NAME"
		return 1
	fi

	local project_name="$1"

	# Check if directory already exists
	if [ -d "$project_name" ]; then
		if [ -f "$project_name/bin/activate" ]; then
			echo "Directory '$project_name' already exists. Activating."
			source "$project_name/bin/activate"
		else
			echo "Directory '$project_name' exists but is not a venv."
			return 1
		fi
	else
		# Create the virtual environment
		echo "Creating virtual environment: $project_name"
		python3 -m venv "$project_name"

		# Check if creation was successful
		if [$? -eq 0 ]; then
			echo "Activating virtual environment..."
			source "$project_name/bin/activate"
			echo "Virtual environment '$project_name' activated"
		else
			echo "failed to create virtual environment"
			return 1
		fi
	fi
}

