extends Position2D
var timer:Timer
var sprite:AnimatedSprite
var ran = 50
var fc
var parent:Sprite
func _ready():
	sprite = $AnimatedSprite
	sprite.frame = 0
	sprite.playing = false
	parent = get_parent()
	fc = sprite.frames.get_frame_count("default")
	timer = $AnimatedSprite/Timer
	timer.connect("timeout",self,"move")
	parent.connect("visibility_changed",self,"_on_parent_visibility_changed")


	
func move():
	if sprite.position.y > -ran :
		sprite.position.y = sprite.position.y - (ran/fc)
		sprite.frame = sprite.frame+1
		
	else:
		sprite.position.y = 0
		sprite.frame = 0
		timer.start()


func _on_parent_visibility_changed():

	if parent.visible:
		visible = true
		sprite.frame = 0
		timer.start()
	else:
		timer.stop()
		sprite.frame = 0
		sprite.position.y = 0
		visible = false
	pass