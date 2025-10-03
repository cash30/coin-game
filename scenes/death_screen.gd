extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var isDead = Globals.isDead
	if Globals.isDead :
				show()
				if Input.is_action_just_pressed("click"):
					Globals.isDead = false
					get_tree().reload_current_scene()
