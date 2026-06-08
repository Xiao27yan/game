#攻击判定框
class_name HurtBox extends Area2D
@export var damage:int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(AreaEntered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#承受伤害
func Damage(damage:int)->void:
	print("Damage:",damage)
#	把伤害值传给所有连接了这个信号的对象

#如果受击框在范围内 就调用受击框承受伤害方法
func AreaEntered(a:Area2D)->void:
	if a is HitBox:
		a.TakeDamage(self)
	pass
