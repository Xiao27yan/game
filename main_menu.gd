extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	print("游戏开始了")
	pass # Replace with function body.


func _on_pressed_2_pressed() -> void:
	print("选项")
	pass # Replace with function body.


func _on_exit_3_pressed() -> void:
	print("退出")
	get_tree().quit()
	pass # Replace with function body.
