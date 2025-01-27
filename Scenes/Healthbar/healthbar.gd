extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $Damagebar
@onready var healthtext = $"health value"

var health =0

func init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health
	healthtext.text = str(health)+"/"+str(max_value)
	

func set_health(new_health):
	health = new_health
	value = health
	healthtext.text = str(health)+"/"+str(max_value)
	timer.start()


func _on_timer_timeout() -> void:
	damage_bar.value = health
