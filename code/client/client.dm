#define MOUSE_LEFT  1	// left click
#define MOUSE_RIGHT 2	// right click
#define MOUSE_MIDDLE	4	// middle click


client
	var/mouses_down = 0	  //variable for what keys are being held down
	command_text = "say "
	New()
		winset(src,null,"reset=true")
		winset(src,"default","is-maximized=true")
		world << "<B>[src] has logged in! [time2text(world.time, "DDD DD MMM (MM), YYYY - hh:mm:ss")]</B>"
		world.log << "<B>[src] has logged in! [time2text(world.time, "DDD DD MMM (MM), YYYY - hh:mm:ss")]</B>"
		src << "<font color=blue>Version: [n_version][n_sub]</font>"
		src << "<font color=red>Welcome to console [n_version][n_sub] -- Click <a href=?changes>here</a> for a list of changes."
		var/old_mob = src.mob
		if ((!( fexists("saves/players/[src.ckey].sav") ) || alert(src, "Would you like to load your old character? Warning a No will delete your current one!", "Console Saving", "Yes", "No", null) == "No"))
			..()
			new /obj/items/wirecutters( src.mob )
			new /obj/signal/computer/laptop( src.mob )
			new /obj/items/watch( src.mob )
			new /obj/items/toolbox( src.mob )
			new /obj/items/pen( src.mob )
			new /obj/items/GPS( src.mob )
			src.mob.save_version = "[n_version][n_sub]"
			//src.mob.saving = "yes"
		else
			var/savefile/F = new("saves/players/[src.ckey].sav")
			F >> src.mob
			if (old_mob)
				del(old_mob)
			if (!( locate(/obj/items/wirecutters, src.mob) ))
				new /obj/items/wirecutters( src.mob )
			if (!( locate(/obj/items/GPS, src.mob) ))
				new /obj/items/GPS( src.mob )
			//src.mob.saving = "yes"
		if((ckey in admins))
			for(var/V in typesof(/mob/admin/verb))
				mob.verbs += V
			for(var/H in typesof(/mob/Host/verb))
				mob.verbs += H
		else
			var/host_file_key
			if(fexists("config/host.txt"))
				host_file_key = file2text("config/host.txt")
			if((host_file_key && ckey(host_file_key) == src.ckey) || world.host == src.key || src.address == world.address || !src.address)
				for(var/H in typesof(/mob/Host/verb))
					mob.verbs += H


	Del()
		if ((src.mob && src.mob.saving == "yes"))
			var/savefile/F = new /savefile( "saves/players/[src.ckey].sav" )
			F << src.mob
		world << "<B>[src] has logged out! [time2text(world.time, "DDD DD MMM (MM), YYYY - hh:mm:ss")]</B>"
		world.log << "<B>[src] has logged out! [time2text(world.time, "DDD DD MMM (MM), YYYY - hh:mm:ss")]</B>"
		del(src.mob)
		..()

	MouseDown(atom/object,location,control,params)
		var/list/pref = params2list(params)
		if("left" in pref)
			mouses_down |= MOUSE_LEFT
		if("right" in pref)
			mouses_down |= MOUSE_RIGHT
		if("middle" in pref)
			mouses_down |= MOUSE_MIDDLE

		var/thisX = object.x
		var/thisY = object.y
		var/diffX = thisX - src.mob.x
		var/diffY = thisY - src.mob.y

		var absX = abs(diffX)
		var absY = abs(diffY)

		if (absX == 0 && absY == 0)
			src.mob.dir = SOUTH
		else if (absX > absY)
			// X
			if (diffX > 0)
				src.mob.dir = EAST
			else
				src.mob.dir = WEST
		else
			//Y
			if (diffY > 0)
				src.mob.dir = NORTH
			else
				src.mob.dir = SOUTH
		..()

	MouseUp(object,location,control,params)
		var/list/pref = params2list(params)
		if("left" in pref)
			mouses_down &= ~MOUSE_LEFT
		if("right" in pref)
			mouses_down &= ~MOUSE_RIGHT
		if("middle" in pref)
			mouses_down &= ~MOUSE_MIDDLE
		..()
