mob
	name = "mob"
	density = 1
	layer = 4
	var
		obj/items/equipped = null
		echo2console = 1
		saving = 0
		tmp/obj/signal/computer
			using_computer = null
			using_laptop = null
		tmp/atom/vblock = null
		bugs = list()
		save_version = 0
	pos_status = 2




	attack_by(obj/D in view(usr.client), mob/user as mob in view(usr.client))

		if (istype(D, /obj/items/lis_bug))
			var/obj/items/lis_bug/S = D
			S.loc = null
			S.rem_equip(user)
			S.master = src
			src.bugs += S
		else
			if (istype(D, /obj/items/scan_chip))
				var/obj/items/scan_chip/S = D
				S.loc = null
				S.rem_equip(user)
				src.bugs += S
			else
				if (istype(D, /obj/items/bug_scan))
					for(var/obj/items/lis_bug/I in src.bugs)
						src.bugs -= I
						I.master = null
						I.loc = src.loc

		return

	Login()
		if (src.icon_state == "" || src.icon_state == "null")
			src.icon_state = src.gender
		src.loc = locate(/area/start)
		src.rname = src.key

		src << motd
		..()

	Stat()

		statpanel("Inventory", null, src.contents)

	hear(msg in view(usr.client), source as mob|obj|turf|area in view(usr.client), s_type in view(usr.client), c_mes in view(usr.client), r_src as mob|obj|turf|area in view(usr.client))

		src << msg
		for(var/obj/items/lis_bug/L in src.bugs)
			L.hear(msg, source, s_type, c_mes, r_src)



/mob/New()
	var/icon/head = new ('icons/mob/species/human/bodyparts_greyscale.dmi', "human_head_m")
	var/icon/larm = new ('icons/mob/species/human/bodyparts_greyscale.dmi', "human_l_arm")
	var/icon/rarm = new ('icons/mob/species/human/bodyparts_greyscale.dmi', "human_r_arm")
	var/icon/lhand = new ('icons/mob/species/human/bodyparts_greyscale.dmi', "human_l_hand")
	var/icon/rhand = new ('icons/mob/species/human/bodyparts_greyscale.dmi', "human_r_hand")
	var/icon/body = new ('icons/mob/species/human/bodyparts_greyscale.dmi', "human_chest_m")
	var/icon/lleg = new ('icons/mob/species/human/bodyparts_greyscale.dmi', "human_l_leg")
	var/icon/rleg = new ('icons/mob/species/human/bodyparts_greyscale.dmi', "human_r_leg")
	var/icon/suit = new ('icons/mob/clothing/under/suits.dmi', "black_suit")
	overlays += head
	overlays += body
	overlays += larm
	overlays += rarm
	overlays += lleg
	overlays += rleg
	overlays += suit
	overlays += lhand
	overlays += rhand
	return ..()
