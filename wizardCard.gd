extends Area2D

var selected = false
var damage
signal _on_Card_Selected(damage)
signal _on_Card_Deselected(damage)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_rand_damage()
	self.connect("_on_Card_Selected",get_parent().get_parent(),"_on_Card_Selected")
	self.connect("_on_Card_Deselected",get_parent().get_parent(),"_on_Card_Deselected")
	get_parent().get_parent().connect("newTurn",self,"_on_new_turn")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_new_turn():
	_rand_damage()
	selected = false
	get_node("Particles2D").emitting = selected

func _rand_damage():
	damage = int(rand_range(-10,20))
	$damage.set_text(str(damage))

func _on_wizardCard_input_event(viewport, event, shape_idx):
	
	
	if event is InputEventMouseButton:
		$sparkle.play()
		
		if event.pressed == true:
			if selected == false:
				if get_parent().get_parent().selected < get_parent().get_parent().maxCards:
					selected = get_node("Particles2D").emitting
					emit_signal("_on_Card_Selected",damage)
					selected = true
			else:
				selected = false
				emit_signal("_on_Card_Deselected",damage)
			get_node("Particles2D").emitting = selected