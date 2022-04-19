extends Control


func _ready():
	Global.update_time(0)


func update_time():
	$Time.text = "Time " + str(Global.time)

func _on_Timer_timeout():
	Global.update_time(-1)

