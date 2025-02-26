class_name ItemEffectHeal extends ItemEffect

@export var heal_amount : int = 1
@export var audio : AudioStream


func use() -> void:
	print(heal_amount)
	#PlayerManager.PLAYER.update_hp(heal_amount)
	#InventoryMenu.play_audio(audio)
