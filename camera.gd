extends Camera3D

var is_anim_running:bool = false

var is_on_left:bool = false
var is_on_right:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rotation_degrees.y<=-75:
		is_on_right=true
	elif rotation_degrees.y>=75:
		is_on_left=true
	else:
		is_on_left=false
		is_on_right=false
		
	var screen_x:float=get_viewport().get_visible_rect().size.x
	var cursor_x:float=get_viewport().get_mouse_position().x
	if cursor_x >= 0 and cursor_x <= screen_x:
		var target:float=0.0
		if cursor_x >= screen_x-100 and cursor_x <= screen_x and !is_on_right: #sliddee to the right
			if is_on_left:
				target=0.0
				print_debug("on a side")
			else:
				target=-75.3
				print_debug("not on a side")
			
		elif cursor_x <= 100 and cursor_x >= 0 and !is_on_left: #slidee to the left
			if is_on_right:
				target=0.0
				print_debug("on a side")
			else:
				target=75.3
				print_debug("not on a side")
			
		else:
			if !is_on_left and !is_on_right:
				target=0.0
			else:
				target=rotation_degrees.y
				
		rotation_degrees.y = move_toward(rotation_degrees.y, target, delta*60)
