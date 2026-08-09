class_name UI
extends Control


@onready var SpeedButton = $Menu/VBoxContainer/Speed/SpeedButton
@onready var SpeedLabel = $Menu/VBoxContainer/Speed/SpeedLabel
@onready var PowerButton = $Menu/VBoxContainer/Power/PowerButton
@onready var PowerLabel = $Menu/VBoxContainer/Power/PowerLabel
@onready var QualityButton = $Menu/VBoxContainer/Quality/QualityButton
@onready var QualityLabel = $Menu/VBoxContainer/Quality/QualityLabel
@onready var EffiButton = $Menu/VBoxContainer/Efficiency/EfficiencyButton
@onready var EffiLabel = $Menu/VBoxContainer/Efficiency/EfficiencyLabel

@onready var MoneyLabel = $Money/Money

var SpeedCounter = 0
var PowerCounter = 0
var QualityCounter = 0
var EffiCounter = 0

@export var SpeedMax = 10
@export var PowerMax = 10
@export var QualityMax = 10
@export var EffiMax = 10

@export var SpeedCost = 20
@export var PowerCost = 20
@export var QualityCost = 20
@export var EffiCost = 20

@export var SpeedUpgradeMult = 2
@export var PowerUpgradeMult = 2
@export var QualityUpgradeMult = 2
@export var EffiUpgradeMult = 2

var Money: float = 0

@export var borehole: Borehole
@export var drill: Drill

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpeedButton.text = "$"+str(SpeedCost)
	PowerButton.text = "$"+str(PowerCost)
	QualityButton.text = "$"+str(QualityCost)
	EffiButton.text = "$"+str(EffiCost)
	
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
	Money = Money + (2 ** (QualityCounter + 1))
	MoneyLabel.text = "Ooglabucks\n$"+MoneyConversionFunction(Money)


func _on_speed_button_pressed() -> void:
	if SpeedCost <= Money:
		SpeedCounter += 1
		SpeedLabel.text = "Speed\n"+str(SpeedCounter)+"/"+str(SpeedMax)
		Money = Money - SpeedCost
		SpeedCost = SpeedCost * 2
		SpeedButton.text = "$"+str(SpeedCost)
		borehole.speed_px += borehole.additive_speed


func _on_power_button_pressed() -> void:
	PowerCounter += 1
	PowerLabel.text = "Power\n"+str(PowerCounter)+"/"+str(PowerMax)
	borehole.laser.width += 1
	drill.laser.width += 1


func _on_quality_button_pressed() -> void:
	QualityCounter += 1
	QualityLabel.text = "Quality\n"+str(QualityCounter)+"/"+str(QualityMax)
	borehole.laser.color += 1
	drill.laser.color += 1


func _on_efficiency_button_pressed() -> void:
	EffiCounter += 1
	EffiLabel.text = "Efficency\n"+str(EffiCounter)+"/"+str(EffiMax)


static func MoneyConversionFunction(money: float) -> String:
	if money < 1000:
		return str(snapped(money, 0))
	elif money < 1000000:
		money = snapped(money/1000, 0.1)
		return str(money)+"K"
	elif money < 1000000000:
		money = snapped(money/1000000, 0.1)
		return str(money)+"M"
	elif money < 1000000000000:
		money = snapped(money/1000000000, 0.1)
		return str(money)+"B"
	elif money < 1000000000000000:
		money = snapped(money/1000000000000, 0.1)
		return str(money)+"T"
	elif money < 1000000000000000000.0:
		money = snapped(money/1000000000000000.0, 0.1)
		return str(money)+"q"
	elif money < 1000000000000000000000.0:
		money = snapped(money/1000000000000000000.0, 0.1)
		return str(money)+"Q"
	elif money < 1000000000000000000000000.0:
		money = snapped(money/1000000000000000000000.0, 0.1)
		return str(money)+"s"
	elif money < 1000000000000000000000000000.0:
		money = snapped(money/1000000000000000000000000.0, 0.1)
		return str(money)+"S"
	elif money < 1000000000000000000000000000000.0:
		money = snapped(money/1000000000000000000000000000.0, 0.1)
		return str(money)+"o"
	elif money < 1000000000000000000000000000000000.0:
		money = snapped(money/1000000000000000000000000000000.0, 0.1)
		return str(money)+"N"
	elif money < 1000000000000000000000000000000000000.0:
		money = snapped(money/1000000000000000000000000000000000.0, 0.1)
		return str(money)+"d"
	return "naneinf"
