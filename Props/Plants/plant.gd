class_name Plant extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect(TakeDamage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func TakeDamage(_damage:int)->void:
	
#	待销毁 植物被攻击时将会销毁
	queue_free()
	pass
