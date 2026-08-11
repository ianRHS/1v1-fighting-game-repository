extends Node

@onready var timer: Timer = $Timer  
@onready var label: Label = $Label

var time_left: int = 60

func _ready() -> void:  
	update_label()

### This function updates the visual text on screen

func update_label() -> void:  
	label.text = str(time_left)

### Connect this function to the Timer's "timeout" signal!

func _on_timer_timeout() -> void:  
	if time_left > 0:  
		time_left -= 1  
		update_label()  
	else:  
			timer.stop()  
			print("Time is up!") # Put your game over logic here
	
