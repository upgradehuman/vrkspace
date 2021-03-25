extends KinematicBody

const gravity = Vector3.DOWN * 10
const speed = 4
const rot_speed = 0.85
var velocity = Vector3.ZERO

puppet var puppet_pos
puppet var puppet_vel = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_network_master():
		$Camera.make_current()
		#$NameLabel.text = "You"
		pass
	else:
		var player_id = get_network_master()
		#$NameLabel.text = gamestate.players[player_id]
		
		puppet_pos = transform # Just making sure we initilize it


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_network_master():
		get_input(delta)
		
		rset_unreliable("puppet_pos", transform)
		rset_unreliable("puppet_vel", velocity)
	else:
		# If we are not the ones controlling this player, 
		# sync to last known position and velocity
		transform = puppet_pos
		velocity = puppet_vel
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if not is_network_master():
		# It may happen that many frames pass before the controlling player sends
		# their position again. If we don't update puppet_pos to position after moving,
		# we will keep jumping back until controlling player sends next position update.
		# Therefore, we update puppet_pos to minimize jitter problems
		puppet_pos = transform

func get_input(delta):
	var vy = velocity.y
	velocity = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("back"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("right"):
		rotate_y(-rot_speed * delta)
	if Input.is_action_pressed("left"):
		rotate_y(rot_speed * delta)
	velocity.y = vy
