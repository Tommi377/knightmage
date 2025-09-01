class_name MessageCenter
extends Control

@onready var message_label: Label = $Message

func send(msg: String, duration := 2) -> void:
	message_label.text = msg
	message_label.show()

	var timer := Timer.new()
	timer.wait_time = duration
	add_child(timer)
	timer.start()
	await timer.timeout
	message_label.hide()
