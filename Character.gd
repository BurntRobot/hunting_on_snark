extends Sprite

export(String) var character_name
export(String, "Fast", "Stealthy") var reaction = "Fast"
export(String, "Strong", "Tough") var build = "Strong"
export(String, "Lucky", "Sensitive") var mind = "Lucky"
export(String, "Hero", "Mob", "Boss") var character_type = "Hero"

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
	self.set_reaction_stats()
	self.set_build_stats()
	self.set_mind_stats()
	self.set_health()

func set_reaction_stats():
	if self.reaction == "Fast":
		self.steps = 2
		self.noise = 2
	elif self.reaction == "Stealthy":
		self.steps = 1
		self.noise = 1

func set_build_stats():
	if self.build == "Strong":
		self.attack = 3
		self.defense = 1
	elif self.build == "Tough":
		self.attack = 1
		self.defense = 3

func set_mind_stats():
	if self.mind == "Lucky":
		self.sight_radius = 2
		self.boojum_radar = 1/2
		self.miss = 1
		self.joker = 1
	elif self.mind == "Sensitive":
		self.sight_radius = 3
		self.boojum_radar = 2/3
		self.miss = 2
		self.joker = 0

func set_health():
	if self.character_type == "Hero":
		self.health = 3
	else:
		self.health = 1
