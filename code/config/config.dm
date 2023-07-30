var/list/config

world/proc/LoadConfig()
	world.log << "Config Loading"
	var/json = file2text("config/server.json")
	if (!json)
		LoadDefaultConfig()
		var/json_file = file("config/server.json")
		if (!fexists(json_file))
			world.log << "Failed to load config.json File likely corrupt."
			return
		return
	config = json_decode(json)
	world.log << "Config Loaded"
	return 0
world/proc/LoadDefaultConfig()
	config = new/list()
	config["loglabsaving"] = 0
