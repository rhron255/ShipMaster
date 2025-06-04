class_name ShipComponent extends Draggable

enum MirrorDirection {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

@export var mirror := false
@onready var texture = $Sprite2D

@onready var connection_points: Array[Node] = find_children("*","AttachmentPoint")
#@onready var engine_points: Array[Node] = find_children("EnginePoint*","Marker2D")
var current_direction: MirrorDirection = MirrorDirection.UP

func mirror_horizontal():
	texture.flip_h = !texture.flip_h
	for point in connection_points:
		(point as AttachmentPoint).position.x *= -1

func mirror_vertical():
	texture.flip_v = !texture.flip_v
	for point in connection_points:
		(point as AttachmentPoint).position.y *= -1

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
	var shape = RectangleShape2D.new()
	shape.size = texture.texture.get_size()
	$CollisionShape2D.shape = shape
