extends Node

func getMousePosition(camera,from):
		var mouse_pos = get_viewport().get_mouse_position()
		var normal_vec = camera.project_ray_normal(mouse_pos)
		var plane = Plane(Vector3(0, 1, 0), from.y)
		var intersection = plane.intersects_ray(camera.global_transform.origin, normal_vec)
		return intersection
