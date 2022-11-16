extends CanvasLayer

var player_velocity

func setVelocity(_playerSpeed: Vector2):
	$InfoBox/velocity.text = "Player Speed = %s" % _playerSpeed 

func setState(_playerState: String):
	$InfoBox/current_state.text = "Current State = " + str(_playerState)
