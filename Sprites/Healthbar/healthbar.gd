extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $Damagebar

var health =0

func init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health
	

func set_health(new_health):
	health = new_health
	value = health
	timer.start()


func _on_timer_timeout() -> void:
	damage_bar.value = health
