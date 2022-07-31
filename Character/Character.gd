extends KinematicBody2D
var speed = 800
var ctlSpeedX = 0.6244
var ctlSpeedY = 0.3656
var motion:Vector2
var map:TileMap
enum d {E,N,S,W}
func _ready():
	map = get_parent()
	pass
func move_iso(var direction):
		if direction=='N':
			motion.y = -speed*ctlSpeedY
			motion.x =  speed*ctlSpeedX
			$AnimatedSprite.frame = d.N
		elif direction=='S':
			motion.y =  speed*ctlSpeedY
			motion.x = -speed*ctlSpeedX
			$AnimatedSprite.frame = d.S
		elif direction=='E':
			motion.y =  speed*ctlSpeedY
			motion.x =  speed*ctlSpeedX
			$AnimatedSprite.frame = d.E
		elif direction=='W':
			motion.y = -speed*ctlSpeedY
			motion.x = -speed*ctlSpeedX
			$AnimatedSprite.frame = d.W
			
			
		move_and_slide(motion)
func get_character_position():
	var pos = map.world_to_map(position)
	return pos


func _on_Character_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
