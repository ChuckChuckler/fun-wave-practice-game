extends Node2D

var target:float=-25.0
const VELOCITY:float=20.0
var is_being_shot:bool=false

const FREQ:float=1.5
const WAVELENGTH:float=180.0
const POINT_COUNT:int=100
const AMP:float=10

var time:float=0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_being_shot:
		rotation_degrees = move_toward(rotation_degrees, target*1.05, delta*VELOCITY)
		if rotation_degrees>=target-0.2 and rotation_degrees<=target+0.2:
			target*=-1
	
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
	
	$wave.points=points
	
	
