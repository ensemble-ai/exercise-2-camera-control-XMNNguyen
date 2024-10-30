class_name PositionLockLerp
extends CameraControllerBase

@export var follow_speed:float
@export var catchup_speed:float
@export var leash_distance:float

func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	# get the distance between the camera and player on the x-z plane
	var xz_camera_position:Vector2 = Vector2(global_position.x, global_position.z)
	var xz_target_position:Vector2 = Vector2(target.global_position.x, target.global_position.z)
	var distance_to_target:float = xz_camera_position.distance_to(xz_target_position)
	
	# get the normalized direction of the player to the target
	var direction:Vector3 = (Vector3(global_position.x, 0, global_position.z) -
								Vector3(target.global_position.x, 0, target.global_position.z)
								).normalized()
	
	# set the camera destination to be the leash_distance away from the player
	var camera_destination:Vector3 = target.global_position + (direction * leash_distance)
	
	if distance_to_target > leash_distance:
		# if our player isn't moving, use catchup_speed as the lerp speed
		# if our player is moving, use follow_speed as the lerp speed
		if target.velocity == Vector3(0, 0, 0):
			global_position = lerp(global_position, camera_destination, catchup_speed)
		else:
			# if speedboost is activated, speed up the camera movement accordingly
			if Input.is_action_pressed("ui_accept"):
				global_position = lerp(global_position, camera_destination, follow_speed * 6)
			else:
				global_position = lerp(global_position, camera_destination, follow_speed)
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	# draw a 5 unit by 5 unit plus sign on the center of the screen
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -5))
	
	immediate_mesh.surface_add_vertex(Vector3(5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-5, 0, 0))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
