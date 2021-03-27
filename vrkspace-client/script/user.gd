extends Spatial

puppet var puppet_user_transform
puppet var puppet_head_transform
puppet var puppet_left_hand_transform
puppet var puppet_right_hand_transform

var user_controller

func _ready():
	if is_network_master():
		user_controller = get_tree().get_root().get_node("World/UserController")
	
	puppet_user_transform = transform
	puppet_head_transform = $Head.transform
	puppet_left_hand_transform = $LeftHand.transform
	puppet_right_hand_transform = $RightHand.transform

func _process(delta):
	if is_network_master():
		global_transform = user_controller.global_transform
		$Head.transform = user_controller.get_node("ARVRCamera").transform
		$LeftHand.transform = user_controller.get_node("LeftHand").transform
		$RightHand.transform = user_controller.get_node("RightHand").transform
		
		rset_unreliable("puppet_user_transform", transform)
		rset_unreliable("puppet_head_transform", $Head.transform)
		rset_unreliable("puppet_left_hand_transform", $LeftHand.transform)
		rset_unreliable("puppet_right_hand_transform", $RightHand.transform)
	else:
		transform = puppet_user_transform
		$Head.transform = puppet_head_transform
		$LeftHand.transform = puppet_left_hand_transform
		$RightHand.transform = puppet_right_hand_transform
