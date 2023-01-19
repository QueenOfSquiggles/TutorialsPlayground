extends VBoxContainer

@export var web_json_path := ""
@export_file var local_json_path := ""

@onready var http := $HTTPRequest 
@onready var label_motd := $HBoxContainer/Label_MOTD

func _ready() -> void:
	http.request_completed.connect(_on_request_complete)
	
	var err = http.request(web_json_path)
	if err != OK:
		push_warning("Failed to create web request!")
	_publish_latest_data()

func _on_request_complete(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result == HTTPRequest.RESULT_SUCCESS:
		_publish_latest_data()
	else:
		print("Error code: %s" % str(result))

func _publish_latest_data() -> void:
	var file := FileAccess.open(local_json_path, FileAccess.READ)
	if file == null:
		return
	var data :Dictionary = JSON.parse_string(file.get_as_text())
	print(data)
	var motd = data["test-game"]["motd"]
	label_motd.text = motd
