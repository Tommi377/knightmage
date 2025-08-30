# class_name Log
extends Node

func debug(message: String, source := "", data: Variant = null) -> void:
	var msg := _format_msg(message, source, data)
	print(msg)

func info(message: String, source := "", data: Variant = null) -> void:
	var msg := _format_msg(message, source, data)
	print(msg)

func warn(message: String, source := "", data: Variant = null) -> void:
	var msg := _format_msg(message, source, data)
	print(msg)
	
func error(message: String, source := "", data: Variant = null) -> void:
	var msg := _format_msg(message, source, data)
	push_error(msg)
	printerr(msg)

func _format_msg(message: String, source := "", data: Variant = null) -> String:
	var data_string := ", %s" % JSON.stringify(data) if data else ""
	if source:
		return "%s: %s %s" % [source, message, data_string]
	else:
		return "%s %s" % [message, data_string]
