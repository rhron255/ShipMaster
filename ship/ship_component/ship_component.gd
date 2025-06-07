class_name ShipComponent extends Draggable

enum MirrorDirection {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

@export var mirror := false
@export var texture: Sprite2D
@export var shape: CollisionPolygon2D
@onready var connection_points: Array[Node] = find_children("*","AttachmentPoint")
#@onready var engine_points: Array[Node] = find_children("EnginePoint*","Marker2D")
var current_direction: MirrorDirection = MirrorDirection.UP

func mirror_horizontal():
	texture.flip_h = !texture.flip_h

	for point in connection_points:
		point.position.x *= -1

	# Mirror the shape’s position (relative to RigidBody2D)
	shape.position.x *= -1

	# Mirror polygon points (relative to shape's origin)
	var mirrored_polygon = PackedVector2Array()
	for point in shape.polygon:
		mirrored_polygon.append(Vector2(-point.x, point.y))
	shape.polygon = mirrored_polygon

func mirror_vertical():
	texture.flip_v = !texture.flip_v

	for point in connection_points:
		point.position.y *= -1

	# Mirror the shape’s position (relative to RigidBody2D)
	shape.position.y *= -1

	# Mirror polygon points (relative to shape's origin)
	var mirrored_polygon = PackedVector2Array()
	for point in shape.polygon:
		mirrored_polygon.append(Vector2(point.x, -point.y))
	shape.polygon = mirrored_polygon


func mirror_part(direction: MirrorDirection):
	if direction != current_direction:
		match direction:
			MirrorDirection.UP: mirror_vertical()
			MirrorDirection.DOWN: mirror_vertical()
			MirrorDirection.LEFT: mirror_horizontal()
			MirrorDirection.RIGHT: mirror_horizontal()
		current_direction = direction
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for point in connection_points:
		if point is AttachmentPoint:
			point.component = $"."
	$".".shape = shape
