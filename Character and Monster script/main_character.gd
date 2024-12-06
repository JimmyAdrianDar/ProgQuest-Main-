extends CharacterBody2D


var is_attacking = false

func _process(delta):
	var velocity = Vector2.ZERO  # Reset velocity to zero each frame
	
	# Check for movement inputs even if attacking
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
		

func player():
	pass
