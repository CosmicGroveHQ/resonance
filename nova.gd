extends MeshInstance3D

var time := 0.0

var base_scale := Vector3.ONE

var pulse_speed := 2.0
var pulse_strength := 0.08

var resonance_boost := 0.0

func _process(delta):
	
	time += delta
	
	var pulse = 1.0 + sin(time * pulse_speed) * pulse_strength
	
	scale = base_scale * (pulse + resonance_boost)
	
	resonance_boost = move_toward(
		resonance_boost,
		0.0,
		delta * 1.5
	)
func _input(event):
	if event is InputEventKey and event.pressed:
		resonance_boost = .40

func resonate():
	resonance_boost = 0.40
