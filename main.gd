extends Node2D

var player_resource
var playerLoc = [100,200,300,400]
var playerY = 300

var enemy_resource
var enemyLoc = [1000,900,800,700]
var enemyY = 300

var card_resource
var cardLoc = [100,200,300,400,500,600,700,800,900]
var cardY = 500

var team

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load players
	player_resource = load("res://player.tscn")
	
	# Load enemies
	enemy_resource = load("res://enemy.tscn")
	
	#Load cards
	card_resource = load("res://wizardCard.tscn")
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	var next_resource = load("res://map.tscn")
	var current = get_node("start")
	remove_child(current)
	var next = next_resource.instance()
	add_child(next)

func _on_level1_pressed():
	# Spawn level itself
	var next_resource = load("res://level.tscn")
	var current = get_node("map")
	remove_child(current)
	var next = next_resource.instance()
	add_child(next)
	#Spawn team
	var player1 = player_resource.instance()
	get_node("level").add_child(player1)
	player1.position = Vector2(playerLoc[0],playerY)
	
	var player2 = player_resource.instance()
	get_node("level").add_child(player2)
	player2.position = Vector2(playerLoc[1],playerY)
	
	var player3 = player_resource.instance()
	get_node("level").add_child(player3)
	player3.position = Vector2(playerLoc[2],playerY)
	
	var player4 = player_resource.instance()
	get_node("level").add_child(player4)
	player4.position = Vector2(playerLoc[3],playerY)
	# Spawn enemies
	var enemy1 = enemy_resource.instance()
	get_node("level").add_child(enemy1)
	enemy1.position = Vector2(enemyLoc[0],enemyY)
	
	# Spawn cards
	var card1 = card_resource.instance()
	get_node("level").add_child(card1)
	card1.position = Vector2(cardLoc[0],cardY)