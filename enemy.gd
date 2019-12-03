extends Area2D

# Declare member variables here. Examples:
var selected = false
var health = 100
onready var healthBar = get_node("health")



# Called when the node enters the scene tree for the first time.
func _ready():
	$health.set_visible(false)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_enemy_mouse_entered():
	get_node("Particles2D").emitting = true
	

func _on_enemy_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed == true:
			if selected == false:
				selected = get_node("Particles2D").emitting
				health -= 10
				healthBar.set_value(health)
				selected = true
			else:
				selected = false
			get_node("Particles2D").emitting = selected


func _on_enemy_mouse_exited():
	get_node("Particles2D").emitting = false
