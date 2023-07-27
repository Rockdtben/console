// Copied from tgstation13.

#define ADMIN_SPAWN_CAP 100

/proc/make_types_fancy(list/types)
	if (ispath(types))
		types = list(types)
	. = list()
	for(var/type in types)
		var/typename = "[type]"
		var/static/list/TYPES_SHORTCUTS = list(
			/obj/signal = "signal",
			/obj/items = "items"
		)
		for (var/tn in TYPES_SHORTCUTS)
			if(copytext(typename, 1, length("[tn]/") + 1) == "[tn]/" /*findtextEx(typename,"[tn]/",1,2)*/ )
				typename = TYPES_SHORTCUTS[tn] + copytext(typename, length("[tn]/"))
				break
		.[typename] = type

/proc/get_fancy_list_of_atom_types()
	var/static/list/pre_generated_list
	if (!pre_generated_list) //init
		pre_generated_list = make_types_fancy(typesof(/atom))
	return pre_generated_list
/proc/filter_fancy_list(list/L, filter as text)
	var/list/matches = new
	var/end_len = -1
	var/list/endcheck = splittext(filter, "!")
	if(endcheck.len > 1)
		filter = endcheck[1]
		end_len = length_char(filter)

	for(var/key in L)
		var/value = L[key]
		if(findtext("[key]", filter, -end_len) || findtext("[value]", filter, -end_len))
			matches[key] = value
	return matches
//Returns a string with reserved characters and spaces before the first word and after the last word removed.
/proc/trim(text, max_length)
	if(max_length)
		text = copytext_char(text, 1, max_length)
	return trim_reduced(text)

//Returns a string with reserved characters and spaces after the first and last letters removed
//Like trim(), but very slightly faster. worth it for niche usecases
/proc/trim_reduced(text)
	var/starting_coord = 1
	var/text_len = length(text)
	for (var/i in 1 to text_len)
		if (text2ascii(text, i) > 32)
			starting_coord = i
			break

	for (var/i = text_len, i >= starting_coord, i--)
		if (text2ascii(text, i) > 32)
			return copytext(text, starting_coord, i + 1)

	if(starting_coord > 1)
		return copytext(text, starting_coord)
	return ""

	//When we get into galloping mode, we stay there until both runs win less often than MIN_GALLOP consecutive times.
#define MIN_GALLOP 7

//This is a global instance to allow much of this code to be reused. The interfaces are kept separately
/datum/sort_instance
	//The array being sorted.
	var/list/L

	//The comparator proc-reference
	var/cmp = GLOBAL_PROC_REF(cmp_numeric_asc)

	//whether we are sorting list keys (0: L[i]) or associated values (1: L[L[i]])
	var/associative = 0

	//This controls when we get *into* galloping mode.  It is initialized to MIN_GALLOP.
	//The mergeLo and mergeHi methods nudge it higher for random data, and lower for highly structured data.
	var/minGallop = MIN_GALLOP

	//Stores information regarding runs yet to be merged.
	//Run i starts at runBase[i] and extends for runLen[i] elements.
	//runBase[i] + runLen[i] == runBase[i+1]
	var/list/runBases = list()
	var/list/runLens = list()

/// Create a typed global with an initializer expression
#define GLOBAL_DATUM_INIT(X, Typepath, InitValue) GLOBAL_RAW(Typepath/##X); GLOBAL_MANAGED(X, InitValue)

// See initialization order in /code/game/world.dm
GLOBAL_REAL(GLOB, /datum/controller/global_vars)


///Returns a chosen path that is the closest to a list of matches
/proc/pick_closest_path(value, list/matches = get_fancy_list_of_atom_types())
	if (value == FALSE) //nothing should be calling us with a number, so this is safe
		value = input("Enter type to find (blank for all, cancel to cancel)", "Search for type") as null|text
		if (isnull(value))
			return
	value = trim(value)

	var/random = FALSE
	if(findtext(value, "?"))
		value = replacetext(value, "?", "")
		random = TRUE

	if(!isnull(value) && value != "")
		matches = filter_fancy_list(matches, value)

	if(matches.len == 0)
		return

	var/chosen
	if(matches.len == 1)
		chosen = matches[1]
	else if(random)
		chosen = pick(matches) || null
	else
		chosen = input("Select a type", "Pick Type", matches[1]) as null|anything in matches
	if(!chosen)
		return
	chosen = matches[chosen]
	return chosen
