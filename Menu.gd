extends ScrollContainer

@onready var SpeedButton = $VBoxContainer/Speed/SpeedButton
@onready var SpeedLabel = $VBoxContainer/Speed/SpeedLabel
@onready var PowerButton = $VBoxContainer/Power/PowerButton
@onready var PowerLabel = $VBoxContainer/Power/PowerLabel
@onready var QualityButton = $VBoxContainer/Quality/QualityButton
@onready var QualityLabel = $VBoxContainer/Quality/QualityLabel
@onready var EffiButton = $VBoxContainer/Efficiency/EfficiencyButton
@onready var EffiLabel = $VBoxContainer/Efficiency/EfficiencyLabel

var SpeedCounter = 0
var PowerCounter = 0
var QualityCounter = 0
var EffiCounter = 0

@export var SpeedMax = 10
@export var PowerMax = 10
@export var QualityMax = 10
@export var EffiMax = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpeedLabel.text = "Speed\n"+str(SpeedCounter)+"/"+str(SpeedMax)
	PowerLabel.text = "Power\n"+str(PowerCounter)+"/"+str(PowerMax)
	QualityLabel.text = "Quality\n"+str(QualityCounter)+"/"+str(QualityMax)
	EffiLabel.text = "Efficency\n"+str(EffiCounter)+"/"+str(EffiMax)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if SpeedCounter >= SpeedMax:
		SpeedButton.disabled = true
	if PowerCounter >= PowerMax:
		PowerButton.disabled = true
	if QualityCounter >= QualityMax:
		QualityButton.disabled = true
	if EffiCounter >= EffiMax:
		EffiButton.disabled = true


func _on_speed_button_pressed() -> void:
	SpeedCounter += 1
	SpeedLabel.text = "Speed\n"+str(SpeedCounter)+"/"+str(SpeedMax)


func _on_power_button_pressed() -> void:
	PowerCounter += 1
	PowerLabel.text = "Power\n"+str(PowerCounter)+"/"+str(PowerMax)


func _on_quality_button_pressed() -> void:
	QualityCounter += 1
	QualityLabel.text = "Quality\n"+str(QualityCounter)+"/"+str(QualityMax)


func _on_efficiency_button_pressed() -> void:
	EffiCounter += 1
	EffiLabel.text = "Efficency\n"+str(EffiCounter)+"/"+str(EffiMax)
