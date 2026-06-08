class_name State extends Node
#他的子类里只要有一个类定义了player 那么 所有子类共享一个player
static var player:Player
static var state_machine:PlayerStateMachine
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func Enter()->void:
	pass
	
func Init()->void:
	pass

func Exit()->void:
	pass
#每帧逻辑
func Process(_delata:float)->State:
	return null
#物理行为更新
func Physics(_delta:float)->State:
	return	null
	
func HandleInput(_event:InputEvent)->State:
	return null
	
