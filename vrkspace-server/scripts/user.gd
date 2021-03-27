extends Spatial

puppet var puppet_user_transform
puppet var puppet_head_transform
puppet var puppet_left_hand_transform
puppet var puppet_right_hand_transform

# Called when the node enters the scene tree for the first time.
func _ready():
	puppet_user_transform = transform
	puppet_head_transform = $Head.transform
	puppet_left_hand_transform = $LeftHand.transform
	puppet_right_hand_transform = $RightHand.transform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform = puppet_user_transform
	$Head.transform = puppet_head_transform
	$LeftHand.transform = puppet_left_hand_transform
	$RightHand.transform = puppet_right_hand_transform
