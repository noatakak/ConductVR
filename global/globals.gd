extends Node

# Boolean variable to tell if player is hosting
@export var host = true

@export var hosting_ip = ""

# Variable to store entered server IP
@export var joining_server_ip = ""

# Variable for player ID
@export var playerID = ""

# Variable for current playing piece
@export var currentPiece = ""

@export var currentMidi = ""

@export var resetScore = false

@export var newScore = false

@export var current_tempo: float = 0.0

@export var beat_pattern: int = 4
