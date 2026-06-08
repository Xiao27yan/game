#受击判定框
class_name HitBox extends Area2D

signal Damaged(hurt_box:Area2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#承受伤害
func TakeDamage(hurt_box:Area2D)->void:
#	把伤害值传给所有连接了这个信号的对象
	Damaged.emit(hurt_box)
