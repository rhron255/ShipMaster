class_name AttachmentPoint extends Area2D

var component: ShipComponent

var editable := true

func _ready() -> void:
	var shape = CircleShape2D.new()
	shape.radius = $CollisionShape2D/Sprite2D.get_rect().size.x * \
					$CollisionShape2D/Sprite2D.scale.x / 2
	$CollisionShape2D.shape = shape
	pass

func attach(other: AttachmentPoint) -> void:
	component.position -= global_position - other.global_position


func toggle_edit() -> void:
	editable = !editable
	if !editable:
		$CollisionShape2D.hide()
		monitoring = false
	else:
		$CollisionShape2D.show()
		monitoring = true


func _on_body_entered(body: Node2D) -> void:
	print(body)


func _on_area_entered(area: Area2D) -> void:
	if area is AttachmentPoint:
		print(area)
		if component.is_being_dragged():
			attach(area)
