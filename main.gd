extends Node2D

var player_resource
var knight_resource
var gladiator_resource
var wizard_resource
var archer_resource

var current

var playerLoc = [100,200,300,400]
var playerY = 300
var players = ["knight","gladiator","wizard","archer"]
var target

var enemy_resource
var enemyLoc = [800,700]
var enemyY = 280

var card_resource
var cardLoc = [150,300,450,600,750,900,1050]
var cardY = 500

var team
var selected = 0
var attack = 0
var defend = 0

var Damage
var Defence
var Cards
var maxCards = 4

var enemyDamage
var damageDealt = 0
var totalDamageDealt = 0

signal newTurn

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load players
	knight_resource = load("res://knight.tscn")
	gladiator_resource = load("res://gladiator.tscn")
	wizard_resource = load("res://wizard.tscn")
	archer_resource = load("res://archer.tscn")
	
	# Load enemies
	enemy_resource = load("res://enemy.tscn")
	
	#Load cards
	card_resource = load("res://wizardCard.tscn")
	
	current = get_node("start")
	
	randomize()
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	var next_resource = load("res://map.tscn")
	current = get_node("start")
	remove_child(current)
	var next = next_resource.instance()
	add_child(next)
	current = get_node("map")

func _on_level1_pressed():
	# Reset variables
	players = ["knight","gladiator","wizard","archer"]
	selected = 0
	attack = 0
	defend = 0
	maxCards = 4
	totalDamageDealt = 0
	
	# Clear out the last scene
	
	
	# Spawn level itself
	var next_resource = load("res://level.tscn")
	remove_child(current)
	var next = next_resource.instance()
	add_child(next)
	current = get_node("level")
	get_node("level/turnButton").connect("pressed", self, "_on_New_Turn")
	
	Damage = get_node("level/GUI/Damage/DamageValue")
	Defence = get_node("level/GUI/Defence/DefenceValue")
	Cards = get_node("level/GUI/Cards/CardsValue")
	
	#Spawn team
	var player1 = archer_resource.instance()
	get_node("level").add_child(player1)
	player1.position = Vector2(playerLoc[0],playerY)
	
	var player2 = wizard_resource.instance()
	get_node("level").add_child(player2)
	player2.position = Vector2(playerLoc[1],playerY)
	
	var player3 = gladiator_resource.instance()
	get_node("level").add_child(player3)
	player3.position = Vector2(playerLoc[2],playerY)
	
	var player4 = knight_resource.instance()
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
	
	var card2 = card_resource.instance()
	get_node("level").add_child(card2)
	card2.position = Vector2(cardLoc[1],cardY)
	
	var card3 = card_resource.instance()
	get_node("level").add_child(card3)
	card3.position = Vector2(cardLoc[2],cardY)
	
	var card4 = card_resource.instance()
	get_node("level").add_child(card4)
	card4.position = Vector2(cardLoc[3],cardY)
	
	var card5 = card_resource.instance()
	get_node("level").add_child(card5)
	card5.position = Vector2(cardLoc[4],cardY)
	
	var card6 = card_resource.instance()
	get_node("level").add_child(card6)
	card6.position = Vector2(cardLoc[5],cardY)
	
	enemyDamage = int(rand_range(-35, 100))
	if enemyDamage > 0:
		target = players[int(rand_range(0,4))]
		get_node("level/enemy/damage").set_text(str(enemyDamage)+" damage on "+target)
	else:
		get_node("level/enemy/damage").set_text(str(abs(enemyDamage))+" block")
	
func _on_New_Turn():
	emit_signal("newTurn")
	get_node("level/wham").play()
	if enemyDamage <= 0:
		if abs(enemyDamage)>attack:
			pass
		else:
			damageDealt =  attack - abs(enemyDamage)
			get_node("level/enemy/health").set_value(get_node("level/enemy/health").get_value() - damageDealt)
	else:
		if defend > enemyDamage:
			pass
		else:
			get_node("level/"+target).health -= (enemyDamage - defend)
			get_node("level/"+target+"/health").set_value(get_node("level/"+target).health)
		damageDealt = attack
		get_node("level/enemy/health").set_value(get_node("level/enemy/health").get_value()-damageDealt)
	if damageDealt > 0:
		totalDamageDealt += damageDealt
	
	attack = 0
	defend = 0
	selected = 0
	damageDealt = 0
	
	if target != null:
		if (get_node(("level/"+target+"/health")).get_value() <= 0):
			maxCards -= 1
			get_node("level/"+target+"/AnimatedSprite").animation = ("ash")
			get_node("level/"+target+"/health").set_visible(false)
			var deadGuy = players.find(target)
			players.remove(deadGuy)
			target = null
		
	if maxCards == 0:
		var next_resource = load("res://end.tscn")
		current = get_node("level")
		remove_child(current)
		var next = next_resource.instance()
		add_child(next)
		get_node("end/Score/ScoreValue").set_text(str(totalDamageDealt))
		get_node("end/restart").connect("pressed",self,"_on_level1_pressed")
		current = get_node("end")
		return
		
	
	Damage.set_text("0")
	Defence.set_text("0")
	Cards.set_text("0/"+str(maxCards))
	
	
	
	# Generate Enemy Attack
	
	enemyDamage = int(rand_range(-50, 50))
	if enemyDamage > 0:
		target = players[int(rand_range(0,players.size()))]
		get_node("level/enemy/damage").set_text(str(enemyDamage)+" damage on "+target)
	else:
		get_node("level/enemy/damage").set_text(str(abs(enemyDamage))+" block")
	
func _on_Card_Selected(damage):
	# Change UI to show that you selected x/3 cards
	# Negative damage goes to block variable
	# Positive value goes to attack variable
	if selected < maxCards:
		selected += 1
		
		Cards.set_text(str(selected)+"/"+str(maxCards))
		
		if damage > 0:
			attack += damage
			Damage.set_text(str(attack))
		else:
			defend -= damage
			Defence.set_text(str(defend))
	
func _on_Card_Deselected(damage):
	selected -= 1
	
	Cards.set_text(str(selected)+"/"+str(maxCards))
	
	if damage > 0:
		attack -= damage
		Damage.set_text(str(attack))
	else:
		defend -= damage
		Defence.set_text(str(defend))