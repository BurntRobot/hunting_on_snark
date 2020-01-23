extends Sprite

export(String) var character_name
export(String, "Fast", "Stealthy") var reaction
export(String, "Strong", "Tough") var build
export(String, "Lucky", "Sensitive") var mind
export(String, "Hero", "Mob", "Boss") var character_type

var steps
var noise
var sight_radius
var boojum_radar
var attack
var defense
var miss
var joker
var health

func _ready():
	get_reaction_stats()
	get_build_stats()
	get_mind_stats()
	get_health()

func get_reaction_stats():
	if reaction == "Fast":
		steps = 2
		noise = 2
	elif reaction == "Stealthy":
		steps = 1
		noise = 1

func get_build_stats():
	if build == "Strong":
		attack = 3
		defense = 1
	elif build == "Tough":
		attack = 1
		defense = 3

func get_mind_stats():
	if mind == "Lucky":
		sight_radius = 2
		boojum_radar = 1/2
		miss = 1
		joker = 1
	elif mind == "Sensitive":
		sight_radius = 3
		boojum_radar = 2/3
		miss = 2
		joker = 0

func get_health():
	if character_type == "Hero":
		health = 3
	else:
		health = 1
