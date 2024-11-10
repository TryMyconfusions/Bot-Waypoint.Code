extends CharacterBody2D

# this is probably good if you dont want to use pathfinding but if you want the bot to go to more places 
# you will have to add more waypoints

@onready var points = []
@onready var Duration = 2
@onready var TotalPoints = 3
@onready var rng = RandomNumberGenerator.new()
@onready var rng2 = RandomNumberGenerator.new()
func GotoPoint():
	await get_tree().create_timer(3).timeout
	while true:
		var tween = create_tween()
		var randompoint = points[rng.randi_range(1,TotalPoints) - 1]
		var pos = randompoint.position
		tween.tween_property(self,"position",pos,Duration)
		randompoint.texture = load("res://TrailDotBotChosen.png") #changes the texture when the bot chooses 
		# the way point
		
		await get_tree().create_timer(Duration).timeout
		tween.stop()
		var random = rng2.randi_range(1,3)
		await get_tree().create_timer(random).timeout
		randompoint.texture = load("res://TrailDot.png") #changes the texture when the bot chooses another waypoint

func _ready():
	points.append(get_parent().get_node("Point1"))#adds waypoint1 
	points.append(get_parent().get_node("Point2"))#adds waypoint2
	points.append(get_parent().get_node("Point3"))#adds waypoint3
	
	
	await get_tree().create_timer(2).timeout # waits 2 seconds for it to load
	
	GotoPoint() #starts the process
