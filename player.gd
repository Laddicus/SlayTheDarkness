extends Node2D

# Declare member variables here. Examples:
var health = 100
signal dead

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _check_Death():
	if health <= 0:
		emit_signal("dead")

func _on_player_mouse_entered():
	#health -= 10
	#get_node("health").set_value(health)
	pass # Replace with function body.
