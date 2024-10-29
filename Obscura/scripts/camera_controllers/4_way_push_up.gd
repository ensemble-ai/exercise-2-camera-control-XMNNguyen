class_name FourWayPushUp
extends CameraControllerBase


@export var push_ratio:float
@export var pushbox_top_left:Vector2
@export var pushbox_bottom_right:Vector2
@export var speedup_zone_top_left:Vector2
@export var speedup_zone_bottom_right:Vector2

var pushbox_width:float 
var pushbox_height:float 
var speedup_zone_width:float 
var speedup_zone_height:float 


func _ready() -> void:
	super()
	position = target.position
	
	pushbox_width = abs(pushbox_bottom_right - pushbox_top_left).x
	pushbox_height = abs(pushbox_bottom_right - pushbox_top_left).y
	
	speedup_zone_width = abs(speedup_zone_bottom_right - speedup_zone_top_left).x
	speedup_zone_height = abs(speedup_zone_bottom_right - speedup_zone_top_left).y


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos:Vector3 = target.global_position
	var cpos:Vector3 = global_position
	
	#TODO: set up boundery checks for speedup and pushbox zones
	# boundary checks for pushbox
	# left
	var diff_between_left_edges_boundery = (tpos.x - target.WIDTH / 2.0) - (cpos.x - pushbox_width / 2.0)
	
	if diff_between_left_edges_boundery < 0:
		global_position.x += diff_between_left_edges_boundery
		
	# right
	var diff_between_right_edges_boundery = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_width / 2.0)
	
	if diff_between_right_edges_boundery > 0:
		global_position.x += diff_between_right_edges_boundery
		
	# top
	var diff_between_top_edges_boundery = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - pushbox_height / 2.0)
	
	if diff_between_top_edges_boundery < 0:
		global_position.z += diff_between_top_edges_boundery
		
	# bottom
	var diff_between_bottom_edges_boundery = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + pushbox_height / 2.0)
	
	if diff_between_bottom_edges_boundery > 0:
		global_position.z += diff_between_bottom_edges_boundery
	
	# boundary checks for speedup zone
	# left
	var diff_between_left_edges_speedup_zone = (tpos.x - target.WIDTH / 2.0) - (cpos.x - speedup_zone_width / 2.0)
	
	if diff_between_left_edges_speedup_zone < 0 && target.velocity.normalized().x < 0:
		global_position.x += target.velocity.normalized().x * push_ratio
		
	# right
	var diff_between_right_edges_speedup_zone = (tpos.x + target.WIDTH / 2.0) - (cpos.x + speedup_zone_width / 2.0)
	
	if diff_between_right_edges_speedup_zone > 0 && target.velocity.normalized().x > 0:
		global_position.x += target.velocity.normalized().x * push_ratio
		
	# top
	var diff_between_top_edges_speedup_zone = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - speedup_zone_height / 2.0)
	
	if diff_between_top_edges_speedup_zone < 0  && target.velocity.normalized().z < 0:
		global_position.z += target.velocity.normalized().z * push_ratio
		
	# bottom
	var diff_between_bottom_edges_speedup_zone = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + speedup_zone_height / 2.0)
	
	if diff_between_bottom_edges_speedup_zone > 0 && target.velocity.normalized().z > 0:
		global_position.z += target.velocity.normalized().z * push_ratio
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -pushbox_width / 2
	var right:float = pushbox_width / 2
	var top:float = -pushbox_height / 2
	var bottom:float = pushbox_height / 2
	
	#TODO: set up imediate meshes for pushbox and speedup zones
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
