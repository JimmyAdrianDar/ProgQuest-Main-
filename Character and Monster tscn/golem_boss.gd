extends CharacterBody2D

@onready var player = get_parent().find_child("Main Character")
@onready var animation2d = $AnimatedSprite2D
@onready var progress_bar = $UI/Healthbar

var direction : Vector2

var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteMachine").change_state("Death")

func _ready() -> void:
	set_physics_process(false)
	health = 100
	progress_bar.init_health(health)

func enemy():
	pass

func _process(_delta):
	direction = player.position - position
	
	if direction.x < 0:
		animation2d.flip_h = false
	else:
		animation2d.flip_h = true

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

func take_damage():
	health -= 10
	progress_bar.health = health
