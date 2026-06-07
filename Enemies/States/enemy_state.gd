class_name EnemyState extends Node

var enemy:Enemy
var state_machine : EnemyStateMachine

func _ready() -> void:
	pass # Replace with function body.

func init()->void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Enter()->void:
	pass

func Exit()->void:
	pass
#每帧逻辑
func Process(_delata:float)->EnemyState:
	return null
#物理行为更新
func Physics(_delta:float)->EnemyState:
	return	null
	
	
