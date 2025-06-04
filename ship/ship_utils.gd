extends Node

func get_rightmost_connection(connection_points) -> Marker2D:
	var max_right: Marker2D = connection_points[0]
	for marker in connection_points:
		if marker.position.x > max_right.position.x:
			max_right = marker
	return max_right
	
func get_leftmost_connection(connection_points) -> Marker2D:
	var max_left: Marker2D = connection_points[0]
	for marker in connection_points:
		if marker.position.x < max_left.position.x:
			max_left = marker
	return max_left
