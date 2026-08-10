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

@export var purchase_audio_player: AudioStreamPlayer

var SpeedCounter = 0
var PowerCounter = 0
var QualityCounter = 0
#var EffiCounter = 0

@export var SpeedMax = 10
@export var PowerMax = 10
@export var QualityMax = 10
#@export var EffiMax = 10

@export var SpeedCost: float = 20.0
@export var PowerCost: float = 100.0
@export var QualityCost: float = 1000.0
#@export var EffiCost: float = 20.0

@export var SpeedUpgradeMult = 2
@export var PowerUpgradeMult = 2
@export var QualityUpgradeMult = 2
#@export var EffiUpgradeMult = 2

var Money: float = 0.0

@export var borehole: Borehole
@export var drill: Drill

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpeedButton.text = "$"+MoneyConversionFunction(SpeedCost)
	PowerButton.text = "$"+MoneyConversionFunction(PowerCost)
	QualityButton.text = "$"+MoneyConversionFunction(QualityCost)
	#EffiButton.text = "$"+MoneyConversionFunction(EffiCost)
	
	SpeedLabel.text = "Speed\n"+str(SpeedCounter)+"/"+str(SpeedMax)
	PowerLabel.text = "Power\n"+str(PowerCounter)+"/"+str(PowerMax)
	QualityLabel.text = "Quality\n"+str(QualityCounter)+"/"+str(QualityMax)
	#EffiLabel.text = "Efficency\n"+str(EffiCounter)+"/"+str(EffiMax)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(QualityCounter)
	if SpeedCounter >= SpeedMax:
		SpeedButton.disabled = true
	if PowerCounter >= PowerMax:
		PowerButton.disabled = true
	if QualityCounter >= QualityMax:
		QualityButton.disabled = true
	#if EffiCounter >= EffiMax:
		#EffiButton.disabled = true
	Money = float(Money + (2 ** (QualityCounter * 10)))
	MoneyLabel.text = "Ooglabucks\n$"+MoneyConversionFunction(Money)


func _on_speed_button_pressed() -> void:
	if SpeedCost <= Money:
		purchase_audio_player.play()
		SpeedCounter += 1
		SpeedLabel.text = "Speed\n"+str(SpeedCounter)+"/"+str(SpeedMax)
		Money = Money - SpeedCost
		SpeedCost = SpeedCost * 2
		SpeedButton.text = "$"+MoneyConversionFunction(SpeedCost)
		borehole.speed_px += borehole.additive_speed


func _on_power_button_pressed() -> void:
	if PowerCost <= Money:
		purchase_audio_player.play()
		PowerCounter += 1
		PowerLabel.text = "Power\n"+str(PowerCounter)+"/"+str(PowerMax)
		Money = Money - PowerCost
		PowerCost = PowerCost * 3000
		PowerButton.text = "$"+MoneyConversionFunction(PowerCost)
		borehole.laser.width += 1
		drill.laser.width += 1


func _on_quality_button_pressed() -> void:
	if QualityCost <= Money:
		purchase_audio_player.play()
		QualityCounter += 1
		QualityLabel.text = "Quality\n"+str(QualityCounter)+"/"+str(QualityMax)
		Money = Money - QualityCost
		QualityCost = QualityCost * 100
		QualityButton.text = "$"+MoneyConversionFunction(QualityCost)
		borehole.laser.color += 1
		drill.laser.color += 1


#func _on_efficiency_button_pressed() -> void:
	#purchase_audio_player.play()
	#EffiCounter += 1
	#EffiLabel.text = "Efficency\n"+str(EffiCounter)+"/"+str(EffiMax)


static func MoneyConversionFunction(money: float) -> String:
	if money < 1000:
		return str(snapped(money, 0))
	elif money < 1000000:
		money = snapped(money/1000, 0.01)
		return "%3.2f" % money + "k"
	elif money < 1000000000:
		money = snapped(money/1000000, 0.01)
		return "%3.2f" % money + "M"
	elif money < 1000000000000:
		money = snapped(money/1000000000, 0.01)
		return "%3.2f" % money + "B"
	elif money < 1000000000000000:
		money = snapped(money/1000000000000, 0.01)
		return "%3.2f" % money + "T"
	elif money < 1000000000000000000.0:
		money = snapped(money/1000000000000000.0, 0.01)
		return "%3.2f" % money + "q"
	#elif money < 1000000000000000000000.0:
		#money = snapped(money/1000000000000000000.0, 0.01)
		#return "%3.2f" % money + "Q"
	#elif money < 1000000000000000000000000.0:
		#money = snapped(money/1000000000000000000000.0, 0.01)
		#return "%3.2f" % money + "s"
	#elif money < 1000000000000000000000000000.0:
		#money = snapped(money/1000000000000000000000000.0, 0.01)
		#return "%3.2f" % money + "S"
	#elif money < 1000000000000000000000000000000.0:
		#money = snapped(money/1000000000000000000000000000.0, 0.01)
		#return "%3.2f" % money + "o"
	#elif money < 1000000000000000000000000000000000.0:
		#money = snapped(money/1000000000000000000000000000000.0, 0.01)
		#return "%3.2f" % money + "N"
	#elif money < 1000000000000000000000000000000000000.0:
		#money = snapped(money/1000000000000000000000000000000000.0, 0.01)
		#return "%3.2f" % money + "d"
	return "naneinf"
