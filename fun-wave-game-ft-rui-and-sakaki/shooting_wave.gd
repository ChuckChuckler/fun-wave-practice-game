extends Node2D

var target:float=-25.0
const ROTATE_VELOCITY:float=15.0
const SHOOT_VELOCITY:float=350.0
var is_being_shot:bool=false

const FREQ:float=1.5
const WAVELENGTH:float=180.0
const POINT_COUNT:int=100
const AMP:float=10

var time:float=0.0

var wave_success:bool

@onready var DEF_POS=$wave_object.position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_being_shot:
		rotation_degrees = move_toward(rotation_degrees, target*1.05, delta*ROTATE_VELOCITY)
		if rotation_degrees>=target-0.2 and rotation_degrees<=target+0.2:
			target*=-1
	else:
		if wave_success:
			$"../correct_incorrect".text="Correct!!!"
			$"../correct_incorrect".add_theme_color_override("default_color",Color(0.16, 0.408, 0.12, 1.0))
			$wave_object.position=$wave_object.position.move_toward($target_correct/target.position,delta*SHOOT_VELOCITY)
			if $wave_object.position==$target_correct/target.positio and $wave_object/shoot_reset.time_left<=0:
				$"../correct_incorrect".visible=true
				$wave_object/shoot_reset.start()
		else:
			$"../correct_incorrect".text="Incorrect..."
			$"../correct_incorrect".add_theme_color_override("default_color",Color(1.0, 0.0, 0.0, 1.0))
			$wave_object.position=$wave_object.position.move_toward($target_incorrect/target.position,delta*SHOOT_VELOCITY)
			if $wave_object.position==$target_incorrect/target.position and $wave_object/shoot_reset.time_left<=0:
				$"../correct_incorrect".visible=true
				$wave_object/shoot_reset.start()
	time+=delta
	update_wave()

func update_wave()->void:
	var points = PackedVector2Array()
	var step = WAVELENGTH/POINT_COUNT
	
	for i in range(POINT_COUNT):
		var x:float=i*step
		var k = TAU/((WAVELENGTH*$"../../../wave_interface/wave".coeffL)/$"../../../wave_interface/wave".harmonic)
		var w = TAU*FREQ
		var y = 2.0*AMP*sin(k*x)*cos(w*time)
		
		points.append(Vector2(x+370,y+393))	
	
	$wave_object/wave.points=points

func _on_shoot_reset_timeout() -> void:
	is_being_shot=false
	$wave_object.position=DEF_POS
