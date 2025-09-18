extends Control

const RUN_SCENE = preload("res://scenes/run/run.tscn")

@export var music: AudioStream

@onready var login_panel: NinePatchRect = $LoginPanel
@onready var register_panel: NinePatchRect = $RegisterPanel
@onready var main_menu_panel: NinePatchRect = $MainMenuPanel

@onready var login_status_label: Label = $LoginPanel/MarginContainer/VBoxContainer/StatusLabel
@onready var register_status_label: Label = $RegisterPanel/MarginContainer/VBoxContainer/StatusLabel

@onready var login_email_line_edit: LineEdit = %LoginEmailLineEdit
@onready var login_password_line_edit: LineEdit = %LoginPasswordLineEdit

@onready var register_username_line_edit: LineEdit = %RegisterUsernameLineEdit
@onready var register_email_line_edit: LineEdit = %RegisterEmailLineEdit
@onready var register_password_line_edit: LineEdit = %RegisterPasswordLineEdit
@onready var register_repeat_password_line_edit: LineEdit = %RegisterRepeatPasswordLineEdit

func _ready():
	Firebase.Auth.login_succeeded.connect(_on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(_on_signup_succeeded)
	Firebase.Auth.login_failed.connect(_on_login_failed)
	Firebase.Auth.signup_failed.connect(_on_signup_failed)
	
	MusicPlayer.play(music)
	
	#if Firebase.Auth.check_auth_file():
		#print("LOGIN SUCCESS")
		#get_tree().change_scene_to_packed(MAIN_MENU_SCENE)

func go_main_menu():
	login_panel.hide()
	register_panel.hide()
	main_menu_panel.show()

func go_login_mode():
	login_status_label.text = ""
	register_panel.hide()
	login_panel.show()

func go_register_mode():
	register_status_label.text = ""
	login_panel.hide()
	register_panel.show()

func _on_login_button_pressed() -> void:
	var email = login_email_line_edit.text
	var password = login_password_line_edit.text
	Firebase.Auth.login_with_email_and_password(email, password)

func _on_register_button_pressed() -> void:
	go_register_mode()

func _on_signup_button_pressed() -> void:
	var email = register_email_line_edit.text
	var password = register_password_line_edit.text
	var password_repeat = register_repeat_password_line_edit.text
	
	if password != password_repeat:
		register_status_label.text = "Le password non corrispondono"
		register_password_line_edit.text = ""
		register_repeat_password_line_edit.text = ""
		return
	
	Firebase.Auth.signup_with_email_and_password(email, password)

func _on_go_to_login_button_pressed() -> void:
	go_login_mode()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(RUN_SCENE)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_login_succeeded(auth):
	print(auth)
	Firebase.Auth.save_auth(auth)
	go_main_menu()

func _on_signup_succeeded(auth):
	print(auth)
	Firebase.Auth.save_auth(auth)
	go_main_menu()

func _on_login_failed(error_code, message):
	print(error_code)
	print(message)
	login_status_label.text = message

func _on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	register_status_label.text = message
