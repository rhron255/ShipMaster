class_name Draggable extends Area2D

var lifted := false
var mouse_on := false
var editable := true

func toggle_edit():
	editable = !editable

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		lifted = event.pressed
		if not (lifted or is_being_dragged()):
			#Globals.currently_hovering = null
			Globals.currently_dragging = null
	if editable:
		if event is InputEventMouseMotion and is_being_dragged():
			Globals.currently_dragging = $"."
			Globals.currently_hovering = $"."
			position += event.relative
		#elif event is InputEventKey:
			#match (event as InputEventKey).as_text_keycode():
				#KEY_M:
					#mirror()
		#elif event is InputEventShortcut:
			#match (event as InputEventShortcut).shortcut:
				#"ui_graph_default":
					#var dup = $".".duplicate(DUPLICATE_USE_INSTANTIATION)
					#
				
		

func _on_mouse_entered() -> void:
	mouse_on = true
	Globals.currently_hovering = $"."

func _on_mouse_exited() -> void:
	mouse_on = false
	Globals.currently_dragging = null
	if Globals.currently_hovering == $".":
		Globals.currently_hovering = null

func is_being_dragged() -> bool:
	return lifted and mouse_on and (		\
		Globals.currently_dragging == null 					\
		or Globals.currently_dragging==$".")
