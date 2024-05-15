extends Button

@export var button_icon: Texture2D
@export var button_draggable: PackedScene
@export var activity_cost:int

var _is_dragged:bool = false
var _draggable:Node
var _camera: Camera3D
var RAYCAST_LENGTH:int = 100
var _is_location_valid:bool=false
var _last_valid_location:Vector3

@onready var _error_material: BaseMaterial3D = preload("res://metrials/red_transparent.material")

# Called when the node enters the scene tree for the first time.
func _ready():
	icon = button_icon
	_draggable = button_draggable.instantiate()
	_draggable.set_patrolling(false)
	add_child(_draggable)
	_draggable.visible = false
	
	_camera = get_viewport().get_camera_3d()

func _process(delta):
	disabled = activity_cost > $"../..".money

func _physics_process(_delta):
	if _is_dragged:
		var space_state = _draggable.get_world_3d().direct_space_state
		var mouse_pos:Vector2 = get_viewport().get_mouse_position()
		var origin:Vector3 = _camera.project_ray_origin(mouse_pos)
		var end:Vector3 = origin + _camera.project_ray_normal(mouse_pos) * RAYCAST_LENGTH
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		var rayResult:Dictionary = space_state.intersect_ray(query)
		if rayResult.size() > 0:
			var collission:CollisionObject3D = rayResult.get("collider")
			_draggable.visible = true
			_draggable.global_position = Vector3(collission.global_position.x, 0.2, collission.global_position.z)
			if collission.get_groups()[0] == "empty":
				apply_material_on_children(_draggable, false)
				_is_location_valid = true
				_last_valid_location = _draggable.global_position
				
			else:
				apply_material_on_children(_draggable)
				_is_location_valid = false
		
		else:
			_draggable.visible = false
			_is_location_valid = false

func apply_material_on_children(node:Node, with_error:bool=true):
	for child in node.get_children():
		if child is MeshInstance3D:
			if with_error:
				set_material_on_mesh(child, _error_material)
				
			else:
				set_material_on_mesh(child)
		
		if child is Node and child.get_child_count() > 0:
			apply_material_on_children(child, with_error)


func set_material_on_mesh(mesh: MeshInstance3D, material_to_apply:BaseMaterial3D=null):
	for surface in mesh.mesh.get_surface_count():
		mesh.set_surface_override_material(surface, material_to_apply)


func _on_button_down():
	_is_dragged = true
	_is_location_valid = false

func _on_button_up():
	_is_dragged = false
	_draggable.visible = false
	
	if _is_location_valid:
		var new_tower = button_draggable.instantiate()
		get_viewport().add_child(new_tower)
		new_tower.global_position = _last_valid_location
		$"../..".money -= activity_cost
