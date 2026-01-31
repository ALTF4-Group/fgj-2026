extends Node2D

enum ActiveMusicTrack {
	BASE,
	AGGRO,
	CALM
}

var active_track = ActiveMusicTrack.BASE
var tracks = null
var fading = false
var next_fade = null

const FADE_DURATION = 2
const FADE_TYPE = 1  # TRANS_SINE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BaseMusic.play()
	$AggroMusic.play()
	$CalmMusic.play()
	$AggroMusic.volume_linear = 0
	$CalmMusic.volume_linear = 0
	tracks = {
		ActiveMusicTrack.BASE: $BaseMusic,
		ActiveMusicTrack.AGGRO: $AggroMusic,
		ActiveMusicTrack.CALM: $CalmMusic
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_calm() -> void:
	_set_active_track(ActiveMusicTrack.CALM)

func set_aggro() -> void:
	_set_active_track(ActiveMusicTrack.AGGRO)

func set_base() -> void:
	_set_active_track(ActiveMusicTrack.BASE)

		
func _set_active_track(new_active: ActiveMusicTrack) -> void:
	if active_track == new_active or tracks == null:
		return
	if fading:
		next_fade = new_active
		return
	fading = true
	_crossfade(tracks[active_track], tracks[new_active])
	active_track = new_active

func _crossfade_complete() -> void:
	if next_fade != null:
		_crossfade(tracks[active_track], tracks[next_fade])
		active_track = next_fade
		next_fade = null
	else:
		fading = false
	
func _crossfade(old_stream: AudioStreamPlayer2D, new_stream: AudioStreamPlayer2D):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(old_stream, "volume_linear", 0, FADE_DURATION)
	tween.parallel().tween_property(new_stream, "volume_linear", 1, FADE_DURATION)
	tween.tween_callback(_crossfade_complete)
