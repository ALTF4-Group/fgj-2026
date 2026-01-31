extends CanvasLayer


@onready var fade_rect := $FadeRect

func fade_to_black(duration: float = 1.0):
	fade_rect.visible = true
	fade_rect.modulate.a = 0.0
	
	var tween = create_tween()
	tween.tween_property(
		fade_rect,
		"modulate:a",
		1,
		duration
	)
	
