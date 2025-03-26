class_name MeteorStateTakeDamage extends EnemyState

func enter() -> void:
	print("Meteor Taking Damage")
	get_parent().queue_free()
	if get_parent().get_parent():
		get_parent().get_parent().emit_signal("boss_took_damage")
