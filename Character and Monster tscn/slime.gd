extends CharacterBody2D

@onready var healthbar = $Healthbar

var speed = 130
var health = 100
var dead = false

var player_in_area = false
var player = null
var attack_cooldown = true

var enemy_takingdamage = true
var player_inattack_zone = false



func _ready() -> void:
	health = 100
	healthbar.init_health(health)
	
	dead = false

func _physics_process(delta: float) -> void:
	if dead:
		return
	if health <= 0 and not dead:
		dead = true
		$AnimatedSprite2D.play("Death")
		$DeathCooldownTimer.start()
		return
		
	take_damage()

# Only proceed if the player is within the area and defined
	if player_in_area and player:
		var direction = (player.global_position - global_position).normalized()
		global_position += direction * speed * delta
		if player.global_position.x < global_position.x:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Side_Walk")
	else:
		$AnimatedSprite2D.play("Idle")
		

#Detection Function
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true
		player = body

#Detection Function
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
		player = null

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inattack_zone = true

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inattack_zone = false

func take_damage():
	if player_inattack_zone and Global.player_current_attack == true:
		if enemy_takingdamage:
			health -= 20
			$Taking_damage.start()
			healthbar.health = health
			print(health)
			enemy_takingdamage = false
			print("Slime health: " + str(health))

func attack_player():
	if player and attack_cooldown:
		player.health -= 3
		attack_cooldown = false
		$AttackCooldownTimer.start()

func _on_taking_damage_timeout() -> void:
	enemy_takingdamage = true

func _on_attack_cooldown_timer_timeout() -> void:
	attack_cooldown = true

func _on_death_cooldown_timer_timeout() -> void:
	if not $AnimatedSprite2D.is_playing():
		print("Cleaning up the slime after death animation.")
		self.queue_free()
