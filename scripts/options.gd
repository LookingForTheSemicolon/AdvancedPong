class_name Options_Menu
extends Control

@onready var exit_button = $MarginContainer/VBoxContainer/ExitButton as Button

signal exit_options_menu

func _ready() -> void:
    exit_button.button_down.connect(on_exit_pressed)
    
    set_process(false)

func _process(_delta: float) -> void:
    exit_button.grab_focus()

func on_exit_pressed() -> void:
    exit_options_menu.emit()
    set_process(false)
