mob
	admin
		verb
			Spawn(object as text)
				set category = "Admin"
				set desc = "(atom path) Spawn an atom"
				set name = "Spawn"

				// if(!check_rights(R_SPAWN) || !object)
				// 	return

				var/list/preparsed = splittext(object,":")
				var/path = preparsed[1]
				var/amount = 1
				if(preparsed.len > 1)
					amount = clamp(text2num(preparsed[2]),1,ADMIN_SPAWN_CAP)

				var/chosen = pick_closest_path(path)
				if(!chosen)
					return
				var/turf/T = get_turf2(usr)

				for(var/i in 1 to amount)
					new chosen(T)
