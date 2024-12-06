extends CharacterBody2D

class_name Player

@onready var healthbar = $CanvasLayer/Healthbar


var health = 100
var is_attacking = false
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var attack_ip = false

var player_alive = true

func _ready() -> void:
	health = 100
	healthbar.init_health(health)

func _process(delta):
	enemy_attack()
	attack()
	
	if health <= 0:
		player_alive = false
		health = 0
		print("Player killed")
		self.queue_free()
	
	var velocity = Vector2.ZERO
	
	# Check for movement inputs
	if Input.is_action_pressed("up") || Input.is_action_pressed("ui_w"):
		velocity.y -= 200
	if Input.is_action_pressed("down") || Input.is_action_pressed("ui_s"):
		velocity.y += 200
	if Input.is_action_pressed("left") || Input.is_action_pressed("ui_a"):
		velocity.x -= 200
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("right") || Input.is_action_pressed("ui_d"):
		velocity.x += 200
		$AnimatedSprite2D.flip_h = false

	# Update animation based on movement state if not attacking
	if not is_attacking:
		if velocity.length() > 0:
			update_animation("Run")
		else:
			update_animation("Idle")

	# Apply movement
	position += velocity * delta
	
	# Play the "Slash" animation when the attack button is pressed
	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		$AnimatedSprite2D.play("Slash")

# Function to update animation only when necessary
func update_animation(animation_name: String):
	if $AnimatedSprite2D.animation != animation_name:
		$AnimatedSprite2D.play(animation_name)

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Slash":
		is_attacking = false
		Global.player_current_attack = false

#Important func, it significe the identity of the main character in other scene
func player():
	pass

func _on_slash_damage_area_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_slash_damage_area_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		print("Enemy attack.")
		health -= 3
		healthbar.health = health  # Update health on the health bar
		print("Player health after attack: " + str(health))
		
		# Start the Natural_Healing timer if health drops below 100
		if health < 100 and $Natural_Healing.is_stopped():
			print("Starting Natural Healing...")
			$Natural_Healing.start()
			
		enemy_attack_cooldown = false
		$Attack_Cooldown.start()

func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true

func attack():
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		$AnimatedSprite2D.play("Slash")
		$Deal_attack_timer.start()

func _on_deal_attack_timer_timeout() -> void:
	$Deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false

func _on_natural_healing_timeout() -> void:
	if health < 100:
		health += 5
		health = min(health, 100)  # Cap health at 100
		healthbar.health = health  # Update health on the health bar
		print("Healing... New health: " + str(health))
		
		# Stop the timer if health reaches 100
		if health >= 100:
			print("Health is full. Stopping Natural Healing.")
			$Natural_Healing.stop()
	else:
		$Natural_Healing.stop()
