extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventShortcut:
		match (event as InputEventShortcut).shortcut:
			"ui_graph_default":
				var dup = Globals.currently_dragging.duplicate(DUPLICATE_USE_INSTANTIATION)
				add_child(dup)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = str(Globals.currently_hovering) if Globals.currently_hovering != null else "null"
	if Input.is_action_just_pressed("edit"):
		get_tree().call_group("AttachmentPoints","toggle_edit")
		get_tree().call_group("ShipComponents","toggle_edit")
	if Globals.currently_hovering is ShipComponent:
		var component: ShipComponent = Globals.currently_hovering
		if Input.is_action_just_pressed("up"):
			component.mirror_part(ShipComponent.MirrorDirection.UP)
		elif Input.is_action_just_pressed("down"):
			component.mirror_part(ShipComponent.MirrorDirection.DOWN)
		elif Input.is_action_just_pressed("left"):
			component.mirror_part(ShipComponent.MirrorDirection.LEFT)
		elif Input.is_action_just_pressed("right"):
			component.mirror_part(ShipComponent.MirrorDirection.RIGHT)
	elif Input.is_action_just_pressed("ui_graph_duplicate"):
		var dup = Globals.currently_hovering.duplicate(DUPLICATE_USE_INSTANTIATION)
		$Node2D.add_child(dup)
