extends CanvasLayer
@onready var dialogue: Label = $Dialogue
@onready var info_text: Label = $InfoText


# Called when the node enters the scene tree for the first time.
func showDialogue(Dialogue: String, Time: float):
	dialogue.text = Dialogue
	await get_tree().create_timer(Time).timeout
	dialogue.text = ""
	
func showInfoText(infoText: String, Time: float):
	info_text.text = infoText
	await get_tree().create_timer(Time).timeout
	info_text.text = ""
