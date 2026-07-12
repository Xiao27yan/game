extends CanvasLayer
@onready var button_save: Button = $VBoxContainer/Button_Save
@onready var button_load: Button = $VBoxContainer/Button_Load
@onready var label_status: Label = $Label

var is_paused: bool = false

func _ready() -> void:
	hide_pause_menu()
	button_save.pressed.connect(_on_save_pressed)
	button_load.pressed.connect(_on_load_pressed)
	pass

# 这个方法是内置的 相当于一直在监听我的按键输入 
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu()->void:
	get_tree().paused = true
	is_paused = true
	visible = true
	# button_save这个按钮得到聚焦
	button_save.grab_focus()
	

func hide_pause_menu()->void:
	get_tree().paused = false
	is_paused = false
	visible = false

func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()
	pass

func _on_load_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load_game()
	await LevelManager.level_load_started
	hide_pause_menu()
	pass
