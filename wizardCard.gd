extends Area2D

var selected = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_wizardCard_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton:
		if event.pressed == true:
			if selected == false:
				selected = get_node("Particles2D").emitting
				selected = true
			else:
				selected = false
			get_node("Particles2D").emitting = selected