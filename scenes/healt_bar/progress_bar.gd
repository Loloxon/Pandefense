extends ProgressBar

var fill_stylebox:StyleBoxFlat
const health_bar_colors = preload("res://scenes/healt_bar/health_bar_colors.tres")

func _ready():
	fill_stylebox = get_theme_stylebox("fill")
	fill_stylebox.bg_color = health_bar_colors.gradient.sample(max_value)


func _on_value_changed(value):
	fill_stylebox.bg_color = health_bar_colors.gradient.sample(value / max_value)
