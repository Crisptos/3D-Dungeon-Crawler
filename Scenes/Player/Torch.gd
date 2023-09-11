extends OmniLight3D

var rand = RandomNumberGenerator.new()
var time_passed = 0.0
var tween

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tween is Tween:
		if tween.is_running():
			return
	
	time_passed += delta
	var light_value = rand.randf_range(0.75, 1.25)
	tween = create_tween()
	tween.tween_property(self, "light_energy", light_value, 1)
